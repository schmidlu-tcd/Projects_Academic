#include <stdio.h>

char name[30];
int age;

int main() {

    printf("Name >> ");
    scanf("%s", name);
    //asks for name

    printf("Age >> ");
    scanf("%d", &age);
    //asks for age

    printf("Hello %s (%d)", name, age);
    //prints hello message

    return 0;
}