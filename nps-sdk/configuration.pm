package Configuration;

use warnings; use strict;
 
use lib qw(/home/denis/Documents/trunk/sdks/Perl/nps-sdk-perl/nps-sdk);
use constants; use errors;

our ($logger, $environment, $secret_key, $debug, $timeout, $log_level, $log_file,
     $proxy_url, $proxy_port, $proxy_user, $proxy_pass, $certificate, $c_key, $sanitize);

sub configure {
    my $self = shift;
    my %params = (@_);
    $logger = $params{logger};
    $environment = $params{environment};
    $secret_key = $params{secret_key};
    $sanitize = $params{sanitize} if defined $params{sanitize};
    $debug = $params{debug} if defined $params{debug};
    $timeout = $params{timeout} ? $params{timeout} : 60;
    $log_level = $params{log_level} if defined $params{log_level};
    $log_file = $params{log_file} if defined $params{log_file};
    $proxy_url = $params{proxy_url} if defined $params{proxy_url};
    $proxy_port = $params{proxy_port} if defined $params{proxy_port};
    $proxy_user = $params{proxy_user} if defined $params{proxy_user};
    $proxy_pass = $params{proxy_pass} if defined $params{proxy_pass};
    $certificate = $params{certificate} if defined $params{certificate};
    $c_key = $params{cert_key} if defined $params{cert_key};
    return;
}

sub get_wsdl {
    die "The index cannot be less than 0" if($environment < 0);
    my @envs = ($Constants::_PRODUCTION_URL,
                $Constants::_STAGING_URL,
                $Constants::_SANDBOX_URL,
                $Constants::_DEVELOPMENT_URL);
    return $envs[$environment] if $envs[$environment]; 
    EnvironmentNotFound->error;
}

1;