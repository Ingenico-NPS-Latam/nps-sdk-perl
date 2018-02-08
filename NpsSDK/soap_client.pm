package SoapClient;

use warnings; use strict;

use lib qw(/home/denis/Documents/trunk/sdks/Perl/nps-sdk-perl/nps-sdk /home/denis/Documents/trunk/sdks/Perl/nps-sdk-perl/test);
use configuration; use utils; use constants; use errors;

use Data::Dumper; use Data::Structure::Util qw( unbless ); $Data::Dumper::Terse = 1; 

my $connection; my $response; my $error;

sub _setup {
	my $self = shift;
	if (defined $Configuration::debug) { 
        LogException->error if ($Configuration::log_level eq $Constants::DEBUG and 
                                $Configuration::environment eq $Constants::PRODUCTION_ENV); 
    if ($Configuration::log_level > $Constants::DEBUG){
        eval {  require SOAP::Lite;
                SOAP::Lite->import(+trace => [ transport => sub {
                my ($http_object) = @_;
                Utils->masking_func($http_object, \&Utils::_mask_data);
                }]);
             }
        } else {
        eval {  require SOAP::Lite;
                SOAP::Lite->import(+trace => [ transport => sub {
                my ($http_object) = @_;
                Utils->masking_func($http_object, sub{return $_[0]});
                }]);
             }
        }
	} else {
        use SOAP::Lite;
        #*SOAP::Serializer::as_base64Binary = \&SOAP::XMLSchema2001::Serializer::as_string;
    }
    $connection = SOAP::Lite
        #-> service("https://sandbox.nps.com.ar/ws.php?wsdl")
        #-> uri("file:/". Configuration->get_wsdl)
        -> on_action(sub {sprintf '%s%s', @_})
        -> on_fault( sub {
            my ( $soap, $res ) = @_;
            if (index($res, "timeout") != -1) { $error = 1; }
            elsif (index($res, "connect") != -1) { $error = 2; }
        });

    if (defined $Configuration::proxy_url and defined $Configuration::proxy_user) {
        $connection -> proxy($Configuration::proxy_url, timeout => $Configuration::timeout);
        $connection -> transport -> credentials($Configuration::proxy_user => $Configuration::proxy_pass);
    } else {
        $connection -> proxy("https://sandbox.nps.com.ar", timeout => $Configuration::timeout);
    }

    if (defined $Configuration::certificate and defined $Configuration::c_key) {
        #add cert to the session
    } else {
        #verify the cert of the session
    }
}

sub soap_call {
    my ($class, $service, $ref_params) = @_;
    _setup();
    my $params = Utils->add_extra_info($service, $ref_params);
    $params = Utils->_check_sanitize(params=>$params, is_root=>1)
        if (defined $Configuration::sanitize);
    $params = Utils->add_secure_hash($Configuration::secret_key, $params)
        if (!(exists $params->{"psp_ClientSession"}));
    my %req = ("Requerimiento" => $params);
    #print Dumper (\%req);
    eval {$response = $connection->$service(transform_params(%req));};
    if (defined $error) {
        if ($error == 1) {
            return TimeoutException->new();
        } elsif ($error == 2 ) {
            return ConnectionException->new();
        }
    } else {
        my $result = Utils->encode_params(unbless($response->result));
        return $result;
    }
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

