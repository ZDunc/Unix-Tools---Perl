#!/usr/bin/perl -w

use warnings;
use strict;

use Digest::MD5  qw(md5 md5_hex md5_base64);

my $user = "zachduncan";
my $password = "success?";
print "$user\n";
print "$password\n";

my $digest = md5_base64($password);
print "$digest\n";
