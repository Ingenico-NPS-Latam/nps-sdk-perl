package nps;

use warnings;
use strict;

use lib qw(/home/denis/Documents/trunk/sdks/Perl/nps-sdk-perl/nps-sdk);
use soap_client;
use services;

our @ISA = qw(soap_client);

sub pay_online_2p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::PAY_ONLINE_2P, $params);
    return $resp;
}

sub authorize_2p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::AUTHORIZE_2P, $params);
    return $resp;
}

sub query_txs {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::QUERY_TXS, $params);
    return $resp;
}

sub simple_query_tx {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::SIMPLE_QUERY_TX, $params);
    return $resp;
}

sub refund {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::REFUND, $params);
    return $resp;
}

sub capture {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::CAPTURE, $params);
    return $resp;
}

sub authorize_3p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::AUTHORIZE_3P, $params);
    return $resp;
}

sub bank_payment_3p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::BANK_PAYMENT_3P, $params);
    return $resp;
}

sub bank_payment_2p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::BANK_PAYMENT_2P, $params);
    return $resp;
}

sub cash_payment_3p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::CASH_PAYMENT_3P, $params);
    return $resp;
}

sub change_secret_key {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::CHANGE_SECRET_KEY, $params);
    return $resp;
}

sub fraud_screening {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::FRAUD_SCREENING, $params);
    return $resp;
}

sub notify_fraud_screening_review {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::NOTIFY_FRAUD_SCREENING_REVIEW, $params);
    return $resp;
}

sub pay_online_3p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::PAY_ONLINE_3P, $params);
    return $resp;
}

sub split_authorize_3p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::SPLIT_AUTHORIZE_3P, $params);
    return $resp;
}

sub split_pay_online_3p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::SPLIT_PAY_ONLINE_3P, $params);
    return $resp;
}

sub query_card_number {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::QUERY_CARD_NUMBER, $params);
    return $resp;
}

sub get_iin_details {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::GET_IIN_DETAILS, $params);
    return $resp;
}

sub create_payment_method {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::CREATE_PAYMENT_METHOD, $params);
    return $resp;
}

sub create_payment_method_from_payment {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::CREATE_PAYMENT_METHOD_FROM_PAYMENT, $params);
    return $resp;
}

sub retrieve_payment_method {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::RETRIEVE_PAYMENT_METHOD, $params);
    return $resp;
}

sub update_payment_method {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::UPDATE_PAYMENT_METHOD, $params);
    return $resp;
}

sub delete_payment_method {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::DELETE_PAYMENT_METHOD, $params);
    return $resp;
}

sub create_customer {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::CREATE_CUSTOMER, $params);
    return $resp;
}

sub retrieve_customer {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::RETRIEVE_CUSTOMER, $params);
    return $resp;
}

sub update_customer {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::UPDATE_CUSTOMER, $params);
    return $resp;
}

sub delete_customer {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::DELETE_CUSTOMER, $params);
    return $resp;
}

sub recache_payment_method_token {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::RECACHE_PAYMENT_METHOD_TOKEN, $params);
    return $resp;
}

sub create_payment_method_token {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::CREATE_PAYMENT_METHOD_TOKEN, $params);
    return $resp;
}

sub retrieve_payment_method_token {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::RETRIEVE_PAYMENT_METHOD_TOKEN, $params);
    return $resp;
}

sub create_client_session {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::CREATE_CLIENT_SESSION, $params);
    return $resp;
}

sub get_installments_options {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::GET_INSTALLMENTS_OPTIONS, $params);
    return $resp;
}

sub split_pay_online_2p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::SPLIT_PAY_ONLINE_2P, $params);
    return $resp;
}

sub split_authorize_2p {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::SPLIT_AUTHORIZE_2P, $params);
    return $resp;
}

sub query_card_details {
    my ($self, $params) = @_;
    my $resp = $self->_soap_call($services::QUERY_CARD_DETAILS, $params);
    return $resp;
}

1;