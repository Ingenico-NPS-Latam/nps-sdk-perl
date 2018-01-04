use warnings;
use strict;

use XML::LibXML; #http://search.cpan.org/~pajas/XML-LibXML/LibXML.pod
use XML::Simple; # From ref_hash to xml
#use XML::Hash; From xml to hash http://search.cpan.org/~braceta/XML-Hash-0.95/lib/XML/Hash.pm
#use XML::XML2JSON; From xml to JSON http://search.cpan.org/~ken/XML-XML2JSON-0.06/lib/XML/XML2JSON.pm
#use XML::Parser; From xml to string https://ubuntuforums.org/archive/index.php/t-1292812.html
 
use Data::Dumper;
use Data::Structure::Util qw( unbless );
use SOAP::Lite on_action => sub {sprintf '%s%s', @_};
$Data::Dumper::Terse = 1; 

my $text = "
<psp_CardNumber>4161111111111111</psp_CardNumber><psp_CardNumber>4111111111112</psp_CardNumber>
<psp_CardSecurityCode>523</psp_CardSecurityCode><psp_CardSecurityCode>2425</psp_CardSecurityCode>
<psp_CardExpDate>3522</psp_CardExpDate><psp_CardExpDate>2345</psp_CardExpDate>
<Number>4161111111111111</Number><Number>4111111111112</Number>
<SecurityCode>523</SecurityCode><SecurityCode>2425</SecurityCode>
<ExpirationDate>3522</ExpirationDate><ExpirationDate>2345</ExpirationDate>
";

my $xml = _parse_to_xml($text);

print Dumper $xml;

sub _parse_to_xml {
	my $text = shift;
	my $parser = XML::LibXML->new();
	my $xml = $parser->parse_string($text);
	# Parse to string: my $formatted_xml = $xml->toString(1);
	return $xml;
}