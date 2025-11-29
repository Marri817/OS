#ifndef GAME_H
#define GAME_H

#define BOARD_SIZE 3

typedef struct {
    char board[BOARD_SIZE][BOARD_SIZE];
} Game;

void init_game(Game *game);
void print_board(Game *game);
int make_move(Game *game, int row, int col, char player);
char check_winner(Game *game);
int is_board_full(Game *game);
void get_move(int *row, int *col);

#endif
