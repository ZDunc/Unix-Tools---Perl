#!/usr/bin/perl

#PROGRAM DESCRIPTION: Implement a word count program to report the size of the
#file in three aspects: the number of characters in the file, the number of
#words in the file, and the number of line of the file. Also, report the number
#of times that each unique word appears in the file. And report words in
#ascending ASCII code order

use strict;
use warnings;

#Check for valid command line arguments
my $num = scalar @ARGV;
if ($num != 1) {
    print "Usage: perl word_count.pl filename.txt\n";
    exit;
}

#Variable declarations
my %hash;
my $character_count = 0;
my $word_count = 0;
my $line_count = 0;
my $word;

#Read in line by line through the file
open(my $FH, '<', $ARGV[0]);
while (<$FH>) #while ($_ = <STDIN>)
{
  $line_count++; #Update line count
  $character_count+= length($_); #Update character count
  chomp; #chomp $_
  #print "$_\n";

  my @word_array = split(' ', $_);
  #print "@word_array\n";

  foreach my $i (@word_array) #Iterate through @word_array
  {
    $word_count++; #Update word_count
    if (! exists ($hash{$i})) {
      $hash{$i} = 1; #Create hash element, word with value of 1
    }
    else {
      $hash{$i}++; #When key appears more than once, increment value
    }
  }
}

#OUTPUT
print "Number of characters: $character_count\n";
print "Number of words: $word_count\n";
print "Number of lines: $line_count\n";
print "Frequency of words in the file:\n";
print "--------------------------------\n";
foreach my $key (sort(keys %hash)){
  my $value = $hash{$key};
  print "$key: $value\n";
}
