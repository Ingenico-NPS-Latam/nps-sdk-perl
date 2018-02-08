package TransactionException;
use warnings; use strict;

our ($resp_code, $resp_msg, $resp_msg_ext, $response);

sub new {
    my $self = shift;
    $response = @_;
    $resp_code = $response->{psp_ResponseCod}; 
    $resp_msg = $response->{psp_ResponseMsg}; 
    $resp_msg_ext = $response->{psp_ResponseExtended};
    die "
    Mensaje de respuesta: $resp_code
    Codigo de respuesta: $resp_msg
    Respuesta extendida: $resp_msg_ext
    \n";
}

sub get_message { return $resp_msg; }

sub get_extended_message { return $resp_msg_ext; }

sub get_raw_response { return $response; }

package RejectedException;
our @ISA = qw(TransactionException);

package DeclinedException;
our @ISA = qw(TransactionException);

package TimeoutException;
sub new { 
    my $self = {};
    bless ($self, "TimeoutException");
    print "Timeout Error\n";
    return $self;
}

sub get_message_error {
    my $self = shift;
    return "Se produjo un error de timeout.";
}

sub get_code_error {
    my $self = shift;
    return 1;
}

1;

package ConnectionException;
sub new { 
    my $self = {};
    bless ($self, "ConnectionException");
    print "Connection Error\n";
    return $self;

}

sub get_message_error {
    my $self = shift;
    return "No se pudo conectar al servidor.";
}

sub get_code_error {
    my $self = shift;
    return 2;
}

1;

package LogException;
sub error { die "DEBUG level is not allowed on PRODUCTION ENVIRONMENT \n";}

package EnvironmentNotFound;
sub error {
    die "
        El ambiente seleccionado es invalido.
        Los ambientes validos son los siguientes:
        0: PRODUCCION
        1: STAGING
        2: SANDBOX        
        \n";
}

1;