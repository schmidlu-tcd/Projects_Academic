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
// Initialises linked list
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
        perror("||   [-] Error while reading Initialization File\n");
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
// Function to search the list for ID, returns topic
//=====================================================================================
char* searchList(int id){
    node* current = (node*)malloc(sizeof(node));
    current = topics;
    
    while(current != NULL){
        if(current->id == id){
            return current->topic;
        }
        current = current->next;
    }
    return "[ERROR]";
}
//=========//=========//=========//=========//=========//=========//=========//

//=====================================================================================
// Function to check the list for ID, returns 1 or 0
//=====================================================================================
int checkList(int id){
    node* current = (node*)malloc(sizeof(node));
    current = topics;
    
    while(current != NULL){
        if(current->id == id){
            return 1;
        }
        current = current->next;
    }
    return 0;
}
//=========//=========//=========//=========//=========//=========//=========//


//=====================================================================================
// Function to check the list for topic, returns 1 or 0
//=====================================================================================
int checkListTopic(char* topic){
    node* current = (node*)malloc(sizeof(node));
    current = topics;
    
    while(current != NULL){
        if(!strcmp(current->topic, topic)){
            return 1;
        }
        current = current->next;
    }
    return 0;
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
            perror("||   [-] Error in sending data\n");
            exit(1);
        }
        else {
            printf("||   [+] File data sent successfully\n");
        }
        // Fills data with zeroes
        bzero(data, SIZE);
    }
    
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to encrypt files:
//=============================================================================
void encrypt_file(FILE *fileToEncrypt, FILE *fileEncrypted, char letters){ 
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
    fprintf(fileEncrypted, "%c", '@');
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
    int packets_sent = 0;
    // in case the user inputs an invalid topic
    if(strcmp(fileName, "[ERROR]") == 0){
        printf("||   [-] Topic does not exist,\n"); 
        return;
    }
    // Opens file 
    file = fopen(fileName, "r");
    if(!file){
        perror("||   [-] Error while reading file to encrypt\n");
        exit(1);
    }
    else{
        // Adds encrypted to the filename
        fileNameEncrypted = strcat(encryp, fileName);

        // Opens new file
        fileEncrypted = fopen(fileNameEncrypted, "w");
        if(!fileEncrypted){
            perror("||   [-] Error while creating encrypted file\n");
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
        perror("||   [-] Error while reading file to encrypt\n");
        exit(1);
    }

    // Loop for taking data from the file and sending to server
    while (fgets(data, SIZE, fileEncrypted) != NULL) {

        // If send fails, give error
        if (send(socketClient, data, sizeof(data), 0) < 0) {
            perror("||   [-] Error in sending data\n");
            exit(1);
        }
        else {
            packets_sent++;
        }
        // Fills data with zeroes
        bzero(data, SIZE);
    }
    strcpy(data, "@@@");
    send(socketClient, data, sizeof(data), 0);
    printf("||   [+] %i packets sent successfully\n", packets_sent);
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to send header:
//=============================================================================
int sendRequest(int socketClient, int topicID){  
    char msg[SIZE];
    sprintf(msg, "%d", topicID);

    // If send fails, give error
    if (send(socketClient, msg, sizeof(msg), 0) < 0) {
        perror("||   [-] Error in sending request\n");
        return 0;
    }
    else {
        printf("||   [+] Request sent successfully\n");
    }
    return 1;
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to receive header:
//=============================================================================
int receiveRequest(int newSocket){  
    char msg[SIZE];
    
    char *ptrValue;
    int value;

    value = recv(newSocket, msg, sizeof(msg), 0);
    if(value){
        printf("||   [+] Request Received.\n");
        value = strtol(msg, &ptrValue, 10);
        // Check nodes for ID
        node* buffNode = (node*)malloc(sizeof(node));
        buffNode = topics;
        while(buffNode != NULL)
        {
            if(value == buffNode->id)
            {
                return buffNode->id;
            }
            buffNode = buffNode->next;
        }
        printf("||   [-] Not Subscribed to this Topic.\n");
        strcpy(msg, "&&&");
        send(newSocket, msg, sizeof(msg), 0);
        return 0;
    }
    printf("||   [-] No Request Received.\n");
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
        perror("||   [-] Error while creating file\n");
        exit(1);
    }
    else{
        printf("||   [+] File created successfully\n");
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
    while(letters != '@'){
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
    char *search = searchList(id);                      // Search for topic in list
    char *fileNameDecrypted;                            // Decrypted file
    char newTopic[40];                                 // Topic name
    char buf[SIZE];                                     // buffer
    char letters;                                       // Char for letters
    char currentDateAndTime[30];                        // To get current Date and Time
    
    if(strcmp(search, "[ERROR]") == 0){
        printf("||   [+] You've subscribed to a new topic.\n");
        printf("||   [+] Name this topic: ");

        // Get new topic name
        scanf("%s", newTopic);
        fileNameDecrypted = strcat(newTopic, ".txt");

        // Get current date and time
        time_t t = time(NULL);
        struct tm tm = *localtime(&t);
        sprintf(currentDateAndTime, "%d.%02d.%02d,%02d:%02d:%02d", (tm.tm_year + 1900), (tm.tm_mon + 1), tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
        
        // Create new node
        add_node(&topics, id, fileNameDecrypted, currentDateAndTime);
        UpdateInitFile();
    }
    else strcpy(fileNameDecrypted, search);
    
    if(strlen(fileNameDecrypted) == 0)
    {
        perror("||   [-] Topic Not Available\n");
        exit(1);
    }
    
    // Create encrypted file
    fileEncrypted = fopen(fileNameEncrypted, "w");        
    if(!fileEncrypted){
        perror("||   [-] Error while creating file for encrypted data\n");
        exit(1);
    }
    
    // Loop to receive data from client into file
    while(1){
        error = recv(newSocket, buf, SIZE, 0);
        if(error <= 0 || strcmp(buf, "@@@") == 0){
            break;
        }
        if(strcmp(buf, "&&&") == 0){
            printf("||   [-] Peer is not subscribed to this topic\n");
            fclose(fileEncrypted);
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
        perror("||   [-] Error while reading encrypted file\n");
        exit(1);
    }
    else{
        fileDecrypted = fopen(fileNameDecrypted, "w");

        if(!fileDecrypted){
            perror("||   [-] Error while creating file for decrypted data.\n");
            exit(1);
        }

        letters = fgetc(fileEncrypted);

        decrypt_file(fileEncrypted, fileDecrypted, letters);
    }
    
    fprintf(fileDecrypted, "%c", '@');
    //fclose(fileEncrypted);
    fclose(fileDecrypted);

    printf("||   [+] Data decrypted successfully and topic updated.\n");
    return;
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to check if socket is created:
//=============================================================================
void Error_Socket(int socket) {
    if(socket < 0){
        perror("||   [-] Error in socket\n");
        exit(1);
    }
    else{
        printf("||   [+] Socket created\n");
    }
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to update init list with linked list:
//=============================================================================
void UpdateInitFile() {
    FILE* initFile = fopen("initList.txt", "w");
    node* current = (node*)malloc(sizeof(node));
    current = topics;
    
    while(current != NULL){
        fprintf(initFile, "%d", current->id);
        fprintf(initFile, "%c", '&');
        fprintf(initFile, "%s", current->topic);
        fprintf(initFile, "%c", '&');
        fprintf(initFile, "%s", current->dateAndTime);
        if(current->next == NULL) {
            fprintf(initFile, "%c", '@');
        }
        else {
            fprintf(initFile, "%c", '&');
            fprintf(initFile, "%c", '\n');
        }
        current = current->next;
    }

    fclose(initFile);
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to create an ID for new topic:
//=============================================================================
int hash_function(char *s)
{ 
    int hash = 0; 
    int i = 0;

    while(s[i] != '\0') 
    {
        hash = hash + s[i] * (99109^i);
        s++;
        i++;
    }

    hash = hash%999;
    int check = checkList(hash);
    while(check == 1) {
        hash++;
        check = checkList(hash);
    }

    return hash;
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to publish new topic:
//=============================================================================
void Publish() {
    FILE* file;
    char newTopic[30];
    char *newFileName;
    int newID;
    char currentDateAndTime[30];

    // Ask for Topic Name
    printf("||   Input the Name of New Topic: ");
    scanf("%s", newTopic);
    newFileName = strcat(newTopic, ".txt");

    // Checks availability of file
    file = fopen(newFileName, "w");
    if(!file){
        printf("%s\n", newFileName);
        perror("||   [-] Error while opening topic file\n");
        exit(1);
    }

    // Check if topic exists
    if(checkListTopic(newFileName)) {
        printf("||   Topic Already Exists.\n");
    }
    else {
        // Generates HASH from topic name
        newID = hash_function(newTopic);

        // Get current date and time
        time_t t = time(NULL);
        struct tm tm = *localtime(&t);
        sprintf(currentDateAndTime, "%d.%02d.%02d,%02d:%02d:%02d", (tm.tm_year + 1900), (tm.tm_mon + 1), tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);

        // Adds to linked list and to initFile
        add_node(&topics, newID, newFileName, currentDateAndTime);
        printf("||   The New Topic ID is: %d\n", newID);
    }
    UpdateInitFile();

    // To edit file
    printf("||   Would You Like to Edit the File? [y/n]: ");
    char reply[1000];
    scanf("%s", reply);
    int c;
    while ((c = getchar()) != '\n' && c != EOF);

    if(!strcmp(reply, "y") || !strcmp(reply, "Y")) {
        printf("||   Editing File (End With an Empty Line):\n");
        printf(":: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ::\n");
        printf("::   ");

        while (fgets(reply, 1000, stdin) != NULL && reply[0] != '\n') {
            // Get input and write to file
            fprintf(file, "%s", reply);
            printf("::   ");
        }
        fprintf(file, "%s", "@");
        printf(":: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ::\n");
        printf("||   [+] File Edited Successfully!\n");
    }
    fclose(file);
}
//=========//=========//=========//=========//=========//=========//=========//



//=============================================================================
// Receive File Function:
//=============================================================================
void connect_to_server() {
    FILE *file;                                 // File Address                               
    int id;
    int conn_Port;                              // Port number
    char IPV4[20];                              // Ip address
    int error;                                  // Error checking
    int sock;                                   // Socket error checking
    struct sockaddr_in connectAddr;             // Structs for creating sockets

    printf("||   Enter the Port to connect to: ");
    // Receive Port from user
    scanf("%d", &conn_Port);

    printf("||   Enter the IP Address to connect to: ");
    // Receive IP from user
    scanf("%s", IPV4);

    // Print empty line
    printf("\n");

    // Socket Creation
    sock = socket(AF_INET, SOCK_STREAM, 0);    
    Error_Socket(sock);

    // Set socket family:
    connectAddr.sin_family = AF_INET;
    // Set socket Port:
    connectAddr.sin_port = htons(conn_Port);
    //Set server socket IP address:
    connectAddr.sin_addr.s_addr = inet_addr(IPV4);

    // Attempt connection
    error = connect(sock, (struct sockaddr *)&connectAddr, 
    sizeof(connectAddr)); 

    if(error < 0){
        perror("||   [-]Error during connection\n");
        exit(1);
    }
    else{
        printf("||   [+]Connected to server\n");
    }

    // Print empty line
    printf("\n");
    // Receive name of topic from user
    printf("||   ID of Topic to be Updated: ");
    scanf("%d", &id);
    
    // Print empty line
    printf("\n");

    // // Open File - for testing
    // file = fopen(fileName, "r");
    // if(!file){
    //     perror("[-]Error while reading file\n");
    //     exit(1);
    // }
    
    // Send Header file
    if(sendRequest(sock, id)){
        // Store file from server
        storeData(sock, id);
    }
    else
    {
        printf("||   [-]File not sent\n");
    }

    // Close Socket
    close(sock);
    printf("||   [+]Disconnected from the peer\n");
}
//=========//=========//=========//=========//=========//=========//=========//


//=============================================================================
// Function to send files:
//=============================================================================
void pServer(int sock)
{
    FILE *file;                                 // File Address  
    struct sockaddr_in sock_Addr;               // Socket Struct
    fd_set sock_Set, sock_ReadySet;             // The sets of sockets
    int value;                                  // To read value
    int addrlen = sizeof(sock_Addr);            // Set the size of socket
    int sock_Client;                            // Client's socket
    char buffer[2000] = {0};                    // buffer
    int id;                                     // ID of topic

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
                    printf("\n||=============================================================================||\n");
                    printf("||   [+]Peer has connected.\n");
                    printf("||=============================================================================||\n");
                    id = receiveRequest(sock_Client);
                    if(id != 0)
                        sendData(file, sock_Client, id);
                    printf("||=============================================================================||\n");
                    printf("||   Input: ");
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