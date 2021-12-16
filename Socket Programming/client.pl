#!/usr/bin/perl
# echo client
# prog server port

use strict;
use warnings;
use IO::Socket; # for socket programming

#Check for appropriate number of arguements
@ARGV == 2 || die "Usage: $0 server/hostname port\n";
my ($server, $port) = @ARGV;

print "$server $port\n";

# create a socket
my $socket = IO::Socket::INET->new(
	PeerAddr	=> $server,
	PeerPort 	=> $port,
	Proto		=> 'tcp'
);

# check if socket has been created
die "socket: $!\n" unless defined($socket);

# at this point, we should have a connected socket

# do not buffer output
$socket->autoflush(1);

# Ask user to enter username and password
$| = 1;
print "Username: ";
my $user = <STDIN>;
print $socket $user; #Send user to server
print "Password: ";
my $password = <STDIN>;
print $socket $password; #Send password to server

$socket->recv(my $success, 1); #Get back whether user/password was successful or not
                               #Here, success is 1, anything else is failure
#In the case of failure
if ($success != 1) {
  $| = 1;
  print "Invalid password. Aborting.\n";
  close($socket);
  exit 1; #End the program
}

my $msg;
my $newmsg;
my $counter;
print "MSG TO CLIENT: ";
while (defined($msg = <STDIN>)) { #Loop until user enters "quit" or program is killed

  if ($msg =~ /^quit/i) {
		last; #End loop is we get "quit"
	}

	# send to server
  $| = 1;
	print $socket $msg; #Send msg to server
  $| = 1;
  print "MSG FROM SERVER:\n";
  $| = 1;
  $counter = <$socket>; #REad in how many lines server will send back (counter)
  #print "$counter";
  my $my_counter = 0;
  while($my_counter != $counter) { #Until we reach counter
    if (! defined($newmsg = <$socket>)) { #Read line in
      last;
    }
    $| = 1;
    print $newmsg; #And print it
    $my_counter++; #increment $my_counter
  }

	# connection closed by server
	last unless defined($newmsg);

  $| = 1;
  print "MSG TO CLIENT: ";
}
close($socket);
