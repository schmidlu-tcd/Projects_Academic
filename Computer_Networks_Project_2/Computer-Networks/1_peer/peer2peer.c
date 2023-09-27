// Libraries required:
#include <stdio.h>                      // Standard IO Library
#include <stdlib.h>                     // Standard Library
#include <string.h>                     // string operations
#include <time.h>                       // For getting the time of updates
#include <unistd.h>                     // to use close()
#include <sys/types.h>                  // ip_addr_t, etc
#include <sys/select.h>                 // File Descriptors
#include <sys/socket.h>                 // sockaddr struct and sa_family, etc
#include <netinet/in.h>                 // sockaddr_in and in_port_t, in_addr_t
#include <netdb.h>                      // for network database
#include <arpa/inet.h>                  // in_addr struct and hton, ntoh, etc
#include <pthread.h>                    // For concurrency

#include "PtoP.h"

// gcc peer2peer.c PtoP.c -o p2p -pthread
//./p2p
// hostname -I : 
// 127.0.0.1

//=============================================================================
// Main:
//=============================================================================
int main() {

    struct sockaddr_in serverAddr, newAddr;     // Structs for creating sockets
    socklen_t addrSize;                         // Size of socket
    int error;                                  // Error checking
    char serv_IP[20];                           // IP of server
    int serv_Port;                              // port

    initList();                                 // initiliase list of topics

    printf("||=============================================================================||\n");
    printf("||                                WELCOME PEER!                                ||\n");
    printf("||=============================================================================||\n");

    // Socket Creation
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    Error_Socket(sock);
    printf("\n||   Enter the Port: ");
    // Receive Port from user
    scanf("%d", &serv_Port);

    printf("||   Enter your IP address: ");
    // Receive IP from user
    scanf("%s", serv_IP);

    // Set socket family:
    serverAddr.sin_family = AF_INET;
    // Set socket port:
    serverAddr.sin_port = htons(serv_Port);
    // Set server socket IP address:
    serverAddr.sin_addr.s_addr = inet_addr(serv_IP);

    // bind(): bind ip & port for particular socket; 
    // specify where socket will listen for connections
    // Returns an integer to check if successful or not
    error = bind(sock, (struct sockaddr*)&serverAddr, sizeof(serverAddr));
    if(error < 0){
        perror("\n||   [-]Error in binding\n");
        exit(1);
    }
    else{
        printf("\n||   [+]Binding successful\n");
    }

    // Listen for connections
    // 2nd argument: how many connections can be waiting (backlog) 
    // for the specified socket at one point in time
    error = listen(sock, max_clients);        
    if (error < 0){
        perror("||   [-]Error while listening\n");
        exit(1);
    }
    else{
        printf("||   [+]Listening...\n");
    }

    // Creates threads to receive files concurrently
    pthread_t serv_Thread;
    pthread_create(&serv_Thread, NULL, &Server_Receive, &sock);

    // Type 1 to send file at any time and 0 to quit program
    char mode[1];
    printf("||=============================================================================||\n");
    printf("||                          Input 1 to Request Update                          ||\n");
    printf("||                          Input 2 to Publish                                 ||\n");
    printf("||                          Input 0 to Exit                                    ||\n");
    printf("||=============================================================================||\n");
    printf("||   Input: ");
    scanf("%s", mode);

    // Loop for server
    while(mode) {
        if(strcmp(mode, "1")  == 0){
            connect_to_server();               // Connects to a server to send a file
        }
        else if(strcmp(mode, "2")  == 0){
            Publish();                                  // Publishes New Topic
        }
        else if(strcmp(mode, "0")  == 0){
            
            printf("||==============================[Exiting Program]==============================||\n");              // Exits program
            break;
        }
        else{
            printf("||   Not an option...\n");               // When input is not 1 or 0
        }

        // Ask again
        printf("||=============================================================================||\n");
        printf("||                          Input 1 to Request Update                          ||\n");
        printf("||                          Input 2 to Publish                                 ||\n");
        printf("||                          Input 0 to Exit                                    ||\n");
        printf("||=============================================================================||\n");
        printf("||   Input: ");
        scanf("%s", mode);
    }

    // Closes socket before program closes
    close(sock);

    // End of main
    return 0;
}
//=========//=========//=========//=========//=========//=========//=========//
