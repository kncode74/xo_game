import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:xo_game/xo_game/xo.vm.dart';

class XOGameView extends GetView<XOGameVM> {
  final int tableNumber = Get.arguments['table'] as int;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome XOXO $tableNumber table'),
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return GridView.builder(
      itemCount: tableNumber * tableNumber,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5, crossAxisSpacing: 5, crossAxisCount: tableNumber),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
          ),
        );
      },
    );
  }
}
