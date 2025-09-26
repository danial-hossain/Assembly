#include<stdio.h>
int main(void)
{
    char al ;
    scanf("%c",&al);

    if(al<'a')
        goto L;
    al = al - 32;
    L:
    printf("Capital: %c\n",al);
    return 0;
}

