#include <stdio.h>
#include "game.h"

int main(void) {
    Game game;
    char current_player = 'X';
    char winner = ' ';
    int row, col;
    
    init_game(&game);
    
    printf("Welcome to Tic-Tac-Toe!\n");
    printf("Players: X and O\n");
    printf("Enter positions as row (0-2) and column (0-2)\n");
    
    while (winner == ' ' && !is_board_full(&game)) {
        print_board(&game);
        
        printf("Player %c's turn\n", current_player);
        get_move(&row, &col);
        
        if (make_move(&game, row, col, current_player)) {
            winner = check_winner(&game);
            
            if (winner == ' ') {
                current_player = (current_player == 'X') ? 'O' : 'X';
            }
        } else {
            printf("Invalid move!\n");
        }
    }
    
    print_board(&game);
    
    if (winner != ' ') {
        printf("Player %c wins!\n", winner);
    } else {
        printf("It's a draw!\n");
    }
    
    return 0;
}
