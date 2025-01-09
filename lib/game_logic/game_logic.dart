import 'dart:math';

import 'package:xo_game/const/const.dart';

class GameLogic {
  static bool checkWinner(
    List<List<String>> board,
    String player,
    int tableNumber,
  ) {
    bool mainDiagonalWin = true;
    bool antiDiagonalWin = true;
    for (int col = 0; col < tableNumber; col++) {
      bool rowWin = true;
      bool colWin = true;

      for (int row = 0; row < tableNumber; row++) {
        if (board[col][row] != player) rowWin = false;
        if (board[row][col] != player) colWin = false;
      }

      if (rowWin || colWin) return true;

      if (board[col][col] != player) mainDiagonalWin = false;
      if (board[col][tableNumber - 1 - col] != player) antiDiagonalWin = false;
    }
    return mainDiagonalWin || antiDiagonalWin;
  }

  static bool checkDraw(List<List<String>> board) =>
      board.every((row) => row.every((cell) => cell.isNotEmpty));

  static int minimaxAlgorithm(
    List<List<String>> board, {
    required bool isMaximizing,
    required int tableNumber,
  }) {
    bool checkAIWin = GameLogic.checkWinner(board, Player.O_AI, tableNumber);
    bool checkAILost = GameLogic.checkWinner(board, Player.X_USER, tableNumber);

    if (checkAIWin) return ResultGame.win;
    if (checkAILost) return ResultGame.lost;
    if (GameLogic.checkDraw(board)) return ResultGame.draw;

    int bestScore = isMaximizing ? -1000 : 1000;

    for (int row = 0; row < tableNumber; row++) {
      for (int col = 0; col < tableNumber; col++) {
        if (board[row][col].isEmpty) {
          board[row][col] = isMaximizing ? Player.O_AI : Player.X_USER;

          int score = minimaxAlgorithm(
            board,
            isMaximizing: !isMaximizing,
            tableNumber: tableNumber,
          );

          board[row][col] = '';

          if (isMaximizing) {
            bestScore = max(score, bestScore);
          } else {
            bestScore = min(score, bestScore);
          }
        }
      }
    }

    return bestScore;
  }
}
