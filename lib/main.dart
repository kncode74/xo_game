import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xo_game/_widget/select_table_page.dart';
import 'package:xo_game/xo_game/xo.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SelectTablePage(),
    );
  }
}
