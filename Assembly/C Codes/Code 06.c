#include <stdio.h>
int main(void){
    int ax,bx;
    scanf("%d", &ax);

    switch (ax > 0){
        case 1:
            bx = 1;
            break;
        case 0:
            switch(ax < 0){
                case 1:
                    bx = -1;
                    break;
                case 0:
                    bx = 0;
                    break;
            }
        break;
    }
    printf("bx = %d\n",bx);
    return 0;
}
