/*
 * driver.c
 * C driver program that calls the assembly asm_main function
 * This is used for all tasks in the worksheet
 */

int __attribute__((cdecl)) asm_main(void);

int main() {
    int ret_status;
    ret_status = asm_main();
    return ret_status;
}
