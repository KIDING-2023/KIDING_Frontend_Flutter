import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/finish_screen.dart';

import '../../screen/kikisday/kikisday_10_screen.dart';
import '../../screen/kikisday/kikisday_11_screen.dart';
import '../../screen/kikisday/kikisday_12_screen.dart';
import '../../screen/kikisday/kikisday_13_screen.dart';
import '../../screen/kikisday/kikisday_14_screen.dart';
import '../../screen/kikisday/kikisday_15_screen.dart';
import '../../screen/kikisday/kikisday_16_screen.dart';
import '../../screen/kikisday/kikisday_17_screen.dart';
import '../../screen/kikisday/kikisday_18_screen.dart';
import '../../screen/kikisday/kikisday_19_screen.dart';
import '../../screen/kikisday/kikisday_20_screen.dart';
import '../../screen/kikisday/kikisday_2_screen.dart';
import '../../screen/kikisday/kikisday_3_screen.dart';
import '../../screen/kikisday/kikisday_4_screen.dart';
import '../../screen/kikisday/kikisday_5_screen.dart';
import '../../screen/kikisday/kikisday_6_screen.dart';
import '../../screen/kikisday/kikisday_7_screen.dart';
import '../../screen/kikisday/kikisday_8_screen.dart';
import '../../screen/kikisday/kikisday_9_screen.dart';
import '../../screen/kikisday/kikisday_qr_screen.dart';
import '../../screen/kikisday/set_player_number_screen.dart';

final Map<String, WidgetBuilder> kikisdayRoutes = {
  '/kikisday_qr': (context) => KikisdayQrScreen(),
  '/kikisday_set_player_num': (context) => SetPlayerNumberScreen(),
  '/kikisday_finish': (context) => FinishScreen(),
  '/kikisday2': (context) => Kikisday2Screen(),
  '/kikisday3': (context) => Kikisday3Screen(),
  '/kikisday4': (context) => Kikisday4Screen(),
  '/kikisday5': (context) => Kikisday5Screen(),
  '/kikisday6': (context) => Kikisday6Screen(),
  '/kikisday7': (context) => Kikisday7Screen(),
  '/kikisday8': (context) => Kikisday8Screen(),
  '/kikisday9': (context) => Kikisday9Screen(),
  '/kikisday10': (context) => Kikisday10Screen(),
  '/kikisday11': (context) => Kikisday11Screen(),
  '/kikisday12': (context) => Kikisday12Screen(),
  '/kikisday13': (context) => Kikisday13Screen(),
  '/kikisday14': (context) => Kikisday14Screen(),
  '/kikisday15': (context) => Kikisday15Screen(),
  '/kikisday16': (context) => Kikisday16Screen(),
  '/kikisday17': (context) => Kikisday17Screen(),
  '/kikisday18': (context) => Kikisday18Screen(),
  '/kikisday19': (context) => Kikisday19Screen(),
  '/kikisday20': (context) => Kikisday20Screen(),
};