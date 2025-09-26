#include<stdio.h>
int main(void){
    int a = 10;
    printf("a (Function Main)= %d\n",a);
    functionOne();
    printf("Main\n");
}

void functionOne(){
    int a = 15;
    printf("a (Function One)= %d\n",a);
    functionTwo();
    printf("One\n");
}

void functionTwo(){
    int a = 20;
    printf("a (Function Two)= %d\n",a);
    printf("Two\n");
}
