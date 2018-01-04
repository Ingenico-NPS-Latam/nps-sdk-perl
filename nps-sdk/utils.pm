package utils;

use warnings;
use strict;

use Digest::MD5 qw(md5 md5_hex md5_base64);

use lib qw(/home/denis/Documents/trunk/sdks/Perl/nps-sdk-perl/nps-sdk);
use services;
use configuration;
use constants;

use Data::Dumper;
use Data::Structure::Util qw( unbless );
use SOAP::Lite on_action => sub {sprintf '%s%s', @_};
$Data::Dumper::Terse = 1; 

sub add_extra_info {
	my ($self, $service, $ref_params) = @_;
	my %params = %{$ref_params};
    my %hash_merch_services = map {$_ => 1} @services::get_merch_det_not_add_services;
    if(exists($hash_merch_services{$service})) {
        return \%params;
    }
    my %info = (
        SdkInfo => join " ", $constants::LANGUAGE, $constants::VERSION,
    );
    my $merch_details_key = "psp_MerchantAdditionalDetails";
    if(exists($params{$merch_details_key})) {
        $params{$merch_details_key}{SdkInfo} = $info{SdkInfo};
    } else {
        $params{$merch_details_key} = \%info;
    }
    return \%params;
}

sub add_secure_hash {
	my ($class, $secret_key, $ref_params) = @_;
	delete $ref_params->{"psp_SecureHash"} if (exists $ref_params->{"psp_SecureHash"});
    my $secure_hash = create_secure_hash($secret_key, $ref_params);
    $ref_params->{"psp_SecureHash"} = $secure_hash;
    return $ref_params;
}

sub create_secure_hash {
	my ($secret_key, $ref_params) = @_;
    my %params = %{$ref_params};
    return md5_hex(order_collection(%params) . $secret_key);
}

sub order_collection {
    my %collection = @_;
    my @ord_keys;
    my @values;
    foreach my $name (sort keys %collection) {
        push @ord_keys, $name;
    }
    foreach (@ord_keys) {
        if(ref($collection{$_}) ne "HASH" and ref($collection{$_}) ne "ARRAY") {
            push @values, ($collection{$_});
        }
    }
    my $concatenated_data = join("", @values);
    return $concatenated_data;
}

sub _check_sanitize {
	my $self = shift;
	my $ref_args = (ref $_[0] eq 'HASH') ? shift : { @_ };
    my %params = %{$ref_args->{params}};
    my $is_root = $ref_args->{is_root} || 0;
    my $nodo = $ref_args->{nodo} || 0;
	my %result_params;
	if($is_root == 1) {
		%result_params = ();
	} else {
		%result_params = %params;
	}	

	while ((my $key, my $value) = each (%params)) {
		if (ref($value) eq "HASH") {
			$result_params{$key} = utils->_check_sanitize(params=>$value, nodo=>$key);
        } elsif (ref($value) eq "ARRAY") {
			$result_params{$key} = _check_sanitize_array(params=>$value, nodo=>$key);
        } else {
			$result_params{$key} = _validate_size(value=>$value, key=>$key, nodo=>$nodo);
        }
	}

	return \%result_params;
}

sub _check_sanitize_array {
	my $ref_args = (ref $_[0] eq 'HASH') ? shift : { @_ };
    my @params = @{$ref_args->{params}};
    my $nodo = $ref_args->{nodo};
	my @result_params;
	
	foreach my $param (@params) {
		push @result_params, utils->_check_sanitize(params=>$param, nodo=>$nodo);
	}
	return \@result_params;
}

sub _validate_size {
	my $ref_args = (ref $_[0] eq 'HASH') ? shift : { @_ };
	my $key_name;
	if ($ref_args->{nodo} ne 0) {
		$key_name = $ref_args->{nodo} . "." . $ref_args->{key} . ".max_length";
	} else {
		$key_name = join(".", $ref_args->{key},"max_length");
	}
    if (exists $constants::SANITIZE{$key_name}) {
        return "" . substr($ref_args->{value}, 0, $constants::SANITIZE{$key_name});
    } 
    return $ref_args->{value};
}

sub _mask_data {
	my ($self, $data) = @_;
	$data = _mask_card_number($data);
	$data = _mask_exp_date($data);
	$data = _mask_cvc($data);
	$data = _mask_tokenization_card_number($data);
	$data = _mask_tokenization_exp_date($data);
	$data = _mask_tokenization_cvc($data);
	
	return $data;
}

# CARD NUMBERS

sub _mask_card_number {
	my $data = shift;
	my $card_number_key = "</psp_CardNumber>";
	my @card_numbers = _find_card_numbers($data, $card_number_key);
	return replace_card_numbers($data, \@card_numbers, $card_number_key);
}

sub _mask_tokenization_card_number {
	my $data = shift;
	my $card_number_key = "</Number>";
	my @card_numbers = _find_card_numbers($data, $card_number_key);
	return replace_card_numbers($data, \@card_numbers, $card_number_key);
}

sub _find_card_numbers {
	my ($data, $key) = @_;
	my @card_numbers = ($data =~ /(\d{13,19}$key)/g);
	return @card_numbers;
}

sub replace_card_numbers {
	my ($data, $ref_array, $card_number_key) = @_;
	my @card_numbers = @{$ref_array};
	foreach my $card_number (@card_numbers) {
		my $final_len = length($card_number) - length($card_number_key);
		my $card_number_len = length(substr($card_number, 0, $final_len));
		my $masked_chars = "*"x($card_number_len - 10);
		my $head_card = substr($card_number, 0, 6);
		my $tail_card = substr($card_number, length($card_number) - 4 - length($card_number_key), length($card_number));
		my $new_card_number = join("", $head_card, $masked_chars, $tail_card);
		$data =~ s/\Q$card_number\E/$new_card_number/g;
	}
	return $data;
}

# EXP DATE

sub _mask_exp_date {
	my $data = shift;
	my $exp_date_key = "</psp_CardExpDate>";
	my @exp_dates = _find_exp_date($data, $exp_date_key);
	return replace_exp_dates($data, \@exp_dates, $exp_date_key);
}

sub _mask_tokenization_exp_date {
	my $data = shift;
	my $exp_date_key = "</ExpirationDate>";
	my @exp_dates = _find_exp_date($data, $exp_date_key);
	return replace_exp_dates($data, \@exp_dates, $exp_date_key);
}

sub _find_exp_date {
	my ($data, $key) = @_;
	my @exp_dates = ($data =~ /(\d{4}$key)/g);
	return @exp_dates;
}

sub replace_exp_dates {
	my ($data, $ref_array, $exp_date_key) = @_;
	my @exp_dates = @{$ref_array};
	foreach my $exp_date (@exp_dates) {
		my $new_exp_date = join("", "****", $exp_date_key);
		$data =~ s/\Q$exp_date\E/$new_exp_date/g;
	}
	return $data;
}

# CVC 

sub _mask_cvc {
	my $data = shift;
	my $cvc_key = "</psp_CardSecurityCode>";
	my @cvcs = _find_cvc($data, $cvc_key);
	return replace_cvcs($data, \@cvcs, $cvc_key);
}

sub _mask_tokenization_cvc {
	my $data = shift;
	my $cvc_key = "</SecurityCode>";
	my @cvcs = _find_cvc($data, $cvc_key);
	return replace_cvcs($data, \@cvcs, $cvc_key);
}

sub _find_cvc {
	my ($data, $key) = @_;
	my @cvcs = ($data =~ /(\d{3,4}$key)/g);
	return @cvcs;
}

sub replace_cvcs {
	my ($data, $ref_array, $cvc_key) = @_;
	my @cvsc = @{$ref_array};
	foreach my $cvc (@cvsc) {
		my $final_len = length($cvc) - length($cvc_key);
		my $masked_chars = "*"x(length(substr($cvc, 0, $final_len)));
		my $new_cvc = join("", $masked_chars, $cvc_key);
		$data =~ s/\Q$cvc\E/$new_cvc/g;
	}
	return $data;
}

#In progress
sub _parse_to_xml {
	my $text = shift;
	my $parser = XML::LibXML->new();
	my $xml = $parser->parse_string($text);
	# Parse to string: my $formatted_xml = $xml->toString(1);
	return $xml;
}



1;