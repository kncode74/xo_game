import 'package:get/get.dart';
import 'package:xo_game/history_game/history_game.vm.dart';

class HistoryGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryGameVM>(
      () => HistoryGameVM(),
    );
  }
}
