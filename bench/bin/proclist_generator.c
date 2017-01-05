#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
    int array[256];
    for(int i=0; i<64; i++)
        for(int j=0; j<4; j++)
            array[i*4+j]=i+64*j;
    int num=atoi(argv[1]);
    for(int i=0; i<num-1; i++)
        printf("%d,", array[i*(256/num)]);
    printf("%d\n", array[(num-1)*(256/num)]);
    return 0;
}
