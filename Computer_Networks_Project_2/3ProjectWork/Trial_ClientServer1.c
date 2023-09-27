#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <arpa/inet.h>

#define SIZE 2000

// gcc Trial_ClientServer1.c -o t1
// ./t1


void send_file(FILE *file, int socketClient){

    char data[SIZE] = {0};

    while (fgets(data, SIZE, file) != NULL){
        if (send(socketClient, data, sizeof(data), 0) < 0){
            perror("[-]Error in sending data\n");
            exit(1);
        }
        else{
            printf("[+]File data sent successfully\n");
        }
        bzero(data, SIZE);
    }
    
}


void write_file(int newSocket){
    int n;
    FILE *file;
    char *fileName = "writeFile.txt";
    char buf[SIZE];

    file = fopen(fileName, "w");
    if(!file){
        perror("[-]Error while creating file\n");
        exit(1);
    }
    else{
        printf("[+]File created successfully\n");
    }

    while(1){
        n = recv(newSocket, buf, SIZE, 0);
        if(n <= 0){
            break;
            return;
        }
        fprintf(file, "%s", buf);
        bzero(buf, SIZE);
    }
    return;

}

void Error_Socket(int socket) {
    if(socket < 0){
        perror("[-]Error in socket\n");
        exit(1);
    }
    else{
        printf("[+]Server socket created\n");
    }
}


int main() {

    char mode[2];          // Client or server mode
    printf("Do you want to send a file? Y/N or any letter to quit\n");
    scanf("%s", mode);

    int error;
    struct sockaddr_in serverAddr, newAddr;
    socklen_t addrSize;
    char buf[SIZE];
    FILE *file;
    char fileName[20];
    int socketPort = 9070;
    int sock;


    while(strcmp(mode, "y")  == 0 || strcmp(mode, "Y") == 0 || strcmp(mode, "n")  == 0 || strcmp(mode, "N") == 0) {
        
        //                  CLIENT MODE
        if(strcmp(mode, "y")  == 0 || strcmp(mode, "Y") == 0) {
            printf("Client mode\n");

            printf("Enter the name of the file to be sent: ");
            scanf("%s", fileName);

            //SOCKET
            sock = socket(AF_INET, SOCK_STREAM, 0);    

            Error_Socket(sock);

            serverAddr.sin_family = AF_INET;
            serverAddr.sin_port = htons(socketPort);
            serverAddr.sin_addr.s_addr = INADDR_ANY;

            //CONNECT
            error = connect(sock, (struct sockaddr *) &serverAddr, sizeof(serverAddr)); 

            if(error < 0){
                perror("[-]Error during connection\n");
                exit(1);
            }
            else{
                printf("[+]Connected to server\n");
            }

            file = fopen(fileName, "r");
            if(!file){
                perror("[-]Error while reading file\n");
                exit(1);
            }
            
            send_file(file, sock);
            printf("[+]File data sent successfully\n");

            
            // CLOSE
            close(sock);
            printf("[+]Disconnected from the server\n");

        }

        //                  SERVER MODE
        else if(strcmp(mode, "n")  == 0 || strcmp(mode, "N") == 0) {
            printf("Server mode\n");

            // SOCKET
            int sock = socket(AF_INET, SOCK_STREAM, 0);

            Error_Socket(sock);

            // BIND
            serverAddr.sin_family = AF_INET;
            serverAddr.sin_port = htons(socketPort);
            serverAddr.sin_addr.s_addr = INADDR_ANY;

            // bind() = bind ip & port for particular socket; specify where socket will listen for connections
            error = bind(sock, (struct sockaddr *) &serverAddr, sizeof(serverAddr));        // Returns an integer to check if successful or not

            if(error < 0){
                perror("[-]Error in binding\n");
                exit(1);
            }
            else{
                printf("[+]Binding successful\n");
            }

            // LISTEN
            error = listen(sock, 5);        // 2nd argument: how many connections can be waiting (backlog) for the specified socket at one point in time

            if (error < 0){
                perror("[-]Error while listening\n");
                exit(1);
            }
            else{
                printf("[+]Listening...\n");
            }

            addrSize = sizeof(newAddr);
            // ACCEPT
            int newSocket = accept(sock, (struct sockaddr *) &newAddr, &addrSize);

            write_file(newSocket);
            printf("[+]Data written successfully in the text file\n");

        }


        printf("Do you want to send a file? Y/N or any letter to quit\n");
        scanf("%s", mode);
    }


    return 0;
}




