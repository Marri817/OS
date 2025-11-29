#include <stdio.h>

int main(void) {
    FILE *file = fopen("foo.txt", "r");
    
    if (file == NULL) {
        printf("Error: Could not open file foo.txt\n");
        return 1;
    }
    
    int num;
    int sum = 0;
    
    while (fscanf(file, "%d", &num) == 1) {
        sum += num;
    }
    
    fclose(file);
    
    printf("%d\n", sum);
    
    return 0;
}
