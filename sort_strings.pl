#!/usr/bin/perl
#Zach Duncan
#COP 4342
#Assignment 5
#DUE 11/12/2020

#PROGRAM DESCRIPTION: Sort a list of lowercase strings (by given set of rules)

use strict;
use warnings;

#Check for valid command line arguments
my $num = scalar @ARGV;
if ($num != 1) {
    print "Usage: perl sort_strings.pl filename.txt\n";
    exit;
}

#Array to store file strings
my @strings = ();

#Read in line by line through the file
open(my $FH, '<', $ARGV[0]);
while (<$FH>) #while ($_ = <STDIN>)
{
  chomp;
  push (@strings, $_);
}

#Get number of @strings elements
my $strings_num = scalar @strings;

#Print array to make sure strings read in correctly
#foreach (@strings) {
#  print "$_\n";
#}

#Subroutine for sorting
sub by_substring {
  my $substring_a = $a;
  $substring_a =~ tr/bcdfghjklmnpqrstvqxyz//d;
  my $substring_b = $b;
  $substring_b =~ tr/bcdfghjklmnpqrstvqxyz//d;

  if ($substring_a lt $substring_b) {
    return -1;
  } elsif ($substring_a gt $substring_b) {
    return 1;
  } elsif ($a lt $b) {
    return -1;
  } elsif ($a gt $b) {
    return 1;
  } else {
    return 0;
  }
}

#call subroutine
my @sorted_array = sort by_substring @strings;

#iterate through new array and print
foreach (@sorted_array) {
  print "$_\n";
}
