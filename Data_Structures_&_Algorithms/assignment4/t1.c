#include <stdio.h>
#include <stdlib.h>
#include "t1.h"

// variable to be used by many functions
int numNodes = 0;

//creates a graph with num_nodes nodes, assuming nodes are stored in alphabetical order (A, B, C..)
Graph* create_graph(int num_nodes)
{
    Graph *newGraph = (Graph*)malloc(sizeof(Graph));
    numNodes = num_nodes;
    for(int i = 0; i < num_nodes; i++)
    {
        newGraph->head[i] = NULL;
    }
    return newGraph;
}

// finds node in graph
int searchNode(Graph *g, int itemToFind)
{ 
    if(g->head[itemToFind] != NULL)
    {
        return 1;
    }
    return 0;
}

// finds edge in graph
int searchEdge(Graph *g, int from, int to)
{
    Node *temp = g->head[from];
    while(temp != NULL)
    {
        if(temp->data == to)
        {
            return 1;
        }
        else
        {
            temp = temp->next;
        }
    }
    return 0;
}

// creates node
Node *newNode(int item)
{
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->data = item;
    newNode->visited = 0;
    newNode->next = NULL;
    return newNode;
}

// adds directed edge
void add_edge(Graph *g, int from, int to)
{
    //make sure the nodes exist
    int fromBool = searchNode(g, from);
    int toBool = searchNode(g, to);
    int insertBool = 0;

    //checks if node exists
    if(fromBool == 1)
    {
        if(toBool == 0)
        {
            g->head[to] = newNode(to);
        }
        if(searchEdge(g, from, to) == 0)
        {
            Node *temp = g->head[from];
            while(temp->next != NULL)
            {
                //adds node in the next available slot in increasing value
                if(temp->next->data < to)
                {
                    temp = temp->next;
                }
                else
                {
                    Node *temp2 = temp->next;
                    temp->next = newNode(to);
                    temp->next->next = temp2;
                    temp2 = NULL;
                    insertBool = 1;
                    break;
                }
            }
            if(insertBool == 0)
            {
                temp->next = newNode(to);
            }
        }
    }
    else //creates new node
    {
        if(toBool == 0)
        {
            g->head[to] = newNode(to);
        }
        g->head[from] = newNode(from);
        g->head[from]->next = newNode(to);
    }
}

// finds node in Queue
int findInQ(Node *Q, int toFind)
{
    Node *temp = Q;
    while(temp != NULL)
    {
        if(temp->data == toFind)
        {
            return 1;
        }
        temp = temp->next;
    }
    return 0;
}

// adds node to Queue
void addToQ(Node *Q, Node *toAdd)
{
    if(Q == NULL)
    {
        Q = toAdd;
    }
    else
    {
        Node *temp = Q;
        while(temp->next != NULL)
        {
            temp = temp->next;
        }
        temp->next = toAdd;
    }
}

//implements breath first search and prints the results
void bfs(Graph* g, int origin)
{
    //initialization
    printf("BFS ");
    for(int i = 0; i < numNodes; i++)
    {
        g->head[i]->visited = 0;
    }

    //Create queue, add origin to queue, mark visited
    //Go through origin's linked list and add those to the queue, mark visited
    //Set Q to Q->next, repeat

    Node *Q = newNode(g->head[origin]->data);
    
    while(Q != NULL)
    {
        printf(" %c ", Q->data+'A');

        g->head[Q->data]->visited = 1;

        Node *temp = g->head[Q->data]->next;

        while(temp != NULL)
        {
            if(findInQ(Q, temp->data) == 0 && g->head[temp->data]->visited == 0)
            {
                g->head[temp->data]->visited = 1;
                addToQ(Q, newNode(temp->data));
            }
            temp = temp->next;
        }
        Node *temp2 = Q->next;

        //free memory
        free(Q);
        Q = temp2;
        temp2 = NULL;
    }
    //free original Q
    free(Q);
    printf("\n");
}

// implements a recursive DFS
void recursiveDFS(Graph *g, int origin)
{
    //only checks non visited nodes
    if(g->head[origin]->visited == 0)
    {
        printf(" %c ", g->head[origin]->data+'A');
        g->head[origin]->visited++;
        Node *temp = g->head[origin]->next;
        while(temp != NULL)
        {
            recursiveDFS(g, temp->data);
            temp = temp->next;
        }
    }
}

//implements depth first search and prints the results
void dfs(Graph* g, int origin)
{
    //initialization
    printf("DFS:");
    for(int i = 0; i < numNodes; i++)
    {
        g->head[i]->visited = 0;
    }
    recursiveDFS(g, origin);
    printf("\n");
}

//delete the graph and all its data structures
void delete_graph(Graph* g)
{
    for(int i = 0; i < numNodes; i++)
    {
        Node *temp = g->head[i]->next;
        Node *tempNext = NULL;
        if(temp != NULL)
        {
            tempNext = temp->next;
        }
        while(temp != NULL)
        {
            free(temp);
            temp = tempNext;
            if(tempNext != NULL)
            {
                tempNext = tempNext->next;
            }
            else
            {
                tempNext = NULL;
            }
        }
        free(g->head[i]);
        g->head[i] = NULL;
    }
    free(g);
}