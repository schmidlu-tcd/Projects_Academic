#include "t1.h"
#include "t2.h"
#include <stdio.h>



int main()
{
    int size = 20;
    int array[size];

    fill_ascending(array, size);
    printArray(array, size);
    selectionSort(array, size);
    printf("selection:");
    printArray(array, size);
    fill_ascending(array, size);
    printf("insertion:");
    insertionSort(array, size);
    printArray(array, size);
    fill_ascending(array, size);
    quickSort(array, size);
    printf("quick:");
    printArray(array, size);
    printf("\n");

    fill_descending(array, size);
    printArray(array, size);
    selectionSort(array, size);
    printf("selection:");
    printArray(array, size);
    fill_descending(array, size);
    insertionSort(array, size);
    printf("insertion:");
    printArray(array, size);
    fill_descending(array, size);
    quickSort(array, size);
    printf("quick:");
    printArray(array, size);
    printf("\n");

    fill_uniform(array, size);
    printArray(array, size);
    selectionSort(array, size);
    printf("selection:");
    printArray(array, size);
    fill_uniform(array, size);
    insertionSort(array, size);
    printf("insertion:");
    printArray(array, size);
    fill_uniform(array, size);
    quickSort(array, size);
    printf("quick:");
    printArray(array, size);
    printf("\n");

    fill_with_duplicates(array, size);
    printArray(array, size);
    selectionSort(array, size);
    printf("selection:");
    printArray(array, size);
    fill_with_duplicates(array, size);
    insertionSort(array, size);
    printf("insertion:");
    printArray(array, size);
    fill_with_duplicates(array, size);
    quickSort(array, size);
    printf("quick:");
    printArray(array, size);
    printf("\n");

    fill_without_duplicates(array, size);
    printArray(array, size);
    selectionSort(array, size);
    printf("selection:");
    printArray(array, size);
    fill_without_duplicates(array, size);
    insertionSort(array, size);
    printf("insertion:");
    printArray(array, size);
    fill_without_duplicates(array, size);
    quickSort(array, size);
    printf("quick:");
    printArray(array, size);
    printf("\n");

    return 0;
}