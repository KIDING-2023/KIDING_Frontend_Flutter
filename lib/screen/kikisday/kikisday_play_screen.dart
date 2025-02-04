import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/layout/play_layout.dart';

class KikisdayPlayScreen extends StatefulWidget {
  const KikisdayPlayScreen({super.key});

  @override
  State<KikisdayPlayScreen> createState() => _KikisdayPlayScreenState();
}

class _KikisdayPlayScreenState extends State<KikisdayPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return PlayLayout(
        bg: 'assets/kikisday/kikisday_bg.png',
        backIcon: 'assets/kikisday/back_icon.png',
        nextScreen: '/kikisday_qr',
        playBtn: 'assets/kikisday/kikiplay_btn.png');
  }
}
