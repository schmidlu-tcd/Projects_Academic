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

int main() {
    initList();

    node* buffNode = topics;

    while(buffNode != NULL)
    {
        printf("ID: %d , Topic: %s , Date: %s\n", buffNode->id, (buffNode->topic), (buffNode->dateAndTime));
        buffNode = buffNode->next;
    }

    return 0;
}