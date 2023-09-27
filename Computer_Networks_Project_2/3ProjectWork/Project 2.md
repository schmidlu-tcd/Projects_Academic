# Project 2
## Decentralised Network for Humanitarian Workers

A setup of a peer to peer network with File Transfer Protocol and encryption on sent files for intermittent communication for humanitarian workers in conflict zones. This implementation has been carried out in C programming language. The following README will detail the following:

- Libraries used in the code
- Set up
- Compilation
- Running the code
- How to Test


### Required Libraries 

Make sure the following C libraries are installed before running the code:

<stdio.h>                     
<stdlib.h>                   
<string.h>                  
<unistd.h>                
<sys/types.h>              
<sys/select.h>                
<sys/socket.h>                
<netinet/in.h>                 
<netdb.h>                  
<arpa/inet.h>                 
<pthread.h>    


### Setup

- Use a gcc compiler.
- Use a Linux environment.
- To run the code on your local machine: 
-- Find the IP address using the command hostname -I
-- For the second IP address, use 127.0.0.1
- To run code between two different devices:
-- Make sure both devices have WSL 1 (This code does not run on WSL 2)
-- Run the command 'ipconfig' in the terminal to find the IPV4 address


### Compile and Run

1) Take note of the host IP address.
2) Go into the folder that contains the files for the network.
3) Compile the file containing main and the file with the functions using gcc.
4) Run the executable.

```sh
hostname -I
cd <destination of header and .c file>
gcc peer2peer.c PtoP.c -o p2p
./p2p
```

### How to Test

Test 1:
1) Enter the same port number on both devices running the program.
2) Enter the IPV4 address belonging to each device when prompted.

The following will appear to show that both sockets will be listening for incoming connections:
~~~
[+]Binding successful
[+]Listening...
Do you want to send a file? 1 for yes, 0 to quit
~~~
3) Type 1 in a device and do not type anything in the other device.
4) Next, enter the IP address of the device that should receive the file being sent over.
5) Now check the files that were created including: 
    1) The encrypted version of the file to be sent over on the device acting as a client.
    2) The encrypted file received by the device acting like a server.
    3) The decrypted file (ensure that the contents of the file match the original file)
6) The question 'Do you want to send a file? 1 for yes, 0 to quit' will be asked again

Test 2:
Repeat this procedure on the same device by sending a file from the same device. 

Test 3:
Repeat this once again by sending a file on the second device that was previously receiving files.

Test 4:
Enter a character or string that is not '0' or '1' when 'Do you want to send a file? 1 for yes, 0 to quit' is asked.

Press '0' to exit the program.


### References

| Title | Link |
| ------ | ------ |
| File Transfer using TCP Socket | https://www.youtube.com/watch?v=7d7_G81uews |
| Socket Programming Tutorial | https://www.youtube.com/watch?v=LtXEMwSG5-8 |
| Beej's Guide to Network Programming | https://beej.us/guide/bgnet/html/#what-is-a-socket |


### Authors

Gunjan Shahapurkar - 20332443
Lucas Schmidt - 20333930