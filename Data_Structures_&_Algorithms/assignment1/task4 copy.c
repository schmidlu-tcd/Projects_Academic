#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define ARRAY_SIZE 99991
#define MAX_STRING_SIZE 50

int collisions = 0;
int numTerms = 0;

//Struct for each person(Node)
typedef struct Node Node;
struct Node
{
    char Person_ID[MAX_STRING_SIZE];
    char Deposition_ID[MAX_STRING_SIZE];
    char Surname[MAX_STRING_SIZE];
    char Forename[MAX_STRING_SIZE];
    char Age[MAX_STRING_SIZE];
    char Person_Type[MAX_STRING_SIZE];
    char Gender[MAX_STRING_SIZE];
    char Nationality[MAX_STRING_SIZE];
    char Religion[MAX_STRING_SIZE];
    char Occupation[MAX_STRING_SIZE];
    int Hash_Pos;
    Node *next;
};

//Struct for linked lists in hash table
typedef struct element element;
struct element
{
    Node *head;
};

//creates array of structs (our hash table)
element elements[ARRAY_SIZE];

int hash_function(char *s)
{ 
    int hash = 0; 
    while(*s) 
    {
        hash = hash + *s;
        s++;
    }
    
    //multiply the hash by a prime to get less collisions
    hash = (hash*19);
    
    return(hash % ARRAY_SIZE);
}

//set all head pointers to NULL
void initialize()
{
    for(int i = 0; i < ARRAY_SIZE; i++)
    {
        elements[i].head = NULL;
    }
}

//to find the name in the array (returns pointer to element)
element *findElement(Node *temp)
{
    //find initial position
    int POS = hash_function(temp->Surname);
    int i = POS;
    int noLoopBool = 0;

    //check array for the name
    while(i < ARRAY_SIZE)
    {
        if(elements[i].head != NULL && !strcmp(elements[i].head->Surname, temp->Surname)) //if head is not NULL 
        {
            //if name is found, return pointer to the struct of linked list of the name
            return &elements[i];
        }
        i++;
        //to make sure we don't get stuck in an infinite loop
        if(i == ARRAY_SIZE) 
        {
            i = 0;
            if(noLoopBool == 1) { break; }
            noLoopBool = 1; 
        }
    }
    //if no name is found, NULL is returned
    return NULL;
}

//creates a new node
void add_node(element *list, Node *temp, int pos)
{
    Node *newNode = (Node*)malloc(sizeof(Node)); //create newNode and allocate memory for it
    //inserts data from temporary node
    strcpy(newNode->Person_ID, temp->Person_ID);
    strcpy(newNode->Deposition_ID, temp->Deposition_ID);
    strcpy(newNode->Surname, temp->Surname);
    strcpy(newNode->Forename, temp->Forename);
    strcpy(newNode->Age, temp->Age);
    strcpy(newNode->Person_Type, temp->Person_Type);
    strcpy(newNode->Gender, temp->Gender);
    strcpy(newNode->Nationality, temp->Nationality);
    strcpy(newNode->Religion, temp->Religion);
    strcpy(newNode->Occupation, temp->Occupation);
    newNode->Hash_Pos = pos; //position in the hash array
    newNode->next = list->head; //point to next pointer
    list->head = newNode; //add pointer to the linked list
    
    /*
    printf("%s %s %s %s %s %s %s %s %s %s %d \n", newNode->Person_ID, newNode->Deposition_ID, 
    newNode->Surname, newNode->Forename, newNode->Age, newNode->Person_Type, newNode->Gender, newNode->Nationality, 
    newNode->Religion, newNode->Occupation, newNode->Hash_Pos);
    */
}

//creates new element with hash values
void newElement(Node *temp)
{
    int position = hash_function(temp->Surname);
    //printf("%d \n",hash_function(name));
    if(elements[position].head != NULL)
    {
        collisions++;
    }
    else
    {
        numTerms++;
    }
    add_node(&elements[position], temp, position);
}

//reads file
int *read_file(char *fname)
{
    FILE *MyFile;
    MyFile = fopen(fname, "r");
    if(MyFile == NULL) 
    {
        //if file isn't open
        perror("File can't be opened");
        return NULL;
    }
    
    char temporary[MAX_STRING_SIZE];
    Node *temp = (Node*)malloc(sizeof(Node));
    int firstRowBool = 0;
    char c = fgetc(MyFile);

    while(!feof(MyFile))
    {
        while(c != '\n' && firstRowBool == 0)
        {
            c = fgetc(MyFile);
        }
        firstRowBool = 1;
        for(int num = 1; num <= 10; num++)
        {
            int i = 0;
            int commaBool = 0;
            memset(temporary, 0, MAX_STRING_SIZE);

            c = fgetc(MyFile);           
            while(c != '\n')
            {
                if(c == '"')
                {
                    c = fgetc(MyFile);
                    if(feof(MyFile)) { break; }
                    if(commaBool == 0)
                    { 
                        commaBool = 1;
                    }
                    else
                    { 
                        commaBool = 0;
                    }
                }
                if(c == ',' && commaBool == 0) { break; }
                if(c == '\0') { break; }
                if(c == '\n') { break; }
                temporary[i] = c;
                c = fgetc(MyFile);
                if(feof(MyFile)) { break; }
                i++;
            }

            switch (num) 
            {
                case 1:
                    strcpy(temp->Person_ID, temporary);
                case 2:
                    strcpy(temp->Deposition_ID, temporary);
                case 3:
                    strcpy(temp->Surname, temporary);
                case 4:
                    strcpy(temp->Forename, temporary);
                case 5:
                    strcpy(temp->Age, temporary);
                case 6:
                    strcpy(temp->Person_Type, temporary);
                case 7:
                    strcpy(temp->Gender, temporary);
                case 8:
                    strcpy(temp->Nationality, temporary);
                case 9:
                    strcpy(temp->Religion, temporary);
                case 10:
                    strcpy(temp->Occupation, temporary);
                //Person ID,Deposition ID,Surname,Forename,Age,Person Type,Gender,Nationality,Religion,Occupation
            }
            
            i = 0;

        }

        //printf("%s \n", temporary);
        newElement(temp);

        if(feof(MyFile))
        {
            break;
        }
    }

    fclose(MyFile);
    return NULL;
}

int main(int argc, char *argv[])
{
    initialize();

    if(argv[1] != NULL)
    {
        read_file(argv[1]);
        printf("File %s loaded\n", argv[1]);
    }
    else
    {
        read_file("people.csv");
        printf("File people.csv loaded\n");
    }

    float N = numTerms;
    float load = N/ARRAY_SIZE;
    printf(" Capacity: %d\n", ARRAY_SIZE);
    printf(" Num Terms: %d\n", numTerms);
    printf(" Collisions: %d\n", collisions);
    printf(" Load: %f\n", load);
    printf("Enter term to get frequency or type \"quit\" to escape\n");
    
    //*
    char input[MAX_STRING_SIZE];
    do
    {
        int found = 0;
        memset(input, 0, MAX_STRING_SIZE);
        printf(">>> ");
        fgets(input, MAX_STRING_SIZE, stdin);
        if ((strlen(input) > 0) && (input[strlen (input) - 1] == '\n'))
        {
            input[strlen (input) - 1] = '\0';
        }
        //https://stackoverflow.com/questions/1247989/how-do-you-allow-spaces-to-be-entered-using-scanf
        
        int pos = hash_function(input);
        Node *nextNode = elements[pos].head;
        while(nextNode != NULL)
        {
            if(!strcmp(nextNode->Surname, input) && found == 0)
            {
                printf("Person ID Deposition ID Surname Forename Age Person Type Gender Nationality Religion Occupation\n");
                found = 1;
            }
            if(!strcmp(nextNode->Surname, input))
            {
                printf("%s %s %s %s %s %s %s %s %s %s\n", nextNode->Person_ID, nextNode->Deposition_ID, 
                nextNode->Surname, nextNode->Forename, nextNode->Age, nextNode->Person_Type, nextNode->Gender, 
                nextNode->Nationality, nextNode->Religion, nextNode->Occupation);
            }
            nextNode = nextNode->next;
        }

        if(found == 0 && strcmp(input, "quit"))
        {
            printf("%s not in table\n", input);
        }

    } while (strcmp(input, "quit"));
    //*/

    return 0;
}