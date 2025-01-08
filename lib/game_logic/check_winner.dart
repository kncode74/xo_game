bool checkWinner(
  List<List<String>> board,
  String player, {
  required int tableNumber,
}) {
  for (int i = 0; i < tableNumber; i++) {
    bool rowWin = true;
    bool colWin = true;

    for (int j = 0; j < tableNumber; j++) {
      if (board[i][j] != player) {
        rowWin = false;
      }
      if (board[j][i] != player) {
        colWin = false;
      }
    }

    if (rowWin || colWin) {
      return true;
    }
  }

  bool mainDiagonalWin = true;
  for (int i = 0; i < tableNumber; i++) {
    if (board[i][i] != player) {
      mainDiagonalWin = false;
      break;
    }
  }

  bool antiDiagonalWin = true;
  for (int i = 0; i < tableNumber; i++) {
    if (board[i][tableNumber - 1 - i] != player) {
      antiDiagonalWin = false;
      break;
    }
  }

  return mainDiagonalWin || antiDiagonalWin;
}

bool checkDraw(List<List<String>> board) =>
    board.every((row) => row.every((cell) => cell.isNotEmpty));
