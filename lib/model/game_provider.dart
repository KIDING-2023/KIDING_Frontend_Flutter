import 'package:flutter/material.dart';

class Player {
  int playerNum;
  int position;
  int chips;

  Player({required this.playerNum, this.position = 0, this.chips = 0});

  // JSON 직렬화 및 비직렬화 기능 추가
  Map<String, dynamic> toJson() => {
        'playerNum': playerNum,
        'position': position,
        'chips': chips,
      };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        playerNum: json['playerNum'],
        position: json['position'],
        chips: json['chips'],
      );
}

class GameProvider extends ChangeNotifier {
  List<Player> _players = [];
  int _currentPlayerIndex = 0;

  // 불변성 유지: 외부에서는 읽기만 가능
  List<Player> get players => List.unmodifiable(_players);

  // 현재 플레이어 가져오기
  Player get currentPlayer => _players[_currentPlayerIndex];

  void setPlayers(int count) {
    _players = List.generate(count, (index) => Player(playerNum: index + 1));
    _currentPlayerIndex = 0;
    notifyListeners();
  }

  void updatePlayerPosition(int steps) {
    if (_players.isNotEmpty) {
      currentPlayer.position += steps;
      notifyListeners();
    }
  }

  void updatePlayerChips(int count) {
    if (_players.isNotEmpty) {
      currentPlayer.chips += count;
      notifyListeners();
    }
  }

  void nextPlayerTurn() {
    if (_players.isNotEmpty) {
      _currentPlayerIndex = (_currentPlayerIndex + 1) % _players.length;
      notifyListeners();
    }
  }

  void resetGame() {
    for (var player in _players) {
      player.position = 0;
      player.chips = 0;
    }
    _currentPlayerIndex = 0;
    notifyListeners();
  }
}
