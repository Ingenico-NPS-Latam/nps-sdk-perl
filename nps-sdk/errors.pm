package TransactionException;
use warnings;
use strict;
use Encode qw(encode);

our $_resp_code;
our $_resp_msg;
our $_resp_msg_ext;
our $response;

sub new {
    my $self = shift;
    $response = shift;
    $_resp_code = encode_utf8($response->{psp_ResponseCod}); 
    $_resp_msg = encode_utf8($response->{psp_ResponseMsg}); 
    $_resp_msg_ext = encode_utf8($response->{psp_ResponseExtended}); 
    # Averiguar si tenemos que retornar el mensaje para poder mostrarlo con los demas metodos.
    print "
    Mensaje de respuesta: $_resp_code
    Codigo de respuesta: $_resp_msg;
    Respuesta extendida: $_resp_msg_ext;
    \n";
}

sub get_message {
    my $self = shift;
    return $_resp_msg;
}

sub get_extended_message {
    my $self = shift;
    return $_resp_msg_ext;
}

sub get_raw_response {
    my $self = shift;
    return $response;
}

package RejectedException;
our @ISA = qw(TransactionException);

package DeclinedException;
our @ISA = qw(TransactionException);

package LogException;
use warnings;
use strict;

sub error {
    print "DEBUG level is not allowed om PRODUCTION ENVIRONMENT \n";
}

package EnvironmentNotFound;
use warnings;
use strict;

sub error {
    print "
        El ambiente seleccionado es invalido.
        Los ambientes validos son los siguientes:
        0: PRODUCCION
        1: STAGING
        2: SANDBOX        
        \n";
}
1;