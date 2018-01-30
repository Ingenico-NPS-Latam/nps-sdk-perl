package Nps;

use warnings; use strict;

use lib qw(/home/denis/Documents/trunk/sdks/Perl/nps-sdk-perl/nps-sdk);
use soap_client; use services;

our @ISA = qw(SoapClient);

sub pay_online_2p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::PAY_ONLINE_2P, $params);
    return $resp;
}

sub authorize_2p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::AUTHORIZE_2P, $params);
    return $resp;
}

sub query_txs {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::QUERY_TXS, $params);
    return $resp;
}

sub simple_query_tx {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::SIMPLE_QUERY_TX, $params);
    return $resp;
}

sub refund {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::REFUND, $params);
    return $resp;
}

sub capture {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::CAPTURE, $params);
    return $resp;
}

sub authorize_3p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::AUTHORIZE_3P, $params);
    return $resp;
}

sub bank_payment_3p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::BANK_PAYMENT_3P, $params);
    return $resp;
}

sub bank_payment_2p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::BANK_PAYMENT_2P, $params);
    return $resp;
}

sub cash_payment_3p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::CASH_PAYMENT_3P, $params);
    return $resp;
}

sub change_secret_key {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::CHANGE_SECRET_KEY, $params);
    return $resp;
}

sub fraud_screening {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::FRAUD_SCREENING, $params);
    return $resp;
}

sub notify_fraud_screening_review {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::NOTIFY_FRAUD_SCREENING_REVIEW, $params);
    return $resp;
}

sub pay_online_3p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::PAY_ONLINE_3P, $params);
    return $resp;
}

sub split_authorize_3p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::SPLIT_AUTHORIZE_3P, $params);
    return $resp;
}

sub split_pay_online_3p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::SPLIT_PAY_ONLINE_3P, $params);
    return $resp;
}

sub query_card_number {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::QUERY_CARD_NUMBER, $params);
    return $resp;
}

sub get_iin_details {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::GET_IIN_DETAILS, $params);
    return $resp;
}

sub create_payment_method {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::CREATE_PAYMENT_METHOD, $params);
    return $resp;
}

sub create_payment_method_from_payment {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::CREATE_PAYMENT_METHOD_FROM_PAYMENT, $params);
    return $resp;
}

sub retrieve_payment_method {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::RETRIEVE_PAYMENT_METHOD, $params);
    return $resp;
}

sub update_payment_method {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::UPDATE_PAYMENT_METHOD, $params);
    return $resp;
}

sub delete_payment_method {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::DELETE_PAYMENT_METHOD, $params);
    return $resp;
}

sub create_customer {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::CREATE_CUSTOMER, $params);
    return $resp;
}

sub retrieve_customer {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::RETRIEVE_CUSTOMER, $params);
    return $resp;
}

sub update_customer {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::UPDATE_CUSTOMER, $params);
    return $resp;
}

sub delete_customer {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::DELETE_CUSTOMER, $params);
    return $resp;
}

sub recache_payment_method_token {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::RECACHE_PAYMENT_METHOD_TOKEN, $params);
    return $resp;
}

sub create_payment_method_token {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::CREATE_PAYMENT_METHOD_TOKEN, $params);
    return $resp;
}

sub retrieve_payment_method_token {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::RETRIEVE_PAYMENT_METHOD_TOKEN, $params);
    return $resp;
}

sub create_client_session {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::CREATE_CLIENT_SESSION, $params);
    return $resp;
}

sub get_installments_options {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::GET_INSTALLMENTS_OPTIONS, $params);
    return $resp;
}

sub split_pay_online_2p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::SPLIT_PAY_ONLINE_2P, $params);
    return $resp;
}

sub split_authorize_2p {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::SPLIT_AUTHORIZE_2P, $params);
    return $resp;
}

sub query_card_details {
    my ($self, $params) = @_;
    my $resp = $self->soap_call($Services::QUERY_CARD_DETAILS, $params);
    return $resp;
}

1;