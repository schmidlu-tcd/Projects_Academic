
#ifndef T2_H_
#define T2_H_

#define maxNodes 7700
#define maxStringLen 50

typedef struct Path Path;
struct Path
{
    int node;
    int weight;
    int from;
    Path *next;
};

typedef struct Node Node;
struct Node
{
    Path *next;
    char stopName[maxStringLen];
    int stopNumber;
    char latitude[maxStringLen];
    char longitude[maxStringLen];
};

Node *Graph[maxNodes];


typedef struct heap heap;
struct heap
{
    int node;
    int from;
    int totalDistance;
    heap *next;
};


int load_edges ( char *fname ); //loads the edges from the CSV file of name fname
int load_vertices ( char *fname );  //loads the vertices from the CSV file of name fname
void shortest_path(int startNode, int endNode); // prints the shortest path between startNode and endNode, if there is any
void free_memory ( void ) ; // frees any memory that was used

#endif
