#include "bstdb.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define maxStringSize 64


//====== STRUCT ===============================================================
typedef struct Tree_Node Tree_Node;
struct Tree_Node
{
    char bookName[maxStringSize];
	int wordCount;
	unsigned int level;
	unsigned int ID;
    Tree_Node *left;
    Tree_Node *right;
};
//=============================================================================



//Creates root and IDcount to be used by multiple functions====================
Tree_Node *root = NULL;
unsigned int IDcount;
unsigned int maxRight;
unsigned int maxLeft;
unsigned int rotations;
unsigned int nodesChecked;
unsigned int timesSearched;
int levelDif;
//=============================================================================



//=== FUNCTION ================================================================
//         Name: new_Node
//  Description: Creates a new node
//=============================================================================
Tree_Node *new_Node(char *name, int Count, int newId)
{
  Tree_Node *temp = (Tree_Node*)malloc(sizeof(Tree_Node));
  strcpy(temp->bookName, name);
  temp->wordCount = Count;
  temp->ID = newId;
  temp->level = 1;
  temp->left = NULL;
  temp->right = NULL;
  return temp;
}



//=== FUNCTION ================================================================
//         Name: bstdb_init
//  Description: Initializes values
//=============================================================================
int bstdb_init ( void )
{
	IDcount = 0;
	rotations = 0;
	nodesChecked = 0;
	timesSearched = 0;
	return 1;
}



//=== FUNCTION ================================================================
//         Name: max
//  Description: Gets max of two ints
//=============================================================================
int max(int a, int b)
{
	if(a > b)
	{
		return a;
	}
	else
	{
		return b;
	}
}



//=== FUNCTION ================================================================
//         Name: level
//  Description: Gets level
//=============================================================================
int level(Tree_Node *node)
{
	if(node == NULL)
	{
		return 0;
	}
	else 
	{
		return node->level;
	}
}



//=== FUNCTION ================================================================
//         Name: rightRotate
//  Description: Inserts the node as the right node of its left node
//				 and returns the location of the left node
//=============================================================================
Tree_Node *rightRotate(Tree_Node *node)
{
	rotations++;
	Tree_Node *temp = node->left;
	node->left = temp->right;
	temp->right = node;

	node->level = 1 + max(level(node->left), level(node->right));
	temp->level = 1 + max(level(temp->right), level(temp->left));

	return temp;
}



//=== FUNCTION ================================================================
//         Name: leftRotate
//  Description: Inserts the node as the left node of its right node
//				 and returns the location of the right node
//=============================================================================
Tree_Node *leftRotate(Tree_Node *node)
{
	rotations++;
	Tree_Node *temp = node->right;
	node->right = temp->left;
	temp->left = node;

	node->level = 1 + max(level(node->left), level(node->right));
	temp->level = 1 + max(level(temp->right), level(temp->left));

	return temp;
}



//=== FUNCTION ================================================================
//         Name: tree_search_id
//  Description: Searches for element with given ID and returns location
//=============================================================================
Tree_Node* tree_search_id(Tree_Node* treeRoot, int ID, int Bool)
{
	nodesChecked++;
	if(treeRoot == NULL)
	{
		return NULL;
	}
	if(ID == treeRoot->ID)
	{
		return treeRoot;
	}
	else if(root == NULL)
	{
		return NULL;
	}
	else if(ID < treeRoot->ID)
	{
		return tree_search_id(treeRoot->left, ID, Bool);
	}
	else if(ID > treeRoot->ID)
	{
		return tree_search_id(treeRoot->right, ID, Bool);
	}
		return NULL;
}



//=== FUNCTION ================================================================
//         Name: tree_search_name
//  Description: Searches for element with given name and returns location
//=============================================================================
Tree_Node* tree_search_name(Tree_Node* treeRoot, char *name)
{
	if(treeRoot == NULL)
	{
		return NULL;
	}
	if(!strcmp(name,treeRoot->bookName))
	{
		return treeRoot;
	}
	if(treeRoot->left != NULL)
	{
		return tree_search_name(treeRoot->left, name);
	}
	if(treeRoot->right != NULL)
	{
		return tree_search_name(treeRoot->right, name);
	}
	return NULL;
}



//=== FUNCTION ================================================================
//         Name: bstdb_get_word_count
//  Description: Gets word count of element with given ID
//=============================================================================
int bstdb_get_word_count ( int doc_id )
{
	timesSearched++;
	Tree_Node *search = tree_search_id(root, doc_id, 1);
	if(search == NULL)
	{
		return -1;
	}
	else
	{
		return search->wordCount;
	}
}



//=== FUNCTION ================================================================
//         Name: bstdb_get_name
//  Description: Gets name of element with given ID
//=============================================================================
char* bstdb_get_name ( int doc_id ) 
{
	timesSearched++;
	Tree_Node *search = tree_search_id(root, doc_id, 0);
	if(search == NULL)
	{
		return NULL;
	}
	else
	{
		return search->bookName;
	}
}



//=== FUNCTION ================================================================
//         Name: tree_insert
//  Description: Function to insert nodes and keep the tree balanced
//=============================================================================
void tree_insert(Tree_Node** treeRoot, Tree_Node *node)
{
	if(node->ID > (*treeRoot)->ID) //if ID is more than the root's, add to the right
	{
		if((*treeRoot)->right == NULL)
		{
			(*treeRoot)->right = node;
		}
		else
		{
			//recursive with right node
			tree_insert(&(*treeRoot)->right, node); 
		}
	}
	else if(node->ID < (*treeRoot)->ID) //if ID is less than root's, add to the left
	{
		if((*treeRoot)->left == NULL)
		{
			(*treeRoot)->left = node;
		}
		else
		{
			//recursive with left node
			tree_insert(&(*treeRoot)->left, node);
		}
	}
	
	(*treeRoot)->level = 1 + max(level((*treeRoot)->left), level((*treeRoot)->right));

	if((*treeRoot)->left != NULL || (*treeRoot)->right != NULL)
	{
		//set max level of the left to be the current node height unless it has left nodes
		maxLeft = 0;
		if((*treeRoot)->left != NULL)
		{
			maxLeft = max(level((*treeRoot)->left->left), level((*treeRoot)->left->right));
		}

		//set max level of the right to be level of the node unless it has right nodes
		maxRight = 0;
		if((*treeRoot)->right != NULL)
		{
			maxRight = max(level((*treeRoot)->right->left), level((*treeRoot)->right->right));
		}
		
		//compare left and right max levels
		levelDif = maxLeft - maxRight;
		if(levelDif > 1)
		{
			//rotates to the right if more on the left
			(*treeRoot) = rightRotate((*treeRoot));
		}
		else if(levelDif < -1)
		{
			//rotates to the left if more on the right
			(*treeRoot) = leftRotate((*treeRoot));
		}
	}
}



//=== FUNCTION ================================================================
//         Name: bstdb_add
//  Description: Function to add new elements to the tree and 
//				 increments ID
//=============================================================================
int bstdb_add ( char *name, int word_count )
{
	//ID system will be a counter that just goes up
	IDcount++;
	
	if(root == NULL) //to create root
	{
		//new root
		root = new_Node(name, word_count, IDcount);
	}
	else 
	{
		//add to the tree
		tree_insert(&root, new_Node(name, word_count, IDcount));
	}
	//return new ID
	return IDcount;
}



//=== FUNCTION ================================================================
//         Name: bstdb_stat
//  Description: Prints some statistics of the code
//=============================================================================
void bstdb_stat ( void ) 
{
	printf("-------------------------------------------\n");
	printf("\n");
	printf("STAT\n");
	printf("-------------------------------------------\n");
	printf("\n");
	printf("Number of Unique IDs         : %12d\n", IDcount);
	printf("Number of Levels             : %12d\n", root->level);
	printf("Number of Rotations          : %12d\n", rotations);
	printf("Average nodes per search     : %12d\n", nodesChecked/timesSearched);
	printf("\n");
	printf("-------------------------------------------\n");
}



//=== FUNCTION ================================================================
//         Name: tree_delete
//  Description: Function to delete tree and free memory
//=============================================================================
void tree_delete(Tree_Node* treeRoot)
{
  if(treeRoot != NULL)
  {
    tree_delete(treeRoot->left);
    treeRoot->left = NULL;
    tree_delete(treeRoot->right);
    treeRoot->right = NULL;
    free(treeRoot);
  }
}



//=== FUNCTION ================================================================
//         Name: bstdb_quit
//  Description: Function to be run at the end of the program
//=============================================================================
void bstdb_quit ( void ) 
{
	//Deletes the tree
	tree_delete(root);
}