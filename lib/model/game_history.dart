import 'dart:convert';

import 'package:uuid/uuid.dart';

class GameHistory {
  final String gameId;
  final DateTime playTime;
  final String winner;
  final List<List<String>> board;

  GameHistory({
    required this.gameId,
    required this.playTime,
    required this.winner,
    required this.board,
  });

  static GameHistory mapGameHistory(
      String resultGame, List<List<String>> board) {
    var uuid = const Uuid();
    GameHistory history = GameHistory(
      gameId: uuid.toString(),
      playTime: DateTime.now(),
      winner: resultGame,
      board: board,
    );
    return history;
  }

  static Map<String, dynamic> toMap(GameHistory history) {
    return {
      'gameId': history.gameId,
      'playTime': history.playTime.toIso8601String(),
      'winner': history.winner,
      'board': jsonEncode(history.board),
    };
  }

  static GameHistory fromMap(Map<String, dynamic> map) {
    return GameHistory(
      gameId: map['gameId'],
      playTime: DateTime.parse(map['playTime']),
      winner: map['winner'],
      board: List<List<String>>.from(
        jsonDecode(map['board']).map((x) => List<String>.from(x)),
      ),
    );
  }
}
