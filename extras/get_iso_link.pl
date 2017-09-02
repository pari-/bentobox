#!/usr/bin/env perl

use warnings;
use strict;
use JSON::XS;

#
# parse the bento packer template
#
my $json;
open( my $fh, '<', $ARGV[0] ) or die $!;
$json = decode_json(
    do { local $/; <$fh> }
);
close($fh);

#
# return the link of the template's ISO file
#
print sprintf( qq{%s/%s/%s},
    $json->{'variables'}->{'mirror'},
    $json->{'variables'}->{'mirror_directory'},
    $json->{'variables'}->{'iso_name'} );
