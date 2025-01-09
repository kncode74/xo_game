import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xo_game/model/game_history.dart';

class GamePreferences {
  final String history = 'history';

  Future<List<GameHistory>> getGameHistoryList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? result = prefs.getString('history');
    if (result == null) return [];
    List<dynamic> historyList = jsonDecode(result);
    return historyList.map((item) => GameHistory.fromMap(item)).toList();
  }

  Future<void> setGameHistory(String json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(history, json);
  }

  Future<void> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
