#include <stdio.h>

void swap(void *x, void *y) {
    int tmp = *(int *)x;
    *(int *)x = *(int *)y;
    *(int *)y = tmp;
}

int main(void) {
    int a = 2, b = 3;
    printf("Before swap: a = %d, b = %d\n", a, b);
    swap(&a, &b);
    printf("After swap: a = %d, b = %d\n", a, b);
    
    return 0;
}
