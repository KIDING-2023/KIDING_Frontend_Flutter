import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/play_layout.dart';

class KikisdayPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlayLayout(
        bg: 'assets/kikisday/kikiplay_bg.png',
        backIcon: 'assets/kikisday/back_icon.png',
        nextScreen: '/kikisday_qr',
        playBtn: 'assets/kikisday/kikiplay_btn.png');
  }
}
