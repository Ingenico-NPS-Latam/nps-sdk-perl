package soap_client;

use warnings;
use strict;

use lib qw(/home/denis/Documents/trunk/sdks/Perl/nps-sdk-perl/nps-sdk);
use configuration;
use utils;
use constants;
use errors;

use Data::Dumper;
use Data::Structure::Util qw( unbless );
$Data::Dumper::Terse = 1; 

use SOAP::Lite +trace => [ transport => sub {
    my ($http_object) = @_;
    if (ref($http_object) eq "HTTP::Request") {
      print('SOAP XML sent:'. utils->_mask_data($http_object->content) . "\n");
    } elsif (ref($http_object) eq "HTTP::Response") {
      print('SOAP XML Response:'. utils->_mask_data($http_object->content) . "\n");
    }
}];;

#Timeout https://blog.booking.com/socket-timeout-made-easy.html

my $connection = SOAP::Lite
	-> uri('https://sandbox.nps.com.ar/')
	-> proxy('https://sandbox.nps.com.ar/ws.php?wsdl')
    -> on_action(sub {sprintf '%s%s', @_});
	#soapversion('1.1');

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	$self->_setup();
	return $self;
}

sub setup {
	my $self = shift;
	my @plugings;
=pod
	if (defined $configuration::debug) {
		if (defined $configuration::log_file) {
			#Logic with logging module
		} else {
            #Another logic with logging module
        }

        if ($configuration::log_level eq #logging.DEBUG and $configuration::environment eq $constants::PRODUCTION_ENV) {
            LogException->error;
        }


        if ($configuration::log_level > #logging.DEBUG or $configuration::log_level == 0) {
            push to plugings MaskedLogPlugin  
        } else {
            push to plugings LogPlugin 
        }
	}

    my $session; # = request a session
    #mount the file to the session

    if (defined $configuration::proxy_url) {
        #add proxies to the session
        if (defined $configuration::proxy_user) {
            #make a HttpAuth to the session
        }
    }

    if (defined $configuration::certificate and defined $configuration::c_key) {
        #add cert to the session
    } else {
        #verify the cert of the session
    }
=cut
}

sub _soap_call {
    my ($class, $service, $ref_params) = @_;
    my $params = utils->add_extra_info($service, $ref_params);
    $params = utils->_check_sanitize(params=>$params, is_root=>1)
        if (defined $configuration::sanitize);
    $params = utils->add_secure_hash(configuration->secret_key, $params)
        if (!(exists $params->{"psp_ClientSession"}));
    my %req = (Requerimiento => $params);
    #print Dumper (\%req);
    my $result = $connection->$service(transform_params(%req))->result;
    my $response = unbless($result);
    return $response;
}

sub transform_params {
    my %params = @_;
    my @params;
    foreach my $key (keys %params) {
        my $item = SOAP::Data->name($key => $params{$key});
        push(@params, $item);
    }
    return @params;
}

1;
