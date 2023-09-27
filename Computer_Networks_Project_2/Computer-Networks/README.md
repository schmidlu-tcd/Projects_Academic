# Project 3
## Decentralised Network for Humanitarian Workers

A setup of a peer to peer network with File Transfer Protocol and encryption on sent files for intermittent communication for humanitarian workers in conflict zones. This implementation has been carried out in C programming language. The following README will detail the following:

- Libraries used in the code
- Set up
- Compilation
- Running the code
- How to Test


## Required Libraries 

Make sure the following C libraries are installed before running the code:
```c
<stdio.h>                     
<stdlib.h>                   
<string.h>
<time.h>                  
<unistd.h>                
<sys/types.h>              
<sys/select.h>                
<sys/socket.h>                
<netinet/in.h>                 
<netdb.h>                  
<arpa/inet.h>                 
<pthread.h>    
```
## Setup

- Use a gcc compiler.
- Use a Linux environment.
- To run the code on your local machine: 
    - Find the IP address using the command hostname -I
    - For the second IP address, use 127.0.0.1
- To run code between two different devices:
    - Make sure both devices have WSL 1 (This code does not run on WSL 2)
    - Run the command 'ipconfig' in the terminal to find the IPV4 address
- To run code in the Raspberry PI cluster:
    - Make sure you are connected to the Macneill TCD Network
    - Use **"ssh rasp-012.berry.scss.tcd.ie"** on one terminal to connect to Raspberry PI 12
    - Use **"ssh rasp-032.berry.scss.tcd.ie"** on another terminal to connect to Raspberry PI 32
    - Git clone a repository with all the files inside on each Raspberry PI

## Compile and Run

1) Take note of the host IP address.
2) Go into the folder that contains the files for the network.
    * Note that each peer has a different folder (1_peer, 2_peer)
    * This is because each peer is subscribed to different topics
3) Compile the file containing main and the file with the functions using gcc.
4) Run the executable.

```sh
hostname -I
cd <destination of header and .c file of this peer>
gcc peer2peer.c PtoP.c -o p2p -pthread
./p2p
```

## How to Test

#### Test 1:
1) Enter your device's port number on each device running the program.
2) Enter the IPV4 address belonging to each device when prompted.
    * The following will appear to show that both sockets will be listening for incoming connections:
~~~
||   [+]Binding successful
||   [+]Listening...
||=============================================================================||
||                          Input 1 to Request Update                          ||
||                          Input 2 to Publish                                 ||
||                          Input 0 to Exit                                    ||
||=============================================================================||
~~~
3) Type 1 in a device and do not type anything in the other device.
4) Next, enter the Port and IP address of the device that you will ask for an update on a topic.
5) You will be prompted for the ID of a topic, both peers are subscribed to different topics.
~~~
1_peer:
ID 74 = Logistics
ID 63 = Infrastructure
ID 40 = Finances
ID 6 = Medical
~~~
~~~
2_peer:
ID 74 = Logistics
ID 63 = Infrastructure
ID 64 = Security
ID 6 = Medical
~~~
6) Ask for a topic that both peers are subscribed to:
    * Logistics (74), Infrastructure (63) and Medical (6)
7) The network will send you an update on that topic
8) Make note of these files:
    * The encrypted_TopicName.txt file to be sent over to the requesting peer.
    * The encrypted.txt file received by the peer.
    * The current peer Topic.txt (ensure that the contents of the file match the original file)
9) You will be prompted for another Input again.

#### Test 2:
Request an update on a topic the other peer is not subscribed to. 

#### Test 3:
Request an update on a topic your peer is not subscribed to.
    * You will have to give this topic a local name (you don't have to include ".txt")

#### Test 4:
1) Instead of typing 1, type 2 to Publish a file
2) You will be prompted to input the name of the new Topic (you don't have to include ".txt")
3) You will be given an ID for the new Topic and then asked if you'd like to edit this new file, type y
4) Type the new contents of this file 
    * *just make sure not to use any "@" since that is our file terminator.*
5) Press enter on an empty line to end. Your new topic has been created!

#### Test 5:
Enter a character or string that is not '0', '1' or '2'.

#### Finish Testing
Type '0' to exit the program.


## References

| Title | Link |
| ------ | ------ |
| File Transfer using TCP Socket | https://www.youtube.com/watch?v=7d7_G81uews |
| Socket Programming Tutorial | https://www.youtube.com/watch?v=LtXEMwSG5-8 |
| Beej's Guide to Network Programming | https://beej.us/guide/bgnet/html/#what-is-a-socket |


### Authors

* Gunjan Shahapurkar - 20332443
* Lucas Schmidt - 20333930
* Conor Finlay - 20334367
* Nishpret Kaur Sethi - 20330968
