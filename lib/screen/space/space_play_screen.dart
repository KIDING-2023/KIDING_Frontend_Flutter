import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/layout/play_layout.dart';

class SpacePlayScreen extends StatefulWidget {
  const SpacePlayScreen({super.key});

  @override
  State<SpacePlayScreen> createState() => _SpacePlayScreenState();
}

class _SpacePlayScreenState extends State<SpacePlayScreen> {
  @override
  Widget build(BuildContext context) {
    return PlayLayout(
        bg: 'assets/space/space_bg.png',
        backIcon: 'assets/space/back_icon_white.png',
        nextScreen: '/space_qr',
        playBtn: 'assets/kikisday/kikiplay_btn.png');
  }
}
