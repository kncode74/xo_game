import 'package:flutter/material.dart';
import 'package:xo_game/model/game_history.dart';
import 'package:xo_game/model/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  GamePreferences _gamePreferences = GamePreferences();

  List<GameHistory> gameHistory = [];

  @override
  void initState() {
    _loadGameHistory();
    super.initState();
  }

  _loadGameHistory() async {
    List<GameHistory> history = await _gamePreferences.getGameHistory();
    setState(() {
      gameHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Game'),
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return ListView.builder(
        itemCount: gameHistory.length,
        itemBuilder: (context, index) {
          GameHistory history = gameHistory[index];
          return Text(history.winner);
        });
  }
}
