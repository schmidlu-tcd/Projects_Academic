#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//useful ints
int maxLength = 300; //max chars
int totalLines = 660; //max pokemons
char Temporary[300]; //temporary array

//create struct
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

//array of structs
struct pokemon eachPokemon[660];

//start of main with given arguments
int main(int argc, char *argv[]) 
{
    char c;
    int firstRowBool = 0;
    int i = 0;

    //get file
    FILE *MyFile;
    for(int argum = 0; argum < argc; argum++)
    {
        //open file
        MyFile = fopen(argv[argum], "r");
    }
    if(MyFile == NULL) {
        //if file isn't open
        perror("File can't be opened");
    }
    else
    {    
        //if file is open put first char into c
        c = fgetc(MyFile);
        while(c != '\0') //while c is not the end
        {
            while(c != '\n' && firstRowBool == 0) //to skip first line 
            {
                c = fgetc(MyFile);
            }
            c = fgetc(MyFile);
            for(int pokemonNo = 0; pokemonNo < totalLines; pokemonNo++) //loop to read all lines
            {
                if(feof(MyFile)) //if end of file
                {
                    break;
                }
                i = 0;

                //POKEMON NUMBER
                memset(Temporary, 0, maxLength);                
                while(c != ',')
                {
                    //puts the data from between the commas into the temp array
                    Temporary[i] = c;
                    c = fgetc(MyFile);
                    i++;
                }
                eachPokemon[pokemonNo].number = atoi(Temporary);
                c = fgetc(MyFile);
                i = 0;

                //POKEMON NAME
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

                //POKEMON TYPE1
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

                //POKEMON TYPE2
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

                //POKEMON TOTAL
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

                //POKEMON HP
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

                //POKEMON ATTACK
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

                //POKEMON DEFENCE
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

                //POKEMON SPATTACK
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

                //POKEMON SPDEFENCE
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

                //POKEMON SPEED
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

                //POKEMON GENERATION
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

                //POKEMON LEGENDARY
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

                //POKEMON DEXENTRY
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

                //END OF FILE, GET AVERAGE ATTACK
                if(feof(MyFile))
                {
                    float average = 0;
                    float totalAttack = 0;
                    for(i = 0; i < 650; i++)
                    {
                        totalAttack = totalAttack + eachPokemon[i].attack;
                    }
                    average = totalAttack/649;
                    printf("%f", average);
                    
                    return 0;
                }
            }
        }
    }

    return 0;
}