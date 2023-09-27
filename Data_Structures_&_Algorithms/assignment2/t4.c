#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define stringSize 120
#define arraySize 20000

typedef struct element element;
struct element
{
    char title[stringSize];
    char platform[stringSize];
    int score;
    char releaseYear[stringSize];
};

element Games[arraySize];

void initialize()
{
    for(int i = 0; i < arraySize; i ++)
    {
        Games[i].score = 0;
    }
}

//swaps two values in an array index a and b
void swap(element arr[], int a, int b)
{
  int buffer = arr[a].score;
  arr[a].score = arr[b].score;
  arr[b].score = buffer;

  char bufferC[stringSize];
  strcpy(bufferC, arr[a].platform);
  strcpy(arr[a].platform, arr[b].platform);
  strcpy(arr[b].platform, bufferC);

  strcpy(bufferC, arr[a].title);
  strcpy(arr[a].title, arr[b].title);
  strcpy(arr[b].title, bufferC);

  strcpy(bufferC, arr[a].releaseYear);
  strcpy(arr[a].releaseYear, arr[b].releaseYear);
  strcpy(arr[b].releaseYear, bufferC);
}

//Quick Sort:
//function to create partitions
int partition(element arr[], int low, int high)
{
  int L = low; //Left value
  int R = high; //Right value
  int pivot = high - 1; //pivot is the number of highest value

  //to check if it is a 2 element array
  
  if(high - low == 1)
  {
    
    if(arr[L].score > arr[R].score)
    {
      swap(arr, L, R);
    }
  }

  while (L < pivot)
  {
    if(arr[L].score < arr[pivot].score && arr[R].score < arr[pivot].score && L == pivot - 1) //for a specific issue that was causing problems
    {
      swap(arr, pivot, R);
      pivot++;
      L++;
    }
    else if(arr[L].score < arr[pivot].score) //increase left index if less than pivot
    {
      L++;
    }
    else if(arr[R].score < arr[pivot].score) //check if Right value is higher than pivot
    {
      //if lower, swap with L
      swap(arr, L, R);
      L++;
    }
    else 
    {
      //move pivot lower
      swap(arr, pivot, pivot - 1);
      pivot--;
      R--;
    }
  }
  //returns location of pivot
  return pivot;
}

//recursive function
void recursiveQuickSort(element arr[], int start, int end)
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
void quickSort(element arr[], int size) 
{ 
  recursiveQuickSort(arr, 0, (size - 1));
}
//end of Quick Sort

void newElement(element *temp)
{
    int i = 0;
    while(Games[i].score > 0 && i <= arraySize)
    {
        i++;
    }
    if(i < arraySize)
    {
        strcpy(Games[i].platform, temp->platform);
        strcpy(Games[i].releaseYear, temp->releaseYear);
        Games[i].score = temp->score;
        strcpy(Games[i].title, temp->title);
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
    
    char temporary[stringSize];
    element *temp = (element*)malloc(sizeof(element));
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
            memset(temporary, 0, stringSize);

            c = fgetc(MyFile);           
            while(c != '\n')
            {
                //"Stubbs the Zombie in ""Rebel without a Pulse"""
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
                    strcpy(temp->title, temporary);
                    break;
                case 2:
                    strcpy(temp->platform, temporary);
                    break;
                case 3:
                    temp->score = atoi(temporary);
                    break;
                case 4:
                    strcpy(temp->releaseYear, temporary);
                    break;
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
    free(temp);
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
        read_file("t4_ign.csv");
        printf("File t4_ign.csv loaded\n");
    }

    quickSort(Games, arraySize);
    printf("%-40s %-20s %-9s %s\n", "Title", "Platform", "Score", "Release Year");
    int top10 = 0;
    for(int i = 0; i < arraySize; i++)
    {
        if(Games[i].score == 10 && 2022 - atoi(Games[i].releaseYear) <= 20 && top10 < 10)
        {
            printf("- %-38s - %-18s - %-7d - %s\n", Games[i].title, Games[i].platform, Games[i].score, Games[i].releaseYear);
            top10++;
        }
    }

    return 0;
}