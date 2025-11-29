#include <stdio.h>

int main(void) {
    int n = 20;
    int *ptr_to_n = &n;

    (*ptr_to_n)++;
    printf("Value of n after increment: %d\n", n);
    
    return 0;
}
