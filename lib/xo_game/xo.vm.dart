import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xo_game/const/const.dart';
import 'package:xo_game/game_logic/check_winner.dart';
import 'package:xo_game/game_logic/game_logic.dart';
import 'package:xo_game/model/game_history.dart';
import 'package:xo_game/model/shared_preferences.dart';

class XOGameVM extends GetxController {
  final int _tableNumber = Get.arguments['table'] as int;
  final int _gameMode = Get.arguments['game_mode'] as int;
  final RxList<List<String>> board = <List<String>>[].obs;
  final RxString _currentPlayer = 'X'.obs;
  final RxString winner = ''.obs;

  List<GameHistory> _historyGame = [];

  final GamePreferences _gamePreferences = GamePreferences();

  initBoard() {
    _initHistory();
    board.value = List.generate(
        _tableNumber, (_) => List.generate(_tableNumber, (_) => ''));
  }

  _initHistory() async {
    _historyGame = await _gamePreferences.getGameHistory();
  }

  _updateBoard(int row, int col, String player) {
    board[row][col] = player;
    board.refresh();
  }

  togglePlayer() {
    _currentPlayer.value = _currentPlayer.value == 'X' ? 'O' : 'X';
  }

  _updateWinner(String winnerValue) {
    _showDialogGameOver(winnerValue);
    winner.value = winnerValue;
    GameHistory history = GameHistory.mapGameHistory(
        winnerValue, board, _gameMode == GameMode.AIMode);
    _historyGame.add(history);

    _gamePreferences.setGameHistory(jsonEncode(
        _historyGame.map((item) => GameHistory.toMap(item)).toList()));
  }

  resetGame() {
    board.value = List.generate(
        _tableNumber, (_) => List.generate(_tableNumber, (_) => ''));
    winner.value = '';
    _currentPlayer.value = 'X';
  }

  makeAIMove() {
    int bestScore = -1000;
    int bestMoveRow = -1;
    int bestMoveCol = -1;

    for (int i = 0; i < _tableNumber; i++) {
      for (int j = 0; j < _tableNumber; j++) {
        if (board[i][j].isEmpty) {
          board[i][j] = 'O';
          int score = minimax(board, false, tableNumber: _tableNumber);
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
        tableNumber: _tableNumber,
      )) {
        _updateWinner('O');
      } else if (checkDraw(board)) {
        _updateWinner('draw');
      } else {
        togglePlayer();
      }
    }
  }

  void onTapCell(int row, int col) {
    if (board[row][col].isEmpty && winner.value.isEmpty) {
      _updateBoard(row, col, _currentPlayer.value);

      if (checkWinner(
        board,
        _currentPlayer.value,
        tableNumber: _tableNumber,
      )) {
        _updateWinner(_currentPlayer.value);
      } else if (checkDraw(board)) {
        _updateWinner(ResultGame.draw);
      } else {
        togglePlayer();
        if (_gameMode == GameMode.AIMode && _currentPlayer.value == 'O') {
          Future.delayed(const Duration(milliseconds: 500), () {
            makeAIMove();
          });
        }
      }
    }
  }

  _showDialogGameOver(String winnerName) {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game over'),
          content: Text('The winner is $winnerName'),
          actions: <Widget>[
            TextButton(
              child: const Text('back'),
              onPressed: () {
                Get.back();
                Get.back();
              },
            ),
            TextButton(
              child: const Text('continue'),
              onPressed: () {
                Get.back();
                resetGame();
              },
            ),
          ],
        );
      },
    );
  }
}
