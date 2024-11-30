import 'package:flutter/material.dart';
import 'package:kiding/core/widgets/set_player_order_widget.dart';
import 'package:kiding/screen/space/space_tutorial1_screen.dart';

class SpaceSetPlayerOrderScreen extends StatelessWidget {
  const SpaceSetPlayerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SetPlayerOrderWidget(
      bg: "assets/space/space_tutorial_bg.png",
      backBtn: "assets/space/back_icon_white.png",
      textColor: Color(0xFFE7E7E7),
      chImg: "assets/space/space_tutorial1_ch.png",
      nextScreen: SpaceTutorial1Screen(),
    );
  }
}
