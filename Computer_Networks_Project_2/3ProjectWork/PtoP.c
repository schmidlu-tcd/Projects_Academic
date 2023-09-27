// Libraries required:
#include <stdio.h>                      // Standard IO Library
#include <stdlib.h>                     // Standard Library
#include <string.h>                     // string operations
#include <unistd.h>                     // to use close()
#include <sys/types.h>                  // ip_addr_t, etc
#include <sys/select.h>                 // File Descriptors
#include <sys/socket.h>                 // sockaddr struct and sa_family, etc
#include <netinet/in.h>                 // sockaddr_in and in_port_t, in_addr_t
#include <arpa/inet.h>                  // in_addr struct and hton, ntoh, etc
#include <pthread.h>                    // For concurrency

#include "PtoP.h"                       // Header for function declarations

//=====================================================================================
// Linked list implementation
//=====================================================================================
typedef struct node{
    struct node* next;
    char topic[30];
    char dateAndTime[30];
    int id;
} node;

void add_node(node** head,  int id, char* str, char* date){
    node* new_node = (node*)malloc(sizeof(node));
    strcpy(new_node->topic, str);
    strcpy(new_node->dateAndTime, date);
    new_node->id = id;
    new_node->next = NULL;

    if(*head == NULL)
        *head = new_node;
    else{
        node* current = (node*)malloc(sizeof(node));
        current = *head;
        while(current->next != NULL){
            current = current->next;
        }
        current->next = new_node;
    }
}

node* topics = NULL;

//=========//=========//=========//=========//=========//=========//=========//


//=====================================================================================
// Temporary function to initialise linked list (will be pulled from a file in future):
//=====================================================================================
void initList(){
    char charBuff;
    int maxStringSize = 30;
    char temp[maxStringSize];
    int pos;
    int buffID;
    char buffTopic[maxStringSize];
    char buffDate[maxStringSize];

    FILE* initFile = fopen("initList.txt", "r");
    if(!initFile)
    {
        perror("[-]Error while reading Initialization File\n");
        exit(1);
    }
    else
    {
        charBuff = fgetc(initFile);
        while(charBuff != '@')
        {
            // ID
            pos = 0;
            while (charBuff != '&')
            {
                temp[pos] = charBuff;
                charBuff = fgetc(initFile);
                pos++;
            }
            buffID = atoi(temp);
            memset(temp,0,maxStringSize);

            // Topic
            pos = 0;
            charBuff = fgetc(initFile);
            while (charBuff != '&')
            {
                temp[pos] = charBuff;
                charBuff = fgetc(initFile);
                pos++;
            }
            strcpy(buffTopic, temp);
            memset(temp,0,maxStringSize);

            // Last Date Updated
            pos = 0;
            charBuff = fgetc(initFile);
            while (charBuff != '&' && charBuff != '@')
            {
                temp[pos] = charBuff;
                charBuff = fgetc(initFile);
                pos++;
            }
            strcpy(buffDate, temp);
            memset(temp,0,maxStringSize);

            add_node(&topics, buffID, buffTopic, buffDate);

            buffID = 0;
            memset(buffTopic,0,maxStringSize);
            memset(buffDate,0,maxStringSize);

            if(charBuff != '@')
            {
                charBuff = fgetc(initFile);
            }
        }
    }

    return;
}
//=========//=========//=========//=========//=========//=========//=========//


//=====================================================================================
// Function to search the list of topics for a topic that matches the id, and return it
//=====================================================================================
char* searchList(int id){
    node* current = (node*)malloc(sizeof(node));
    current = topics;
    printf("@@@ Searching: %d\n", id);
    while(current != NULL){
        // printf("[DEBUG] Current file: %s\n", current->data);
        if(current->id == id){
            // printf("[DEBUG] Chosen file: %s\n", current->data);
            printf("@@@ Topic: %s\n", current->topic);
            return current->topic;
        }
        current = current->next;
    }
    return "[ERROR]";
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to send files:
//=============================================================================
void sendData_old(FILE *file, int socketClient){

    char data[SIZE] = {0};               // Array of chars with specified size

    // Loop for taking data from the file and sending to server
    while (fgets(data, SIZE, file) != NULL) {
        // If send fails, give error
        if (send(socketClient, data, sizeof(data), 0) < 0) {
            perror("[-]Error in sending data\n");
            exit(1);
        }
        else {
            printf("[+]File data sent successfully\n");
        }
        // Fills data with zeroes
        bzero(data, SIZE);
    }
    
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to encrypt files:
//=============================================================================
void encrypt_file(FILE *fileToEncrypt, FILE *fileEncrypted, char letters){      // WORKING
    // ascii representation of each character in the file
    int ascii_rep;
    int maxCharsCount = 0;

    // While file has not ended with @ symbol
    while(letters != '@'){
        //FOR DEBUG:

        if(maxCharsCount == 2000) {
            break;
        }

        maxCharsCount++;

        // Get ascii of the letter
        ascii_rep = (int)letters;

        // Adds 9 to the ascii value
        ascii_rep += 9;

        // Adds the letter to the new file
        fprintf(fileEncrypted, "%c", ascii_rep);

        // Gets next letter
        letters = fgetc(fileToEncrypt);
    }
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to send encrypted files:
//=============================================================================
void sendData(FILE *file, int socketClient, int topicID){ 

    char letters;                   // letters
    FILE *fileEncrypted;            // File that has been encrypted
    char data[SIZE] = {0};          // Array of chars with specified size
    char *fileNameEncrypted, encryp[35] = "encrypted_";
    char *fileName = searchList(topicID); // search topics for given id
    
    // in case the user inputs an invalid topic
    if(strcmp(fileName, "[ERROR]") == 0){
        printf("[-] Topic does not exist,\n"); 
        return;
    }
    // Opens file 
    file = fopen(fileName, "r");
    if(!file){
        printf("%s\n", fileName);
        perror("[-]Error while reading file to encrypt\n");
        exit(1);
    }
    else{
        // Adds encrypted to the filename
        fileNameEncrypted = strcat(encryp, fileName);

        // Opens new file
        fileEncrypted = fopen(fileNameEncrypted, "w");
        if(!fileEncrypted){
            perror("[-]Error while creating encrypted file\n");
            exit(1);
        }

        // Gets letter and encrypts
        letters = fgetc(file);
        encrypt_file(file, fileEncrypted, letters);
    }
    fclose(file);
    // Close file to place text in the file before sending it over
    fclose(fileEncrypted);  

    // Read encrypted file to send over
    fileEncrypted = fopen(fileNameEncrypted, "r");
    if(!file){
        printf("%s\n", fileNameEncrypted);
        perror("[-]Error while reading file to encrypt\n");
        exit(1);
    }

    // Loop for taking data from the file and sending to server
    while (fgets(data, SIZE, fileEncrypted) != NULL) {

        // If send fails, give error
        if (send(socketClient, data, sizeof(data), 0) < 0) {
            perror("[-]Error in sending data\n");
            exit(1);
        }
        else {
            printf("[+]File data sent successfully\n");
        }
        // Fills data with zeroes
        bzero(data, SIZE);
    }
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to send header:
//=============================================================================
int sendHeader(int socketClient, int topicID){  
    char msg[SIZE];
    sprintf(msg, "%d", topicID);

    // If send fails, give error
    if (send(socketClient, msg, sizeof(msg), 0) < 0) {
        perror("[-]Error in sending header\n");
        return 0;
    }
    else {
        printf("[+]Header sent successfully\n");
    }
    return 1;
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to receive header:
//=============================================================================
int receiveHeader(int newSocket){  
    char msg[SIZE];
    
    char *ptrValue;
    int value;

    value = recv(newSocket, msg, sizeof(msg), 0);
    if(value){
        printf("[+] Header Received.\n");
        value = strtol(msg, &ptrValue, 10);
        printf("@@@ Value: %d\n", value);
        // Check nodes for ID
        node* buffNode = (node*)malloc(sizeof(node));
        buffNode = topics;
        while(buffNode != NULL)
        {
            printf("@@@ ID: %d , Topic: %s , Date: %s\n", buffNode->id, (buffNode->topic), (buffNode->dateAndTime));
            if(value == buffNode->id)
            {
                return buffNode->id;
            }
            buffNode = buffNode->next;
        }
        printf("[-] Not Subscribed to this Topic.\n");
        return 0;
    }
    printf("[-] No Header Received.\n");
    return 0;
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to write into a new file:
//=============================================================================
void storeData_old(int newSocket){
    int n;                              // n for receiving
    FILE *file;                         // Addbress of file
    char *fileName = "writeFile.txt";   // filename (plans to be set by user)
    char buf[SIZE];                     // buffer

    // Opens file
    file = fopen(fileName, "w");
    if(!file){
        perror("[-]Error while creating file\n");
        exit(1);
    }
    else{
        printf("[+]File created successfully\n");
    }

    // Loop to receive data from client into file
    while(1){
        n = recv(newSocket, buf, SIZE, 0);
        if(n <= 0){
            break;
            return;
        }
        // Copies into the file
        fprintf(file, "%s", buf);
        // Empty buffer
        bzero(buf, SIZE);
    }
    // Closes file
    fclose(file);
    return;
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to decrypt files:
//=============================================================================
void decrypt_file(FILE *fileToDecrypt, FILE *fileDecrypted, char letters){

    // Ascii representation of the letters
    int ascii_rep;

    // While file has not ended
    while(letters != EOF){
        // Gets ascii of letter
        ascii_rep = (int)letters;

        // Removes 9 from ascii
        ascii_rep -= 9;

        // Adds to decrypted file
        fprintf(fileDecrypted, "%c", ascii_rep);

        // Gets next letter
        letters = fgetc(fileToDecrypt);
    }

    // Closes file
    fclose(fileToDecrypt);
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to write encrypted text into a new file and decrypt file:
//=============================================================================
void storeData(int newSocket, int id){
    int error;                                          // for error in receiving
    FILE *fileEncrypted, *fileDecrypted;                // Address of encrypted file
    char *fileNameEncrypted = "encrypted.txt";          // filename (plans to be set by user)
    char *fileNameDecrypted = searchList(id);          // filename (plans to be set by user)
    char buf[SIZE];                                     // buffer
    char letters;                                       // Char for letters

    printf("@@@ File Name: %s\n", fileNameDecrypted);
    if(strlen(fileNameDecrypted) == 0)
    {
        perror("[-]Topic Not Available\n");
        exit(1);
    }

    // Create encrypted file
    fileEncrypted = fopen(fileNameEncrypted, "w");        
    if(!fileEncrypted){
        perror("[-]Error while creating encrypted file\n");
        exit(1);
    }
    else{
        printf("[+]Encrypted file created successfully\n");
        printf("Do you want to send a file? 1 for yes, 0 to quit\n");
    }

    // Loop to receive data from client into file
    while(1){
        error = recv(newSocket, buf, SIZE, 0);
        if(error <= 0){
            break;
            return;
        }
        // Copies into the file
        fprintf(fileEncrypted, "%s", buf);

        // Empty buffer
        bzero(buf, SIZE);
    }

    // Closes file
    fclose(fileEncrypted);

    // Read encrypted file
    fileEncrypted = fopen(fileNameEncrypted, "r");
    if(!fileEncrypted){
        perror("[-]Error while reading encrypted file\n");
        exit(1);
    }
    else{
        fileDecrypted = fopen(fileNameDecrypted, "w");
        if(!fileDecrypted){
            perror("[-]Error while creating decrypted file\n");
            exit(1);
        }
        letters = fgetc(fileEncrypted);
        decrypt_file(fileEncrypted, fileDecrypted, letters);
    }

    fprintf(fileDecrypted, "%c", '@');

    //fclose(fileEncrypted);
    fclose(fileDecrypted);
    return;
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to check if socket is created:
//=============================================================================
void Error_Socket(int socket) {
    if(socket < 0){
        perror("[-]Error in socket\n");
        exit(1);
    }
    else{
        printf("[+]Server socket created\n");
    }
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Send File Function:
//=============================================================================
void connect_to_server(int socketPort) {
    FILE *file;                                 // File Address                               
    int id;
    char IPV4[20];                              // Ip address
    int error;                                  // Error checking
    int sock;                                   // Socket error checking
    struct sockaddr_in connectAddr;             // Structs for creating sockets

    printf("Enter the IP address to connect to: ");
    // Receive IP from user
    scanf("%s", IPV4);

    // Socket Creation
    sock = socket(AF_INET, SOCK_STREAM, 0);    
    Error_Socket(sock);

    // Set socket family:
    connectAddr.sin_family = AF_INET;
    // Set socket Port:
    connectAddr.sin_port = htons(socketPort);
    //Set server socket IP address:
    connectAddr.sin_addr.s_addr = inet_addr(IPV4);

    // Attempt connection
    error = connect(sock, (struct sockaddr *)&connectAddr, 
    sizeof(connectAddr)); 

    if(error < 0){
        perror("[-]Error during connection\n");
        exit(1);
    }
    else{
        printf("[+]Connected to server\n");
    }

    // Receive name of topic from user
    printf("Enter the id of the topic to be updated: "); 
    scanf("%d", &id);

    // // Open File - for testing
    // file = fopen(fileName, "r");
    // if(!file){
    //     perror("[-]Error while reading file\n");
    //     exit(1);
    // }
    
    // Send Header file
    if(sendHeader(sock, id))
    {
        // Send File to server
        sendData(file, sock, id);

        //sendData(file, sock);     // for testing
        printf("[+]File data sent successfully\n");
    }
    else
    {
        printf("[-]File not sent\n");
    }

    // Close Socket
    close(sock);
    printf("[+]Disconnected from the peer\n");
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to receive files:
//=============================================================================
void pServer(int sock)
{
    struct sockaddr_in sock_Addr;               // Socket Struct
    fd_set sock_Set, sock_ReadySet;             // The sets of sockets
    int value;                                  // To read value
    int addrlen = sizeof(sock_Addr);            // Set the size of socket
    int sock_Client;                            // Client's socket
    char buffer[2000] = {0};                    // buffer
    int id;

    //Initialize sock set
    FD_ZERO(&sock_Set);
    FD_SET(sock, &sock_Set);
    int set_iteration = 0;
    while (1)
    {
        set_iteration++;
        // Make the socket Set ready for use
        sock_ReadySet = sock_Set;
        // Monitor sock_ReadySet
        if (select(FD_SETSIZE, &sock_ReadySet, NULL, NULL, NULL) < 0)
        {
            perror("Error");
            exit(EXIT_FAILURE);
        }
        // Loop to go through sockets
        for (int i = 0; i < FD_SETSIZE; i++) {
            // Check it is part of set
            if (FD_ISSET(i, &sock_ReadySet)) {
                // if i is the selected socket
                if (i == sock) {
                    // Attempt to accept
                    if ((sock_Client = accept(sock, 
                        (struct sockaddr *)&sock_Addr,
                        (socklen_t *)&addrlen)) < 0)
                    {
                        perror("accept");
                        exit(EXIT_FAILURE);
                    }
                    // Add to set and store the file
                    FD_SET(sock_Client, &sock_Set);

                    id = receiveHeader(sock_Client);
                    printf("@@@ ID: %d\n", id);
                    if(id) 
                        storeData(sock_Client, id);
                }
                else {
                    value = recv(i, buffer, sizeof(buffer), 0);
                    // Print received data
                    printf("%s\n", buffer); 
                    // Clear i from sock_Set
                    FD_CLR(i, &sock_Set); 
                }
            }
        }
        if (set_iteration == (FD_SETSIZE * 2)) { break; }
    }
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// function to repeatedly receive files:
//=============================================================================
void *Server_Receive(void *serv_Sock)
{
    // Get socket
    int sock = *((int *)serv_Sock);

    // Loop every 2 seconds
    while (1)
    {
        // Every 2 seconds
        sleep(2);

        // Attempt to receive file
        pServer(sock);
    }
}
//=========//=========//=========//=========//=========//=========//=========//