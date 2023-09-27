#include <stdio.h>
#include <stdlib.h>
#include "bst.h"

Tree_Node *new_Node(char c)
{
  Tree_Node *temp = (Tree_Node*)malloc(sizeof(Tree_Node));
  temp->data = c;
  temp->left = NULL;
  temp->right = NULL;
  return temp;
}

Tree_Node* tree_search(Tree_Node* root, char data)
{
  if(root == NULL){
    return NULL;
  }
  if(data == root->data)
  {
    return root;
  }
  else if(root == NULL)
  {
    return NULL;
  }
  else if(data < root->data)
  {
    return tree_search(root->left, data);
  }
  else if(data > root->data)
  {
    return tree_search(root->right, data);
  }
  return NULL;
}

void tree_insert(Tree_Node** root, char data)
{
  if(data <= (*root)->data)
  {
    if((*root)->left == NULL)
    {
      (*root)->left = new_Node(data);
    }
    else
    {
      tree_insert(&(*root)->left, data);
    }
  }
  else if(data > (*root)->data)
  {
    if((*root)->right == NULL)
    {
      (*root)->right = new_Node(data);
    }
    else
    {
      tree_insert(&(*root)->right, data);
    }
  }
}

Tree_Node* create_bst (char data[])
{
  int i = 1;

  Tree_Node *root = new_Node(data[0]);
  
  while(data[i] != '\0')
  {
    tree_insert(&root, data[i]);
    i++;
  }
  return root;
}

void tree_print_sorted(Tree_Node* root)
{
  if(root->left == NULL)
  {
    printf("%c", root->data);
  }
  else
  {
    tree_print_sorted(root->left);
    printf("%c", root->data);
  }
  if(root->right != NULL)
  {
    tree_print_sorted(root->right);
  }
}

void tree_delete(Tree_Node* root)
{
  if(root != NULL)
  {
    tree_delete(root->left);
    root->left = NULL;
    tree_delete(root->right);
    root->right = NULL;
    free(root);
  }
  
}