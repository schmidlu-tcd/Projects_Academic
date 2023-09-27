#include <stdio.h> 
#include "t2.h"

int number_comparisons = 0;
int number_swaps = 0;

//swaps two values in an array index a and b
void swap(int arr[], int a, int b)
{
  int buffer = arr[a];
  arr[a] = arr[b];
  arr[b] = buffer;
}

//Selection Sort:
//scans array and selects smallest value to be put at the lowest index
void selectionSort(int arr[], int size)
{ 
  number_comparisons = 0;
  number_swaps = 0;

  //Goes through array and select smallest, swap with first position, then go again ignoring first
  //position and swap with second position.
  int smallest;
  int current;
  int pos;

  for(int arrayPos = 0; arrayPos < size - 1; arrayPos++)
  {
    //smallest is the lowest position we will check
    smallest = arr[arrayPos];
    pos = arrayPos;

    //checks from current position to the end of array
    for(int i = arrayPos + 1; i < size; i++)
    {
      //makes current be equal to array at position i
      current = arr[i];
      number_comparisons++;
      if(current < smallest)
      {
        smallest = current;
        pos = i;
      }
    }
    current = arr[arrayPos];
    /*
    printf("smallest: %d\n", smallest);
    printf("pos: %d\n", pos);
    printf("arrayPos: %d\n", arrayPos);
    */
    number_comparisons++;
    if(current > arr[pos])
    {
      number_swaps++;
      arr[pos] = current;
      arr[arrayPos] = smallest;
    }
    
  }

} 
//end of Selection Sort

//Insertion Sort:
//swaps values until the lowest is at the lowest index and repeats
void insertionSort(int arr[], int size) 
{ 
  number_comparisons = 0;
  number_swaps = 0;
  //Go through array, if [i+1] < [i], swap those values until it is not true
  for(int arrayPos = 0; arrayPos < size; arrayPos++)
  {
    for(int i = arrayPos; i > 0; i--)
    {
      number_comparisons++;
      if(arr[i] < arr[i-1])
      {
        number_swaps++;
        swap(arr, i, i - 1);
      }
    }
  }
  
}
//end of Insertion Sort

//Quick Sort:
//function to create partitions
int partition(int arr[], int low, int high)
{
  int L = low; //Left value
  int R = high; //Right value
  int pivot = high - 1; //pivot is the number of highest value

  //to check if it is a 2 element array
  if(high - low == 1)
  {
    number_comparisons++;
    if(arr[L] > arr[R])
    {
      swap(arr, L, R);
      number_swaps++;
    }
  }

  while (L < pivot)
  {
    number_comparisons++;
    if(arr[L] < arr[pivot] && arr[R] < arr[pivot] && L == pivot - 1) //for a specific issue that was causing problems
    {
      swap(arr, pivot, R);
      number_swaps++;
      pivot++;
      L++;
    }
    else if(arr[L] < arr[pivot]) //increase left index if less than pivot
    {
      L++;
    }
    else if(arr[R] < arr[pivot]) //check if Right value is higher than pivot
    {
      //if lower, swap with L
      swap(arr, L, R);
      number_swaps++;
      L++;
    }
    else 
    {
      //move pivot lower
      swap(arr, pivot, pivot - 1);
      number_swaps++;
      pivot--;
      R--;
    }
  }
  //returns location of pivot
  return pivot;
}

//recursive function
void recursiveQuickSort(int arr[], int start, int end)
{
  //checks if the partition is existant
  if(start < end)
  {
    //gets pivot location
    int pivotPosition = partition(arr, start, end);

    //higher partition
    recursiveQuickSort(arr, pivotPosition + 1, end);

    //lower partition
    recursiveQuickSort(arr, start, pivotPosition - 1);
  }
}

//function that calls recursive quicksort
void quickSort(int arr[], int size) 
{ 
  number_comparisons = 0;
  number_swaps = 0;
  recursiveQuickSort(arr, 0, (size - 1));
}
//end of Quick Sort