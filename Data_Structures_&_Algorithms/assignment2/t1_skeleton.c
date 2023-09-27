#include <stdio.h>
#include <stdlib.h>
#include "t1.h"
#include <time.h>

//Fills the array with ascending, consecutive numbers, starting from 0.
void fill_ascending(int *array, int size)
{
    for(int i = 0; i < size; i++)
    {
        array[i] = i;
    }
}

//Fills the array with descending numbers, starting from size-1
void fill_descending(int *array, int size)
{
    int number = size;
    for(int i = 0; i < size; i++)
    {
        number--;
        array[i] = number;
    }
}

//Fills the array with uniform numbers.
void fill_uniform(int *array, int size)
{
    for(int i = 0; i < size; i++)
    {
        array[i] = 0;
    }
}

//Fills the array with random numbers within 0 and size-1. Duplicates are allowed.
void fill_with_duplicates(int *array, int size)
{
    /*
    srand((unsigned) time(NULL));
    //https://www.tutorialspoint.com/c_standard_library/c_function_rand.htm#:~:text=The%20C%20library%20function%20int,to%20be%20at%20least%2032767.
    */

    for(int i = 0; i < size; i++)
    {
        array[i] = rand() % size;
    }
}


//Fills the array with unique numbers between 0 and size-1 in a shuffled order. Duplicates are not allowed.
void fill_without_duplicates(int *array, int size)
{

    /*
    srand((unsigned) time(NULL)*3);
    //https://www.tutorialspoint.com/c_standard_library/c_function_rand.htm#:~:text=The%20C%20library%20function%20int,to%20be%20at%20least%2032767.
    */

    int number;
    int finderBool;
    int i = 0;
    while(i < size)
    {
        finderBool = 0;
        number = (rand() % 200) % size;
        for(int index = 0; index < i; index++)
        {
            if(array[index] == number)
            {
                finderBool = 1;
            }
        }
        if(finderBool == 0)
        {
            array[i] = number;
            i++;
        }
    }
}

void printArray(int* arr, int size){
  int i;
  for(i=0; i<size;i++){
    printf("%d ", arr[i]);
  }
  printf("\n");
}