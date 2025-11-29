#include <stdio.h>
#include "game.h"

void init_game(Game *game) {
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE; j++) {
            game->board[i][j] = ' ';
        }
    }
}

void print_board(Game *game) {
    printf("\n");
    for (int i = 0; i < BOARD_SIZE; i++) {
        printf(" %c | %c | %c \n", 
               game->board[i][0], 
               game->board[i][1], 
               game->board[i][2]);
        if (i < BOARD_SIZE - 1) {
            printf("---|---|---\n");
        }
    }
    printf("\n");
}

int make_move(Game *game, int row, int col, char player) {
    if (row < 0 || row >= BOARD_SIZE || col < 0 || col >= BOARD_SIZE) {
        return 0;
    }
    
    if (game->board[row][col] != ' ') {
        return 0;
    }
    
    game->board[row][col] = player;
    return 1;
}

char check_winner(Game *game) {
    for (int i = 0; i < BOARD_SIZE; i++) {
        if (game->board[i][0] != ' ' &&
            game->board[i][0] == game->board[i][1] &&
            game->board[i][1] == game->board[i][2]) {
            return game->board[i][0];
        }
    }
    
    for (int j = 0; j < BOARD_SIZE; j++) {
        if (game->board[0][j] != ' ' &&
            game->board[0][j] == game->board[1][j] &&
            game->board[1][j] == game->board[2][j]) {
            return game->board[0][j];
        }
    }
    
    if (game->board[0][0] != ' ' &&
        game->board[0][0] == game->board[1][1] &&
        game->board[1][1] == game->board[2][2]) {
        return game->board[0][0];
    }
    
    if (game->board[0][2] != ' ' &&
        game->board[0][2] == game->board[1][1] &&
        game->board[1][1] == game->board[2][0]) {
        return game->board[0][2];
    }
    
    return ' ';
}

int is_board_full(Game *game) {
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE; j++) {
            if (game->board[i][j] == ' ') {
                return 0;
            }
        }
    }
    return 1;
}

void get_move(int *row, int *col) {
    printf("Enter row (0-2): ");
    scanf("%d", row);
    printf("Enter column (0-2): ");
    scanf("%d", col);
}
