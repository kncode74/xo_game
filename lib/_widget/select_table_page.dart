import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xo_game/_widget/history_page.dart';
import 'package:xo_game/const/const.dart';
import 'package:xo_game/xo_game/xo.binding.dart';
import 'package:xo_game/xo_game/xo.view.dart';

class SelectTablePage extends StatelessWidget {
  const SelectTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _historyLogButton(),
            _boxContent('3x3', TableNumber.three),
            _boxContent('4x4', TableNumber.four),
          ],
        ),
      ),
    );
  }

  Widget _historyLogButton() {
    return OutlinedButton(
      onPressed: () {
        Get.to(() => HistoryPage());
      },
      child: Text('history log'),
    );
  }

  Widget _boxContent(
    String text,
    int tableNumber,
  ) {
    return InkWell(
      onTap: () {
        _showDialog(tableNumber);
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.lightGreen, borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(text)),
      ),
    );
  }

  _routeToGame(
    int tableNumber,
    int gameMode,
  ) {
    Get.to(
      () => XOGameView(),
      arguments: {
        'table': tableNumber,
        'game_mode': gameMode,
      },
      binding: XoBinding(),
    );
  }

  void _showDialog(int tableNumber) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Choose Game Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Play with AI'),
              onTap: () {
                Get.back();
                _routeToGame(tableNumber, GameMode.AIMode);
              },
            ),
            ListTile(
              title: const Text('Play Single Player'),
              onTap: () {
                Get.back();

                _routeToGame(tableNumber, GameMode.singleMode);
              },
            ),
          ],
        ),
      ),
    );
  }
}
