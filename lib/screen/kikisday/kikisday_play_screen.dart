import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_qr_screen.dart';
import 'package:kiding/screen/layout/play_layout.dart';

class KikisdayPlayScreen extends StatefulWidget {
  final int userId;

  const KikisdayPlayScreen({super.key, required this.userId});

  @override
  State<KikisdayPlayScreen> createState() => _KikisdayPlayScreenState();
}

class _KikisdayPlayScreenState extends State<KikisdayPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return PlayLayout(
        bg: 'assets/kikisday/kikiplay_bg.png',
        backIcon: 'assets/kikisday/back_icon.png',
        screenBuilder: (context) => KikisdayQrScreen(userId: widget.userId),
        playBtn: 'assets/kikisday/kikiplay_btn.png');
  }
}
