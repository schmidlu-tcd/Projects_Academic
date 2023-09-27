#include <stdio.h>
#include <stdlib.h>

typedef struct Node Node;
struct Node 
{
    char data;
    Node *next;
};

void add_node(Node **list, char d)
{
    Node *newNode = (Node*)malloc(sizeof(Node)); //create newNode and allocate memory for it
    if (newNode == NULL)
    {
        perror("malloc failed");
    }
    newNode->data = d; //put d inside data
    newNode->next = *list; //point to next pointer
    *list = newNode; //add pointer to the linked list
}

int main()
{
    Node *head = NULL;
    add_node(&head, 'a');
    add_node(&head, 'b');
    add_node(&head, 'c');

    return 0;
}