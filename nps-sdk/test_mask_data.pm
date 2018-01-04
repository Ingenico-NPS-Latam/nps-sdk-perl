use strict;
use warnings;

use Data::Dumper;
use Data::UUID;

$Data::Dumper::Terse = 1; 

my $ug = Data::UUID->new();
my $uuid1 = $ug->create();

my $str = "
<psp_CardNumber>4161111111111111</psp_CardNumber><psp_CardNumber>4111111111112</psp_CardNumber>
<psp_CardSecurityCode>523</psp_CardSecurityCode><psp_CardSecurityCode>2425</psp_CardSecurityCode>
<psp_CardExpDate>3522</psp_CardExpDate><psp_CardExpDate>2345</psp_CardExpDate>
<Number>4161111111111111</Number><Number>4111111111112</Number>
<SecurityCode>523</SecurityCode><SecurityCode>2425</SecurityCode>
<ExpirationDate>3522</ExpirationDate><ExpirationDate>2345</ExpirationDate>
";

my $changed_str = _mask_data($str);

print $changed_str, "\n";


sub _mask_data {
	my $data = shift;
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