import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice2_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice4_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice_screen.dart';

import '../../screen/kikisday/kikisday_random_dice3_screen.dart';

Widget setDiceScreen({required int position, required int chips}) {
  if (position >= 1 && position <= 4) {
    return KikisdayRandomDiceScreen(chips: chips);
  } else if (position >= 5 && position <= 9) {
    return KikisdayRandomDice2Screen(currentNumber: position, chips: chips);
  } else if (position >= 10 && position <= 14) {
    return KikisdayRandomDice3Screen(currentNumber: position, chips: chips);
  } else {
    return KikisdayRandomDice4Screen(currentNumber: position, chips: chips);
  }
}
