import 'package:flutter/material.dart';
import 'package:kiding/core/widgets/set_player_order_widget.dart';
import 'kikisday_tutorial1_screen.dart';

class SetPlayerOrderScreen extends StatelessWidget {
  const SetPlayerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SetPlayerOrderWidget(
      bg: "assets/kikisday/kikisday_tutorial1_bg.png",
      backBtn: "assets/kikisday/back_icon.png",
      textColor: Color(0xFF868686),
      chImg: "assets/kikisday/kikisday_tutorial1_ch.png",
      nextScreen: KikisdayTutorial1Screen(),
    );
  }
}