// Libraries required:
#include <stdio.h>                      // Standard IO Library
#include <stdlib.h>                     // Standard Library
#include <string.h>                     // string operations
#include <unistd.h>                     // to use close()
#include <sys/types.h>                  // ip_addr_t, etc
#include <sys/socket.h>                 // sockaddr struct and sa_family, etc
#include <netinet/in.h>                 // sockaddr_in and in_port_t, in_addr_t, etc
#include <netdb.h>                      // for network database
#include <arpa/inet.h>                  // in_addr struct and hton, ntoh, etc

#define Socket_Address struct sockaddr
#define client_limit 10

// main function:
int main() {

    // Creating a socket
    int my_socket;
    my_socket = socket(AF_INET, SOCK_STREAM, 0);

    // Testing is socket was created
    if (my_socket == -1) {
        // If socket was not created
        printf("Unable to create a socket\n");
        exit(0);
    }
    else {
        // If socket was created
        printf("Socket created\n");
    }

    // Address to the server socket
    struct sockaddr_in server_address;
    bzero(&server_address, sizeof(server_address));

    // Ask for Port Number
    int my_port;
    printf("Port number: ");
    scanf("%d", &my_port);

    // Set values in the struct
    server_address.sin_family = AF_INET;                    // address family, always AF_INET
    server_address.sin_addr.s_addr = inet_addr("10.6.68.12");     // IP address from host to network long
    server_address.sin_port = htons(my_port);               // Port number from host to network short

    // Bind the socket to the IP address
    if ((bind(my_socket, (Socket_Address*)&server_address, sizeof(server_address))) != 0) {
        // If socket was not binded:
        printf("Socket bind unsuccessful\n");
        exit(0);
    }
    else {
        // If socket was binded:
        printf("Socket binded\n");
        printf("IP Address: %s\n", inet_ntoa(server_address.sin_addr));
        printf("Server Port: %d\n", (int)ntohs(server_address.sin_port));
    }

    // Listen to client
    if(listen(my_socket, client_limit) != 0) {
        // If listen fails:
        printf("Listen failed\n");
        exit(0);
    }
    else {
        // If listen works:
        printf("Listening\n");
    }

    // Create client socket struct element
    struct sockaddr_in client_socket;
    int length_of_client = sizeof(client_socket);

    // Accept client socket
    int connected_socket = accept(my_socket, (Socket_Address*)&client_socket, &length_of_client);
    if(connected_socket < 0) {
        // If acceptance fails:
        printf("Accept failed\n");
        exit(0);
    }
    else {
        // If client is successfully accepted:
        printf("Client accepted\n");
    }
    //------------------------------------------------------------------------------------------------------
    // Interaction with client goes here:
    

    //------------------------------------------------------------------------------------------------------
    close(my_socket);
    return 0;
}