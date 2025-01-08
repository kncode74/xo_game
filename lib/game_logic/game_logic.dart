import 'dart:math';

import 'check_winner.dart';

int minimax(List<List<String>> board, bool isMaximizing,
    {required int tableNumber}) {
  if (checkWinner(board, 'O', tableNumber: tableNumber)) {
    return 1;
  } else if (checkWinner(
    board,
    'X',
    tableNumber: tableNumber,
  )) {
    return -1;
  } else if (checkDraw(board)) {
    return 0;
  }

  if (isMaximizing) {
    int bestScore = -1000;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          int score = minimax(
            board,
            false,
            tableNumber: tableNumber,
          );
          board[i][j] = '';
          bestScore = max(score, bestScore);
        }
      }
    }
    return bestScore;
  } else {
    int bestScore = 1000;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'X';
          int score = minimax(
            board,
            true,
            tableNumber: tableNumber,
          );
          board[i][j] = '';
          bestScore = min(score, bestScore);
        }
      }
    }
    return bestScore;
  }
}
