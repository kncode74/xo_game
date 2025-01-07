import 'dart:convert';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:xo_game/const/const.dart';
import 'package:xo_game/model/game_history.dart';
import 'package:xo_game/model/shared_preferences.dart';
import 'package:xo_game/xo_game/game_logic/check_winner.dart';

import 'game_logic/game_logic.dart';

class XOGameVM extends GetxController {
  final int tableNumber = Get.arguments['table'] as int;
  final int gameMode = Get.arguments['game_mode'] as int;
  RxList<List<String>> board = <List<String>>[].obs;

  List<GameHistory> _historyGame = [];
  RxString currentPlayer = 'X'.obs;
  RxString winner = ''.obs;
  var playerXScore = 0.obs;
  var playerOScore = 0.obs;
  var isAIPlaying = false.obs;

  final GamePreferences _gamePreferences = GamePreferences();

  initBoard() {
    _initHistory();
    board.value = List.generate(
        tableNumber, (_) => List.generate(tableNumber, (_) => ''));
  }

  _initHistory() async {
    _historyGame = await _gamePreferences.getGameHistory();
  }

  _updateBoard(int row, int col, String player) {
    board[row][col] = player;
    board.refresh();
  }

  togglePlayer() {
    currentPlayer.value = currentPlayer.value == 'X' ? 'O' : 'X';
  }

  _updateWinner(String winnerValue) {
    winner.value = winnerValue;
    GameHistory history = GameHistory.mapGameHistory(winnerValue, board);
    _historyGame.add(history);
    _gamePreferences.setGameHistory(jsonEncode(
        _historyGame.map((item) => GameHistory.toMap(item)).toList()));
  }

  resetGame() {
    board.value = List.generate(3, (_) => List.generate(3, (_) => ''));
    winner.value = '';
    currentPlayer.value = 'X';
  }

  makeAIMove() {
    int bestScore = -1000;
    int bestMoveRow = -1;
    int bestMoveCol = -1;

    for (int i = 0; i < tableNumber; i++) {
      for (int j = 0; j < tableNumber; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          int score = minimax(board, false, tableNumber: tableNumber);
          board[i][j] = '';

          if (score > bestScore) {
            bestScore = score;
            bestMoveRow = i;
            bestMoveCol = j;
          }
        }
      }
    }

    if (bestMoveRow != -1 && bestMoveCol != -1) {
      _updateBoard(bestMoveRow, bestMoveCol, 'O');
      if (checkWinner(
        board,
        'O',
        tableNumber: tableNumber,
      )) {
        _updateWinner('O');
        playerOScore++;
      } else if (checkDraw(board)) {
        _updateWinner('draw');
      } else {
        togglePlayer();
      }
    }
  }

  void onCellTap(int row, int col) {
    if (isAIPlaying.value) return;

    if (board[row][col].isEmpty && winner.value.isEmpty) {
      _updateBoard(row, col, currentPlayer.value);

      if (checkWinner(
        board,
        currentPlayer.value,
        tableNumber: tableNumber,
      )) {
        _updateWinner(currentPlayer.value);
        if (currentPlayer.value == 'X') {
          playerXScore++;
        } else {
          playerOScore++;
        }
        // Show a dialog here if needed
      } else if (checkDraw(board)) {
        _updateWinner(ResultGame.draw);
        // Show a draw dialog here if needed
      } else {
        togglePlayer();
        if (gameMode == GameMode.AIMode && currentPlayer.value == 'O') {
          isAIPlaying.value = true;
          Future.delayed(const Duration(milliseconds: 500), () {
            makeAIMove();
            isAIPlaying.value = false;
          });
        }
      }
    }
  }
}
