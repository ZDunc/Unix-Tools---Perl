#!/usr/bin/perl
# echo server
# use program_name port_number

use strict;
use warnings;
use IO::Socket; # for socket programming
use Digest::MD5  qw(md5 md5_hex md5_base64); # for password encryption

#Check for appropriate number of arguements
@ARGV == 2 || die "$0 port user/password_file\n";
my ($port, $file) = @ARGV;

#Array will store strings of each line in user/password_file
my @array;
open(my $FH, '<', $ARGV[1]);
while (<$FH>) #while ($_ = <STDIN>)
{
  chomp;
  push (@array, $_);
}
close($FH);

#foreach(@array) {
#  print;
#}

# create a server socket
my $socket = IO::Socket::INET->new(
	# don't specify LocalAddr.
	# In default, it will use INADDR_ANY
	# so that we can bind to any ip address
	# of the server machine
	LocalPort 	=> $port,
	Proto		=> 'tcp',
	Listen		=> 5
);

# check if socket has been created successfully
die "socket: $!\n" unless defined($socket);

# accept one connection and process it
while (my $newsock = $socket->accept()) {
	# $socket: normally referred to as listen socket
	# $newsock: normally referred to as connected socket or accepted socket
  $newsock->autoflush(1); # do not buffer output
	print "One connection is established.\n";

  #CREATE CHILD PROCESS
  my $pid = fork();
  if ($pid == 0) {

    close $socket;

    #Get username and password from client
    my $user = <$newsock>;
    chomp($user);
    my $password = <$newsock>;
    chomp($password);
    $password = md5_base64($password);

    my $success = 0; #bool, if user and password match, change to 1

    foreach (@array) { #For each line in user/password file
      my $temp = $_;
      #print $temp;
      my @temp = split(' ', $temp); #Split so user is stored in $temp[0] and password in $temp[1]
      #print "$temp[0] ";
      #print "$temp[1] ";

      #If any usernames and encryped passwords match a line, then there is a success
      if (($temp[0] eq $user) && ($temp[1] eq $password)) {
        $success = 1;
        last;
      }
    }

    if ($success == 1) { #In the case we continue
      print "Password is OK.\n";
      #print $success;
      $newsock->send("1");
      #print $newsock "1";

      #Loop while receiving new input from client
      while (defined(my $msg = <$newsock>)) {
        chomp $msg;
        system ("$msg > temp__file.txt"); #Make input a Unix command and redirect to a temp file
        my $temp = 1;
        my $counter = `wc -l temp__file.txt | awk '{print \$$temp}'`; #Get number of lines for that file
        #print $counter;
        print $newsock $counter; #Send number of lines to the client

        #Iterate through temp file, line by line
        open(my $FH, '<', "temp__file.txt");
        while (<$FH>) {
          print $newsock $_; #Send each line to the client
        }
        close($FH);
        system ("rm temp__file.txt"); #Then remove the temp file
      }
    } #END OF VALID PASSWORD CASE
      else {
        print "Invalid password.\n";
        $newsock->send("0");
      }
      exit(0); #Exit becuase this is a child process
} #END OF CHILD PROCESS
else {
	  close $newsock;
	  print "Connection connection has been disconnected\n";
  }
}
