import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            const Text('Choose a table'),
            _boxContent('3x3', TableNumber.three),
            _boxContent('4x4', TableNumber.four),
          ],
        ),
      ),
    );
  }

  Widget _boxContent(
    String text,
    int tableNumber,
  ) {
    return InkWell(
      onTap: () {
        _routeToGame(tableNumber);
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

  _routeToGame(int tableNumber) {
    Get.to(
      () => XOGameView(),
      arguments: {'table': tableNumber},
      binding: XoBinding(),
    );
  }
}
