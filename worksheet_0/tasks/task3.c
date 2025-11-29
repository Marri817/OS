#include <stdio.h>

int compare_arrays(int *ptr1, int *ptr2, int length) {
    if (!ptr1 || !ptr2) {
        return 0;
    }
    
    for (int i = 0; i < length; i++) {
        if (ptr1[i] != ptr2[i]) {
            return 0;
        }
    }
    
    return 1;
}

int main(void) {
    int arr1[] = {1, 2, 3, 4, 5};
    int arr2[] = {1, 2, 3, 4, 5};
    int arr3[] = {10, 20, 3, 43, 6};
    
    printf("Testing compare_arrays function:\n");
    printf("arr1 vs arr2 (should be equal): %d\n", compare_arrays(arr1, arr2, 5));
    printf("arr1 vs arr3 (should be different): %d\n", compare_arrays(arr1, arr3, 5));
    printf("arr2 vs arr3 (should be different): %d\n", compare_arrays(arr2, arr3, 5));
    
    return 0;
}
