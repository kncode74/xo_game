import 'package:shared_preferences/shared_preferences.dart';
import 'package:xo_game/model/game_history.dart';

class GamePreferences {
  final String history = 'history';

  Future<GameHistory> getGameHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(history) as GameHistory;
  }

  Future<void> setGameHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(history, true);
  }
}
