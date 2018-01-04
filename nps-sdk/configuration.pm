package configuration;

use warnings;
use strict;
use Carp;
 
use lib qw(/home/denis/Documents/trunk/sdks/Perl/nps-sdk-perl/nps-sdk);
use constants;
use errors;

our ($environment, $secret_key, $debug, $timeout, $log_level, $proxy_url, $proxy_user, $certificate, $c_key, $sanitize);


sub configure {
    my $self = shift;
    my %params = (@_);
    $environment = $params{environment};
    $secret_key = $params{secret_key};
    $sanitize = $params{sanitize} if defined $params{sanitize};
    $debug = $params{debug} if defined $params{debug};
    $timeout = $params{timeout} if defined $params{timeout};
    $log_level = $params{log_level} if defined $params{log_level};
    $proxy_url = $params{proxy_url} if defined $params{proxy_url};
    $proxy_user = $params{proxy_user} if defined $params{proxy_user};
    $certificate = $params{certificate} if defined $params{certificate};
    $c_key = $params{cert_key} if defined $params{cert_key};
    return;
}

sub get_wsdl {
    croak "The index cannot be less than 0" if($environment < 0);
    my @envs = ($constants::_PRODUCTION_URL,
                $constants::_STAGING_URL,
                $constants::_SANDBOX_URL,
                $constants::_DEVELOPMENT_URL);
    return $envs[$environment] if $envs[$environment]; 
    EnvironmentNotFound->error;
}

sub environment { $environment }
sub secret_key { $secret_key }
sub debug { $debug }
sub timeout { $timeout }
sub log_level { $log_level }

1;