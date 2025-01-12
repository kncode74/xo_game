import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xo_game/_widget/board_content.dart';
import 'package:xo_game/const/const.dart';
import 'package:xo_game/history_game/history_game.binding.dart';
import 'package:xo_game/history_game/history_game.view.dart';
import 'package:xo_game/xo_game/xo.binding.dart';
import 'package:xo_game/xo_game/xo.view.dart';

class SelectTablePage extends StatelessWidget {
  const SelectTablePage({super.key});

  final int startNumber = 3;
  final int endNUmber = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 4,
                  color: Colors.blueAccent,
                ),
              ),
              child: Column(
                children: [
                  _headerContent(),
                  _content(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Choose table',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          _historyLogButton(),
        ],
      ),
    );
  }

  Widget _content() {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemCount: endNUmber - startNumber + 1,
        itemBuilder: (context, index) {
          final int tableNumber = startNumber + index;
          return BoardXOContent(
            boardData: [],
            color: _generateGradientColor(index),
            tableNumber: tableNumber,
            onTapCell: (_, value) {
              _showDialog(tableNumber);
            },
          );
        },
      ),
    );
  }

  Widget _historyLogButton() {
    return IconButton(
      onPressed: () {
        Get.to(
              () => HistoryGameView(),
          binding: HistoryGameBinding(),
        );
      },
      icon: const Icon(
        Icons.history,
        size: 40,
      ),
    );
  }

  _routeToGame(int tableNumber,
      Enum gameMode,) {
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
      builder: (context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Center(
              child: Text(
                'Choose Game Mode',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$tableNumber X $tableNumber',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(
                      Icons.android,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Play with AI',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Get.back();
                      _routeToGame(tableNumber, GameMode.aIMode);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: const Text(
                      'Play Single Player',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Get.back();
                      _routeToGame(tableNumber, GameMode.singleMode);
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
    );
  }

  Color _generateGradientColor(int index) {
    final double colorValue =
        index / (endNUmber - startNumber); // คำนวณค่าจาก index
    return Color.lerp(
      Colors.blue.shade200, // สีฟ้าอ่อน
      Colors.blue.shade800, // สีฟ้าเข้ม
      colorValue, // ค่าที่ปรับตาม index
    )!;
  }
}
