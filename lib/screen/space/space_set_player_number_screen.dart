import 'package:flutter/material.dart';
import 'package:kiding_frontend/core/widgets/set_player_num_widget.dart';
import 'package:kiding_frontend/screen/space/space_set_player_order_screen.dart';

class SpaceSetPlayerNumberScreen extends StatefulWidget {
  const SpaceSetPlayerNumberScreen({super.key});

  @override
  State<SpaceSetPlayerNumberScreen> createState() =>
      _SpaceSetPlayerNumberScreenState();
}

class _SpaceSetPlayerNumberScreenState
    extends State<SpaceSetPlayerNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return SetPlayerNumWidget(
      bg: "assets/space/space_tutorial_bg.png",
      bacnBtn: "assets/space/back_icon_white.png",
      textColor: Color(0xFFE7E7E7),
      chImg: "assets/space/space_tutorial1_ch.png",
      gameName: "키키의 우주여행",
      nextScreen: SpaceSetPlayerOrderScreen(),
    );
  }
}
