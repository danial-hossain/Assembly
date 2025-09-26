#include<stdio.h>
int main(void)
{

    goto Z;

    printf("First Printf");

    Z:
    printf("Second Printf");

    return 0;
}

