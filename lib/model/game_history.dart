class GameHistory {
  final String gameId;
  final DateTime playTime;
  final String winner;
  final List<Move> moves;

  GameHistory({
    required this.gameId,
    required this.playTime,
    required this.winner,
    required this.moves,
  });
}

class Move {
  final int player;
  final int position;
  final DateTime timestamp;

  Move({
    required this.player,
    required this.position,
    required this.timestamp,
  });
}
