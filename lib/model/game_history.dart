import 'dart:convert';

import 'package:uuid/uuid.dart';

class GameHistoryModel {
  final String gameId;
  final DateTime playTime;
  final String winner;
  final bool isAI;
  final List<List<String>> board;

  GameHistoryModel({
    required this.gameId,
    required this.playTime,
    required this.winner,
    required this.board,
    required this.isAI,
  });

  static GameHistoryModel mapGameHistory(
    String resultGame,
    List<List<String>> board,
    bool isAI,
  ) {
    var uuid = const Uuid();
    GameHistoryModel history = GameHistoryModel(
      gameId: uuid.toString(),
      playTime: DateTime.now(),
      winner: resultGame,
      board: board,
      isAI: isAI,
    );
    return history;
  }

  static Map<String, dynamic> toMap(GameHistoryModel history) {
    return {
      'gameId': history.gameId,
      'playTime': history.playTime.toIso8601String(),
      'winner': history.winner,
      'board': jsonEncode(history.board),
      'isAI': jsonEncode(history.isAI),
    };
  }

  static GameHistoryModel fromMap(Map<String, dynamic> map) {
    return GameHistoryModel(
      gameId: map['gameId'],
      playTime: DateTime.parse(map['playTime']),
      winner: map['winner'],
      board: List<List<String>>.from(
        jsonDecode(map['board']).map((x) => List<String>.from(x)),
      ),
      isAI: map['isAI'] is bool
          ? map['isAI']
          : map['isAI'].toString().toLowerCase() == 'true',
    );
  }
}
