import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardXOContent extends StatelessWidget {
  final int tableNumber;
  final Function(int, int)? onTapCell;
  final Color? color;

  final List<List<String>> boardData;

  const BoardXOContent({
    required this.boardData,
    required this.tableNumber,
    this.onTapCell,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.size.width;
    double cellSize = screenWidth / tableNumber;
    double fontSize = cellSize * 0.5;
    double spacing = screenWidth * 0.01;
    double borderRadius = cellSize * 0.1;
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: tableNumber,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: tableNumber * tableNumber,
      itemBuilder: (context, index) {
        int row = index ~/ tableNumber;
        int col = index % tableNumber;

        return InkWell(
          onTap: () => onTapCell?.call(row, col),
          child: Container(
            decoration: BoxDecoration(
              color: color ?? Colors.lightBlue,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Center(
              child: (boardData.isEmpty)
                  ? Container()
                  : Text(
                      boardData[row][col],
                      style: TextStyle(
                        fontSize: fontSize,
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
