import 'package:get/get.dart';
import 'package:xo_game/model/game_history.dart';
import 'package:xo_game/model/shared_preferences.dart';

class HistoryGameVM extends GetxController {
  final GamePreferences _gamePreferences = GamePreferences();

  RxList<GameHistory> historyGameList = <GameHistory>[].obs;

  init() async {
    historyGameList.value = await _gamePreferences.getGameHistory();
    historyGameList.value = historyGameList.reversed.toList();
  }

  onClearPreferences() {
    _gamePreferences.clearPreferences();
    init();
  }
}
