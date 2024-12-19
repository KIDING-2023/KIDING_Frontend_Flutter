import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/kikisday/finish_screen.dart';
import 'package:kiding_frontend/screen/kikisday/kikisday_card_screen.dart';
import '../../screen/kikisday/kikisday_qr_screen.dart';
import '../../screen/kikisday/set_player_number_screen.dart';

final Map<String, WidgetBuilder> kikisdayRoutes = {
  '/kikisday_qr': (context) => KikisdayQrScreen(),
  '/kikisday_set_player_num': (context) => SetPlayerNumberScreen(),
  '/kikisday_finish': (context) => FinishScreen(),
  '/kikisdayScreen': (context) => KikisdayCardScreen(),
};
