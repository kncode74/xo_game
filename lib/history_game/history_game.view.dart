import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xo_game/_widget/board_content.dart';
import 'package:xo_game/const/const.dart';
import 'package:xo_game/history_game/history_game.vm.dart';
import 'package:xo_game/model/game_history.dart';

class HistoryGameView extends GetView<HistoryGameVM> {
  const HistoryGameView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Game '),
        actions: [_clearDataButton()],
      ),
      body: _content(),
    );
  }

  Widget _clearDataButton() {
    return IconButton(
      onPressed: () => controller.onClearPreferences(),
      icon: const Icon(Icons.delete),
    );
  }

  Widget _content() {
    return Obx(
      () {
        if (controller.historyGameList.isEmpty) {
          return _emptyContent();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summaryContent(),
            Expanded(
              child: ListView.builder(
                itemCount: controller.historyGameList.length,
                itemBuilder: (context, index) {
                  GameHistory history = controller.historyGameList[index];
                  return _gameHistoryContent(history);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _emptyContent() => const Center(child: Text('No data'));

  Widget _summaryContent() {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Game Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const Divider(),
            _rowContent('Total Games', '${controller.historyGameList.length}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _rowContent('Player X Wins : ',
                    '${controller.historyGameList.where((item) => item.winner == Player.X_USER).length}'),
                _rowContent('Player O Wins : ',
                    '${controller.historyGameList.where((item) => item.winner == Player.O_AI).length}'),
              ],
            ),
            _rowContent('Draws',
                '${controller.historyGameList.where((item) => item.winner == ResultGame.drawStr).length}'),
          ],
        ),
      ),
    );
  }

  Widget _rowContent(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _gameHistoryContent(GameHistory history) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Winner: ${history.winner}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('HH:mm dd-MM-yyyy').format(history.playTime),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          _staticBoardDisplay(board: history.board),
        ],
      ),
    );
  }

  Widget _staticBoardDisplay({
    required List<List<String>> board,
  }) {
    return BoardXOContent(
      boardData: board,
      tableNumber: board.length,
    );
  }
}
