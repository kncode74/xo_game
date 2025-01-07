import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xo_game/xo_game/xo.vm.dart';

import 'game_logic/check_winner.dart';

class XOGameView extends GetView<XOGameVM> {
  final int tableNumber = Get.arguments['table'] as int;

  @override
  Widget build(BuildContext context) {
    controller.initBoard();
    return Scaffold(
      appBar: AppBar(
        title: Text('XO XO'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: tableNumber,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: tableNumber * tableNumber,
                itemBuilder: (context, index) {
                  int row = index ~/ tableNumber;
                  int col = index % tableNumber;

                  return GestureDetector(
                    onTap: () => controller.onCellTap(row, col),
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            controller.board[row][col],
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: controller.board[row][col] == 'X'
                                  ? Colors.blue
                                  : Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
