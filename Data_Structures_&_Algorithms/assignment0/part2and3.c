#include <stdio.h>

int main(int argc, char *argv[]) 
{
    char c;
    int quotesBool = 0;
    int firstRowBool = 0;

    //get file
    FILE *MyFile;
    for(int i = 0; i < argc; i++) 
    {
        //open file
        MyFile = fopen("pokemon.csv", "r");
        
        if(MyFile == NULL) 
        {
            perror("File can't be opened");
        }
        else
        {
            //read char into c
            c = fgetc(MyFile);
            while(c != '\0')
            {
                if(c == '"') //to deal with commas inside of quotation marks
                {
                    if(quotesBool == 0)
                    {
                        quotesBool = 1;
                    }
                    else
                    {
                        quotesBool = 0;
                    }
                    c = fgetc(MyFile);
                    
                }
                if(feof(MyFile))
                {
                    printf("\n");
                    printf("\n");
                    return 0;
                }
                if(firstRowBool > 0)
                {
                    if(c == ',' && quotesBool == 0) 
                    {
                    printf(" \n");
                    }
                    else
                    {
                        //print character
                        printf("%c", c);
                    }
                }
                if(c == '\n') //to make sure that the first row is read
                {
                    if(firstRowBool == 1)
                    {
                        firstRowBool = 2;
                    }
                    if(firstRowBool == 2)
                    {
                        printf("\n");
                    }
                    firstRowBool = 1;
                }
                c = fgetc(MyFile);
            }
            
        }

    }

    return 0;
}