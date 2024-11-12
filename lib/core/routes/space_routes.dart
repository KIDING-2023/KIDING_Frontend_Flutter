import 'package:flutter/material.dart';

import '../../screen/space/space_10_screen.dart';
import '../../screen/space/space_11_screen.dart';
import '../../screen/space/space_12_screen.dart';
import '../../screen/space/space_1_screen.dart';
import '../../screen/space/space_2_screen.dart';
import '../../screen/space/space_3_screen.dart';
import '../../screen/space/space_4_screen.dart';
import '../../screen/space/space_5_screen.dart';
import '../../screen/space/space_6_screen.dart';
import '../../screen/space/space_7_screen.dart';
import '../../screen/space/space_8_screen.dart';
import '../../screen/space/space_9_screen.dart';
import '../../screen/space/space_qr_screen.dart';
import '../../screen/space/space_tutorial1_screen.dart';

final Map<String, WidgetBuilder> spaceRoutes = {
  '/space_qr': (context) => SpaceQrScreen(),
  '/space_tutorial1': (context) => SpaceTutorial1Screen(),
  '/space1': (context) => Space1Screen(),
  '/space2': (context) => Space2Screen(),
  '/space3': (context) => Space3Screen(),
  '/space4': (context) => Space4Screen(),
  '/space5': (context) => Space5Screen(),
  '/space6': (context) => Space6Screen(),
  '/space7': (context) => Space7Screen(),
  '/space8': (context) => Space8Screen(),
  '/space9': (context) => Space9Screen(),
  '/space10': (context) => Space10Screen(),
  '/space11': (context) => Space11Screen(),
  '/space12': (context) => Space12Screen()
};