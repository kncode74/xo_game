import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xo_game/_widget/board_content.dart';
import 'package:xo_game/xo_game/xo.vm.dart';

class XOGameView extends GetView<XOGameVM> {
  final int tableNumber = Get.arguments['table'] as int;

  XOGameView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.initBoard();
    return Scaffold(
      appBar: AppBar(
        title: Text('XO $tableNumber X $tableNumber'),
      ),
      body: Center(
        child: Column(
          children: [
            _content(),
            _resetButton(),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Obx(
      () {
        return BoardXOContent(
          boardData: controller.board.toList(),
          tableNumber: tableNumber,
          onTapCell: (int row, int col) {
            controller.onTapCell(row, col);
          },
        );
      },
    );
  }

  Widget _resetButton() {
    return ElevatedButton(
      onPressed: () => controller.resetGame(),
      child: const Text('Reset'),
    );
  }
}
