#include <stdio.h>

void print_array(int *arr, int width, int height) {
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            printf("%d ", arr[i * width + j]);
        }
        printf("\n");
    }
}

int main(void) {
    int arr1[3][4] = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12}
    };
    
    int arr2[2][5] = {
        {10, 20, 30, 40, 50},
        {60, 70, 80, 90, 100}
    };
    
    printf("Test 1:\n");
    print_array((int *)arr1, 4, 3);
    
    printf("\nTest 2:\n");
    print_array((int *)arr2, 5, 2);
    
    return 0;
}
