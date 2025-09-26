#include<stdio.h>
int main(void)
{
    int al, bl, cl;
    al = 7 , bl = 5;
    cl = al;

    if((bl-cl)<=0)
        goto Z;
    cl = bl;

    Z:
    printf("%d\n",cl);

    return 0;
}
