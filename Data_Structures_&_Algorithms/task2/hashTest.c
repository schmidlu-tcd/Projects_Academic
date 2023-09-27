#include <stdio.h>
#include <stdlib.h>

int hash_function(char *s)
{ 
    int hash = 0; 
    int i = 0;

    while(s[i] != '\0') 
    {
        printf("%c = %d\n", s[i], s[i]);
        hash = hash + s[i] * (99109^i);
        s++;
        i++;
    }
    return(hash % 115249);
}

int main()
{
    char word1[] = {'W','a','l','u','i','g','i','\0'};

    char word2[] = {'B', 'O', 'O','\0'};

    char word3[] = {'O', 'B', 'O','\0'};

    printf("word 1 hash = %d, word 2 hash = %d, word 3 hash = %d\n", hash_function(word1), hash_function(word2), hash_function(word3));
    printf("word 1 hash = %d, word 2 hash = %d, word 3 hash = %d\n", hash_function(word1), hash_function(word2), hash_function(word3));

    return 0;

}