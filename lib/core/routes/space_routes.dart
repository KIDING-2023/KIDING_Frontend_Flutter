import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_card_screen.dart';
import 'package:kiding/screen/space/space_finish_screen.dart';
import 'package:kiding/screen/space/space_set_player_number_screen.dart';
import '../../screen/space/space_qr_screen.dart';
import '../../screen/space/space_tutorial1_screen.dart';

final Map<String, WidgetBuilder> spaceRoutes = {
  '/space_qr': (context) => SpaceQrScreen(),
  '/space_set_player_num': (context) => SpaceSetPlayerNumberScreen(),
  '/space_tutorial1': (context) => SpaceTutorial1Screen(),
  '/space_screen': (context) => SpaceCardScreen(),
  '/space_finish': (context) => SpaceFinishScreen(),
};
