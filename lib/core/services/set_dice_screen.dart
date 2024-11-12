import 'package:flutter/material.dart';

import '../../screen/kikisday/kikisday_random_dice2_screen.dart';
import '../../screen/kikisday/kikisday_random_dice3_screen.dart';
import '../../screen/kikisday/kikisday_random_dice4_screen.dart';
import '../../screen/kikisday/kikisday_random_dice_screen.dart';

Widget setDiceScreen({required int position, required int chips}) {
  switch (position) {
    case 1:
    case 2:
    case 3:
    case 4:
      return KikisdayRandomDiceScreen(chips: chips);
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
      return KikisdayRandomDice2Screen(currentNumber: position, chips: chips);
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
      return KikisdayRandomDice3Screen(currentNumber: position, chips: chips);
    default:
      return KikisdayRandomDice4Screen(currentNumber: position, chips: chips);
  }
}