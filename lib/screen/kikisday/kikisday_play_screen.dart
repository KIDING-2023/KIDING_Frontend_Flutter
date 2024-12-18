import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/layout/play_layout.dart';

class KikisdayPlayScreen extends StatelessWidget {
  const KikisdayPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayLayout(
        bg: 'assets/kikisday/kikisday_bg.png',
        backIcon: 'assets/kikisday/back_icon.png',
        nextScreen: '/kikisday_set_player_num',
        playBtn: 'assets/kikisday/kikiplay_btn.png');
  }
}
