#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define ARRAY_SIZE 59
#define MAX_STRING_SIZE 20

int collisions = 0;
int numTerms = 0;

//updated hash function
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

//defining the struct
typedef struct element element;
struct element
{
    int hash_pos;
    char data[MAX_STRING_SIZE];
    int counter;
};

//creates array of structs (our hash table)
element elements[ARRAY_SIZE];

//set all counts to 0 and data to "NULL"
void initialize()
{
    for(int i = 0; i < ARRAY_SIZE; i++)
    {
        strcpy(elements[i].data, "NULL");
        elements[i].counter = 0;
    }
}

//finds the element in the array, NULL if not there
element *findElement(char *name)
{
    //check array for the name
    for(int i = 0; i < ARRAY_SIZE; i++)
    {
        if(elements[i].counter > 0) //checks if element has been filled
        {
            if(!strcmp(elements[i].data, name)) //checks if element has the same name
            {
                //printf("%s  - name: %s\n", elements[i].data, name); //for debugging
                //printf("%s  -  %d  -  %d\n", elements[i].data, elements[i].hash_pos, elements[i].counter); //for debugging
                //if name is found, return pointer to the struct of the name 
                return &elements[i];
            }
        }
    }
    //if no name is found, NULL is returned
    return NULL;
}

//creates new element with hash values
void newElement(char *name)
{
    //starts at hash position
    int position = hash_function(name);
    //printf("%d \n",hash_function(name)); //for debugging
    int noLoopBool = 0;

    //while the elements are occupied, 
    while(elements[position].counter > 0)
    {
        //increment collisions and positions
        collisions++;
        position++;
        if(position == ARRAY_SIZE)
        {
            position = 0;
            if(noLoopBool == 1) //prevents loops
            { 
                break; 
            }
            noLoopBool = 1;
        }
    }
    //copy info to hash table
    strcpy(elements[position].data, name); 
    elements[position].hash_pos = position;
    elements[position].counter = 1;
    numTerms++; //increments terms
    //printf("%s  -  %d  -  %d\n", elements[position].data, elements[position].hash_pos, elements[position].counter); //for debugging
}

//puts element into the table (if existent add 1 to counter else creates new)
void addElement(char *name)
{
    //Uses findElement() to look for the element
    if(findElement(name) == NULL)
    {
        //if not found, create new element
        newElement(name);
    }
    else
    {
        //increment counter if already in the table
        //printf("%s - %d\n", findElement(name)->data, findElement(name)->counter); //for debugging
        findElement(name)->counter = findElement(name)->counter + 1;
        //printf("%s - %d\n", findElement(name)->data, findElement(name)->counter); //for debugging
    }
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

    //while file has not finished
    while(!feof(MyFile))
    {
        int pos = 0; //position for the temporary array
        char c = fgetc(MyFile); //gets character from file
        if(feof(MyFile)) //to make sure the loop ends
        {
            break;
        }
        while(c != '\n' && pos < MAX_STRING_SIZE)
        {
            //printf("%c",c); //for debugging
            temporary[pos] = c; //puts c into temporary array
            c = fgetc(MyFile);
            if(feof(MyFile)) //to make sure the loop ends
            {
                break;
            }
            pos++; //increment position
        }
        //printf("%s \n", temporary); //for debugging
        addElement(temporary); //adds temporary array to hash table
        memset(temporary, 0, MAX_STRING_SIZE); //reset temporary array
    }

    fclose(MyFile); //closes file
    return NULL;
}

int main(int argc, char *argv[])
{
    initialize();
    
    if(argv[argc] != NULL)
    {
        read_file(argv[1]);
        printf("File %s loaded\n", argv[1]);
    }
    else
    {
        read_file("names.csv");
        printf("File names.csv loaded\n");
    }

    float N = numTerms;
    float load = N/ARRAY_SIZE;
    printf(" Capacity: %d\n", ARRAY_SIZE);
    printf(" Num Terms: %d\n", numTerms);
    printf(" Collisions: %d\n", collisions);
    printf(" Load: %f\n", load);
    printf("Enter term to get frequency or type \"quit\" to escape\n");

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
        
        for(int i = 0; i < ARRAY_SIZE; i++) 
        { 
            if(!strcmp(input, elements[i].data) && strcmp(input, "quit"))
            {
                printf("%s - %d\n", elements[i].data, elements[i].counter);
                found = 1;
            }
        }
        if(found == 0 && strcmp(input, "quit"))
        {
            printf("%s - 0\n", input);
        }

    } while (strcmp(input, "quit"));
    
    return 0;
}