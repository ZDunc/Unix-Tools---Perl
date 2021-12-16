#!/usr/bin/perl

#PROGRAM DESCRIPTION: Recursively change all file extensions in a directory of
#command line argument old_extension and new_extension

use strict;
use warnings;

#Check for valid command line arguments
my $num = scalar @ARGV;
if ($num != 3) {
    print "Usage: perl change_extension.pl directory_name old_extension new_extension\n";
    exit;
}

#Check if directory exists
if (! -e $ARGV[0] || ! -d $ARGV[0]) {
  print "Directory cannot be located. Exiting program.\n";
}

#Store old extension and new extension from command line arguments
my $old_extension = $ARGV[1];
my $new_extension = $ARGV[2];
#print "$old_extension $new_extension\n";

# Pass in directory
sub change_extension {        #DERIVED FROM CLASS CODE!
  my $temp = $_[0];           #$temp will store current directory
  #print $_[0];
  #print ": \n";
  opendir (DIR, $temp);       #open directory
  my @files = readdir DIR;    #read into an array
  closedir DIR;               #close directory
  foreach my $file (@files) { #iterate through files in directory
    if ($file eq "." || $file eq "..") {        #ignore cases of . and ..
      next;
    }
    if (-d "$temp/$file") {                     #Recursive call if directory
      change_extension("$temp/$file");
      next;
    }
  	next unless $file =~ /\.$old_extension$/;   #Ignore unless file ends with old_ext
  	$file = $temp . "/" . $file;                #Concatenate dir/filename
  	my $newfile = $file;                        #Store in $newfile
    #print "$newfile ";
    $newfile =~ s/\.$old_extension$/\.$new_extension/; #change file ext
    #print "$newfile ";
  	rename $file, $newfile;                     #Rename iterated file
  }
}

change_extension($ARGV[0]); #Subroutine call with user-inputted directory
