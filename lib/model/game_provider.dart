import 'package:flutter/material.dart';

class Player {
  int playerNum;
  int position;
  int chips;

  Player({required this.playerNum, this.position = 0, this.chips = 0});
}

class GameProvider extends ChangeNotifier {
  List<Player> players = [];
  int currentPlayerIndex = 0;

  void setPlayers(int count) {
    players = List.generate(count, (index) => Player(playerNum: index + 1));
    currentPlayerIndex = 0;
    notifyListeners();
  }

  Player get currentPlayer => players[currentPlayerIndex];

  void updatePlayerPosition(int steps) {
    currentPlayer.position += steps;
    notifyListeners();
  }

  void updatePlayerChips(int count) {
    currentPlayer.chips += count;
    notifyListeners();
  }

  void nextPlayerTurn() {
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
    notifyListeners();
  }
}