#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxLength = 300;
int totalLines = 660;
char Temporary[300];

struct pokemon
{
    int number;
    char name[20];
    char type1[10];
    char type2[10];
    int total;
    int hp;
    int attack;
    int defense;
    int spAttack;
    int spDefense;
    int speed;
    int generation;
    char legendary[10];
    char dexEntry[300];
};

struct pokemon eachPokemon[660];

void printStruct(int number);

int main() 
{
    char c;
    int firstRowBool = 0;
    int i = 0;

    FILE *MyFile;
    
        MyFile = fopen("pokemon.csv", "r");
        
        if(MyFile == NULL) {
            perror("File can't be opened");
        }
        else
        {    
            c = fgetc(MyFile);
            while(c != '\0')
            {
                while(c != '\n' && firstRowBool == 0)
                {
                    c = fgetc(MyFile);
                }
                c = fgetc(MyFile);
                for(int pokemonNo = 0; pokemonNo < totalLines; pokemonNo++) 
                {
                    if(feof(MyFile))
                    {
                        break;
                    }
                    i = 0;
                    //number
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].number = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //name
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    for(i = 0; i < 20; i++)
                    {
                        eachPokemon[pokemonNo].name[i] = Temporary[i];
                    }
                    c = fgetc(MyFile);
                    i = 0;

                    //type1
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    for(i = 0; i < 10; i++)
                    {
                        eachPokemon[pokemonNo].type1[i] = Temporary[i];
                    }
                    c = fgetc(MyFile);
                    i = 0;

                    //type2
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    for(i = 0; i < 10; i++)
                    {
                        eachPokemon[pokemonNo].type2[i] = Temporary[i];
                    }
                    c = fgetc(MyFile);
                    i = 0;

                    //total
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].total = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //hp
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].hp = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //attack
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].attack = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //defense
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].defense = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //spAttack
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {

                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].spAttack = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //spDefense
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
        
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].spDefense = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //speed
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].speed = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //generation
                    memset(Temporary, 0, maxLength);                
                    while(c != ',')
                    {

                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    eachPokemon[pokemonNo].generation = atoi(Temporary);
                    c = fgetc(MyFile);
                    i = 0;

                    //legendary
                    memset(Temporary, 0, maxLength);
                    while(c != ',')
                    {
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        i++;
                    }
                    for(i = 0; i < 10; i++)
                    {
                        eachPokemon[pokemonNo].legendary[i] = Temporary[i];
                    }
                    c = fgetc(MyFile);
                    i = 0;

                    //dexEntry
                    memset(Temporary, 0, maxLength);                
                    while(c != '\n')
                    {
                        if(c == '"')
                        {
                            c = fgetc(MyFile);
                        }
                        if(feof(MyFile))
                        {                        
                            break;
                        }    
                        Temporary[i] = c;
                        c = fgetc(MyFile);
                        if(c == '"')
                        {
                            c = fgetc(MyFile);
                        }
                        i++;
                    }
                    for(i = 0; i < maxLength; i++)
                    {
                        eachPokemon[pokemonNo].dexEntry[i] = Temporary[i];
                    }
                    c = fgetc(MyFile);
                    i = 0;

                    if(feof(MyFile))
                    {
                        printf("What pokemon number would you like to know about?(1 to 649, type 0 to end): ");
                        int input;
                        scanf("%d", &input);
                        while(input != 0)
                        {
                            printf("\n");
                            printf("%s", eachPokemon[input - 1].dexEntry);
                            printf("\n");
                            printf("\n");
                            printf("What other pokemon number would you like to know about?(1 to 649, type 0 to end): ");
                            scanf("%d", &input);
                        }
                        printf("Shutting Down...");
                        return 0;
                    }
                }
            }
        }
    
    return 0;
}

void printStruct(int number)
{
    printf("#%d \n", eachPokemon[number].number);
    printf("Name: %s \n", eachPokemon[number].name);
    printf("Type 1: %s \n", eachPokemon[number].type1);
    printf("Type 2: %s \n", eachPokemon[number].type2);
    printf("Total Base Stats -> %d \n", eachPokemon[number].total);
    printf("HP ---------------> %d \n", eachPokemon[number].hp);
    printf("Attack -----------> %d \n", eachPokemon[number].attack);
    printf("Defense ----------> %d \n", eachPokemon[number].defense);
    printf("Special Attack ---> %d \n", eachPokemon[number].spAttack);
    printf("Special Defense --> %d \n", eachPokemon[number].spDefense);
    printf("Speed ------------> %d \n", eachPokemon[number].speed);
    printf("Generation %d \n", eachPokemon[number].generation);
    printf("Is it Legendary? %s \n", eachPokemon[number].legendary);
    printf("Pokedex Entry: %s \n", eachPokemon[number].dexEntry);
}
