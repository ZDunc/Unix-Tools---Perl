# Unix-Tools---Perl
Unix Tools coursework - Perl

## (1) Change filename extension program
### PROGRAM DESCRIPTION -- Recursively change all file extensions in a directory of command line argument old_extension to argument new_extension
- change_extension.pl

## (2) Determine palindrome program
### PROGRAM DESCRIPTION -- Determine if an input string is a palindrome or not. Ignore character case and ignore newlines. When input string is "quit," program will terminate
- palindrome.pl

## (3) Sort strings program
### PROGRAM DESCRIPTION -- Sort a list of lowercase strings (by given set of rules)
- sort_strings.pl

## (4) Determine word count program
### PROGRAM DESCRIPTION -- Implement a word count program to report the size of the file in three aspects: the number of characters in the file, the number of words in the file, and the number of line of the file. Also, report the number of times that each unique word appears in the file. And report words in ascending ASCII code order
- word_count.pl

## (5) Exploration of Socket Programming (Client/Server program in folder)
### PROGRAM DESCRIPTION -- 
### - The client program should first ask the user to enter username and password, and then send them to the server. If the server responds negatively (username and password do not match), the client will close the connection and exit the program. You can decide what message means a  negative  response  from  the  server.  At  the  server  side,  the  server  will  first  verify  the  username and password after a connection is established. If username and password do not match  what  the  server  has  in  the  username/password  file,  the  server  sends  a  negative message to the client and closes the connection. Otherwise, the server proceeds to communicate with client further. 
### - The  username/password  file  maintained  by  the  server  stores  the  username  and  the  MD5 (more precisely, the md5_base64) digest of the real user password. When a server receives a pair of username and password, it will first convert the received password into its md5_base64 digest, and then compare with the stored password digest of the corresponding username to determine if they match. 
### - If the username and password verification is successful at the server side, the client program should continue read the user input line by line, until the user types “quit”, or end-of-file is encountered, or the program is killed. 
### - Instead  of  arbitrary  strings,  what  a  user  types  will  be  Unix  command-line  commands,  for example, “ls”, “who”, and “ps”. In our test, we will only test simple commands like these, which will produce all outputs and then terminates. In particular, we will not test programs such as “top”, which will continue run. 
### - At the server side, (after the username/password verification step), instead of simply echoing back the received string, it should treat it as a Unix command-line command, and run it. The output of the command will be sent back to the client. 
### - The  server  should  be  implemented  as  a  concurrent  server;  that  is,  upon  each  connection being  accepted,  a  child process will  be  created  to  interact  with the  client (verify  username and password, read command from client, run the command, and send back the result, and so on) with the accepted socket. The parent process should continue to accept new connection requests using the listen socket. 
### - The server program will take two command-line arguments, the server port number, and the username/password file (which stores the username and MD5_base64 digest of the corresponding password). Each line of the username/password file contains the username and the MD5_base64 digest of the corresponding password, separately by a whitespace. 
### - The client program will take two command-line arguments, the server IP address or hostname, and the port number of the server.

- client.pl
- server.pl
- sample_userfile.txt
