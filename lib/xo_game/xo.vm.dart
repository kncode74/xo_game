import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xo_game/const/const.dart';
import 'package:xo_game/game_logic/game_logic.dart';
import 'package:xo_game/model/game_history.dart';
import 'package:xo_game/model/shared_preferences.dart';

class XOGameVM extends GetxController {
  final int _tableNumber = Get.arguments['table'] as int;
  final Enum _gameMode = Get.arguments['game_mode'] as Enum;

  final RxList<List<String>> board = <List<String>>[].obs;
  final RxString _currentPlayer = Player.X_USER.obs;
  final RxString winnerName = ''.obs;

  List<GameHistory> _historyGame = [];

  final GamePreferences _gamePreferences = GamePreferences();

  initBoard() {
    _initHistory();
    board.value = List.generate(
        _tableNumber, (_) => List.generate(_tableNumber, (_) => ''));
  }

  _initHistory() async {
    _historyGame = await _gamePreferences.getGameHistoryList();
  }

  _updateBoard(int row, int col, String player) {
    board[row][col] = player;
    board.refresh();
  }

  _togglePlayer() {
    _currentPlayer.value =
        _currentPlayer.value == Player.X_USER ? Player.O_AI : Player.X_USER;
  }

  _updateWinner(String winnerValue) {
    _showDialogGameOver(winnerValue);
    winnerName.value = winnerValue;

    GameHistory history = GameHistory.mapGameHistory(
      winnerValue,
      board,
      _gameMode == GameMode.aIMode,
    );
    _historyGame.add(history);

    _gamePreferences.setGameHistory(jsonEncode(
        _historyGame.map((item) => GameHistory.toMap(item)).toList()));
  }

  resetGame() {
    board.value = List.generate(
        _tableNumber, (_) => List.generate(_tableNumber, (_) => ''));
    winnerName.value = '';
    _currentPlayer.value = 'X';
  }

  _handleAIMove() {
    if (_gameMode == GameMode.aIMode && _currentPlayer.value == Player.O_AI) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          int bestScore = -1000;
          int bestMoveRow = -1;
          int bestMoveCol = -1;

          for (int i = 0; i < _tableNumber; i++) {
            for (int j = 0; j < _tableNumber; j++) {
              if (board[i][j].isEmpty) {
                board[i][j] = Player.O_AI;
                int score = GameLogic.minimaxAlgorithm(
                  board,
                  isMaximizing: false,
                  tableNumber: _tableNumber,
                );
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
            _updateBoard(bestMoveRow, bestMoveCol, Player.O_AI);

            bool checkAIWin =
                GameLogic.checkWinner(board, Player.O_AI, _tableNumber);
            if (checkAIWin) {
              _updateWinner(Player.O_AI);
            } else if (GameLogic.checkDraw(board)) {
              _updateWinner(ResultGame.drawStr);
            } else {
              _togglePlayer();
            }
          }
        },
      );
    }
  }

  void onTapCell(int row, int col) {
    if (board[row][col].isEmpty && winnerName.value.isEmpty) {
      _updateBoard(row, col, _currentPlayer.value);

      bool checkWin =
          GameLogic.checkWinner(board, _currentPlayer.value, _tableNumber);

      if (checkWin) {
        _updateWinner(_currentPlayer.value);
      } else if (GameLogic.checkDraw(board)) {
        _updateWinner(ResultGame.drawStr);
      } else {
        _togglePlayer();
        _handleAIMove();
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
