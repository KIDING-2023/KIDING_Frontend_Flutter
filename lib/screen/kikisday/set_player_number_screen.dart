import 'package:flutter/material.dart';
import 'package:kiding/core/widgets/set_player_num_widget.dart';
import 'package:kiding/screen/kikisday/set_player_order_screen.dart';

class SetPlayerNumberScreen extends StatefulWidget {
  const SetPlayerNumberScreen({super.key});

  @override
  State<SetPlayerNumberScreen> createState() => _SetPlayerNumberScreenState();
}

class _SetPlayerNumberScreenState extends State<SetPlayerNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return SetPlayerNumWidget(
      bg: "assets/kikisday/kikisday_tutorial1_bg.png",
      bacnBtn: "assets/kikiday/back_icon.png",
      textColor: Color(0xFF868686),
      chImg: "assets/kikisday/kikisday_tutorial1_ch.png",
      gameName: "키키의 하루",
      nextScreen: SetPlayerOrderScreen(),
    );
  }
}
