#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "t2.h"

#define infinity 999999

//creates node
Node *createNode(Node *temp)
{
    Node *newNode = (Node*)malloc(sizeof(Node));
    newNode->stopNumber = temp->stopNumber;
    strcpy(newNode->stopName, temp->stopName);
    strcpy(newNode->latitude, temp->latitude);
    strcpy(newNode->longitude, temp->longitude);
    newNode->next = NULL;
    return newNode;
}

//creates path node
Path *createPath(int stopTo, int Distance)
{
    Path *newPath = (Path*)malloc(sizeof(Path));
    newPath->node = stopTo;
    newPath->weight = Distance;
    newPath->next = NULL;
    return newPath;
}

//adds path to node in increasing order
void addPath(int stopFrom, int stopTo, int Distance)
{
    Path *temp = Graph[stopFrom]->next;
    int insertBool = 0;

    if(temp == NULL)
    {
        Graph[stopFrom]->next = createPath(stopTo, Distance);
    }
    else
    {
        if(temp->weight > Distance)
        {
            Graph[stopFrom]->next = createPath(stopTo, Distance);
            Graph[stopFrom]->next->next = temp;
            insertBool = 1;
        }
        else
        {
            while(temp->next != NULL)
            {
                if(temp->next->weight < Distance)
                {
                    temp = temp->next;
                }
                else
                {
                    Path *temp2 = temp->next;
                    temp->next = createPath(stopTo, Distance);
                    temp->next->next = temp2;
                    temp2 = NULL;
                    insertBool = 1;
                    break;
                }
            }
        }
        if(insertBool == 0)
        {
            temp->next = createPath(stopTo, Distance);
        }
    }
}

//loads edges, function used in previous assignments
int load_edges ( char *fname )
{ 
    //loads the edges from the CSV file of name fname
    FILE *MyFile;
    MyFile = fopen(fname, "r");
    if(MyFile == NULL) 
    {
        //if file isn't open
        printf("File can't be opened");
        return -1;
    }
    
    char temporary[maxStringLen];
    int stopA;
    int stopB;
    int Distance;
    int count = 0;
    int firstRowBool = 0;
    char c = fgetc(MyFile);

    while(!feof(MyFile))
    {
        while(c != '\n' && firstRowBool == 0)
        {
            c = fgetc(MyFile);
        }
        firstRowBool = 1;
        for(int num = 1; num <= 3; num++)
        {
            int i = 0;
            int commaBool = 0;
            memset(temporary, 0, maxStringLen);

            c = fgetc(MyFile);           
            while(c != '\n')
            {
                if(c == '"')
                {
                    c = fgetc(MyFile);

                    if(c == '"') //to prevent empty spaces
                    {
                        c = fgetc(MyFile);
                        if(c == ',')
                        {
                            break;
                        }
                        if(c == '"') //to prevent empty spaces
                        {
                            c = fgetc(MyFile);
                            if(c == ',')
                            {
                                break;
                            }
                        }
                    }
                    if(feof(MyFile)) { break; }
                    if(commaBool == 0) //to prevent commas
                    { 
                        commaBool = 1;
                    }
                    else
                    { 
                        commaBool = 0;
                    }
                }
                //conditions to end string
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
                    stopA = atoi(temporary);
                    break;
                case 2:
                    stopB = atoi(temporary);
                    break;
                case 3:
                    Distance = atoi(temporary);
                    break;
            }
            i = 0;
        }

        //creates paths in both nodes
        addPath(stopA, stopB, Distance);
        addPath(stopB, stopA, Distance);
        count++;

        if(feof(MyFile))
        {
            break;
        }
    }
    printf("Loaded %d edges\n", count);
    fclose(MyFile);
    return 1;
}

//loads vertices, function used in previous assignments
int load_vertices ( char *fname )
{  
    int count = 0;
    //loads the vertices from the CSV file of name fname
    for(int i = 0; i < maxNodes; i++)
    {
        Graph[i] = NULL;
    }

    FILE *MyFile;
    MyFile = fopen(fname, "r");
    if(MyFile == NULL) 
    {
        //if file isn't open
        printf("File can't be opened");
        return -1;
    }
    
    char temporary[maxStringLen];
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
        for(int num = 1; num <= 4; num++)
        {
            int i = 0;
            int commaBool = 0;
            memset(temporary, 0, maxStringLen);

            c = fgetc(MyFile);           
            while(c != '\n')
            {
                if(c == '"')
                {
                    c = fgetc(MyFile);
                    if(c == '"') //to prevent empty spaces
                    {
                        c = fgetc(MyFile);
                        if(c == ',')
                        {
                            break;
                        }
                        if(c == '"') //to prevent empty spaces
                        {
                            c = fgetc(MyFile);
                            if(c == ',')
                            {
                                break;
                            }
                        }
                    }
                    if(feof(MyFile)) { break; }
                    if(commaBool == 0) //to prevent commas
                    { 
                        commaBool = 1;
                    }
                    else
                    { 
                        commaBool = 0;
                    }
                }
                //conditions to end string
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
                    temp->stopNumber = atoi(temporary);
                    break;
                case 2:
                    strcpy(temp->stopName, temporary);
                    break;
                case 3:
                    strcpy(temp->latitude, temporary);
                    break;
                case 4:
                    strcpy(temp->longitude, temporary);
                    break;
            }
            i = 0;
        }
        Graph[temp->stopNumber] = createNode(temp);
        count++;
        if(feof(MyFile))
        {
            break;
        }
    }
    printf("Loaded %d vertices\n", count);
    free(temp);
    fclose(MyFile);
    return 1;
}

//creates heap node
heap *newHeapNode(int node, int from, int distance)
{
    heap *newNode = (heap*)malloc(sizeof(heap));
    newNode->from = from;
    newNode->node = node;
    newNode->totalDistance = distance;
    newNode->next = NULL;
    return newNode;
}

//adds node to heap
heap *addToHeap(heap *H, int node, int from, int distance)
{
    int insertBool = 0;
    
    if(H == NULL)
    {
        H = newHeapNode(node, from, distance);
    }
    else
    {
        heap *temp = H;
        if(H->totalDistance > distance)
        {
            H = newHeapNode(node, from, distance);
            H->next = temp;
            insertBool = 1;
        }
        else 
        {
            while(temp->next != NULL)
            {
                //FIX THIS
                if(temp->next->totalDistance > distance && insertBool == 0)
                {
                    heap *temp2 = temp->next;
                    temp->next = newHeapNode(node, from, distance);
                    temp->next->next = temp2;
                    temp2 = NULL;
                    insertBool = 1;
                }
                temp = temp->next;
            }
            if(insertBool == 0)
            {
                temp->next = newHeapNode(node, from, distance);
            }
        }
    }
    return H;
}

heap *findInHeap(heap *H, int toFind)
{
    heap *temp = H;
    while(temp != NULL)
    {
        if(temp->node == toFind)
        {
            return temp;
        }
        temp = temp->next;
    }
    return NULL;
}

heap *removeFromHeap(heap *H, int toRemove)
{
    heap *temp = H;
    if(temp->node == toRemove)
    {
        H = temp->next;
        free(temp);
    }
    else
    {
        while(temp->next != NULL)
        {
            if(temp->next->node == toRemove)
            {
                heap *temp2 = temp->next;
                temp = temp->next->next;
                free(temp2);
            }
            temp = temp->next;
        }
    }
    return H;
}

void freeHeap(heap *H)
{
    while(H != NULL)
    {
        heap *temp = H->next;
        free(H);
        H = temp;
    }
}

void shortest_path(int startNode, int endNode)
{
    // prints the shortest path between startNode and endNode, if there is any
    //1-Set all nodes as unvisited and infinite distance
    int prev[maxNodes];
    for(int i = 0; i < maxNodes; i++)
    {
        prev[i] = infinity;
    }

    //2-Set distance of startNode as 0
    prev[startNode] = startNode;
    int currentNode = startNode;

    //create heap with startNode
    heap *H = NULL;
    heap *visited = NULL;
    H = addToHeap(H, startNode, 0, 0);
    visited = addToHeap(visited, startNode, 0, 0);

    //while heap is not empty
    while(H != NULL)
    {
        //set current node
        currentNode = H->node;
        
        Path *temp = Graph[H->node]->next;
        while(temp != NULL)
        {
            //check if in heap
            heap *check = findInHeap(visited, temp->node);
            if(check == NULL)
            {
                //add new node
                prev[temp->node] = currentNode;
                //adds to visited list
                visited = addToHeap(visited, temp->node, currentNode, ((temp->weight)+(H->totalDistance)));
                //adds to heap
                H = addToHeap(H, temp->node, currentNode, ((temp->weight)+(H->totalDistance)));
            }
            else
            {
                //check if path is better and swap if necessary
                if((check->totalDistance) > ((temp->weight)+(H->totalDistance)))
                {
                    prev[temp->node] = currentNode;
                    check->from = currentNode;
                    check->totalDistance = (temp->weight) + (H->totalDistance);
        
                    H = addToHeap(H, temp->node, currentNode, ((temp->weight)+(H->totalDistance)));
                    
                }
            }
            temp = temp->next;    
        }
        //remove current from heap
        H = removeFromHeap(H, currentNode);
    }
    free(H);

    //finds amount of nodes in path
    int count = 0;
    currentNode = endNode;
    if(prev[endNode] < infinity)
    {
        while(currentNode != startNode)
        {
            currentNode = prev[currentNode];
            count++;
        }
        count = count + 1;
        //puts nodes in array in order
        currentNode = endNode;
        int array[count];
        for(int i = count - 2; i >= 0; i--)
        {
            currentNode = prev[currentNode];
            array[i] = currentNode;
        }
        array[count-1] = endNode;

        //prints out shortest path
        for(int i = 0; i < count; i++)
        {
            printf("%d %s\n", Graph[array[i]]->stopNumber, Graph[array[i]]->stopName);
        }
    }
    else
    {
        printf("No path between stop %d and stop %d!", startNode, endNode);
    }
    freeHeap(visited);
}

void free_memory ( void )
{ 
    // frees any memory that was used
    
    // memory is freed within rest of program... 
    //no need for this function but it was given to us so I'll keep it here
}