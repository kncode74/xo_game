import 'package:flutter/material.dart';

class BoardXOContent extends StatelessWidget {
  final int tableNumber;
  final Function(int, int)? onTap;
  final List<List<String>> boardData;

  const BoardXOContent({
    required this.boardData,
    required this.tableNumber,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: tableNumber,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: tableNumber * tableNumber,
      itemBuilder: (context, index) {
        int row = index ~/ tableNumber;
        int col = index % tableNumber;

        return InkWell(
          onTap: () => onTap?.call(row, col),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                boardData[row][col],
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: boardData[row][col] == 'X'
                      ? Colors.lightGreen
                      : Colors.purple,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
