#!/usr/bin/perl

#PROGRAM DESCRIPTION:
#Determine if an input string is a palindrome or not
#Ignore character case and ignore newlines
#When input string is "quit," program will terminate

use strict;
use warnings;

my $name;

#While we receive input from STDIN, evaluate whether that input is a palindrome
do
{
	print "Please input a string: "; #Ask for input

	$name = lc(<STDIN>); #Read in
	chomp $name; #Get rid of newline

	if ($name ne "quit") #Check if it's a palidrome, unless the string is "quit"
	{
		#Split up a string into an array of characters separated by spaces
		my @check = split(//, $name);
		#print "@check\n";
		my @pal = reverse(@check); #Make an array that is reverse of check
		#print "@pal\n";

		my $length = scalar @check; #Get length of check array
		for (my $i = 0; $i < $length; $i++) #Iterate through check array
		{
			if ($check[$i] ne $pal[$i]) { #If any character in check mismatches that of
																		#of pal, it is not a palindrome
				print "\"$name\" is not a palindrome.\n";
				last;
			}
			if ($i == $length - 1) { #Otherwise, on last iteration it must be a palindrome
				print "\"$name\" is a palindrome.\n";
			}
		}#End of for loop
	}#End of if statement
}while ($name ne "quit");
