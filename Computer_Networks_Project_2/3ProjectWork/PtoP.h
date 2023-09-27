#ifndef PtoP
#define PtoP

// Max size of data being transmitted
#define SIZE 4
// Max clients connected to server backlog
#define max_clients 5
// Header size
#define HEADER 10

void encrypt_file(FILE *fileToEncrypt, FILE *fileEncrypted, char letters);
void sendData(FILE *file, int socketClient, int id);
void decrypt_file(FILE *fileToDecrypt, FILE *fileDecrypted, char letters);
void storeData(int newSocket, int topicID);
int sendHeader(int socketClient, int topicID);
int receiveHeader(int newSocket);
void initList();

void sendData_old(FILE *file, int socketClient);       // Used for testing
void storeData_old(int newSocket);                     // Used for testing
void Error_Socket(int socket);                  
void connect_to_server(int socketPort);
void pServer(int sock);
void *Server_Receive(void *serv_Sock);

#endif
