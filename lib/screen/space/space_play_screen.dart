import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/play_layout.dart';
import 'package:kiding/screen/space/space_tutorial1_screen.dart';

class SpacePlayScreen extends StatefulWidget {
  final int userId;

  const SpacePlayScreen({super.key, required this.userId});

  @override
  State<SpacePlayScreen> createState() => _SpacePlayScreenState();
}

class _SpacePlayScreenState extends State<SpacePlayScreen> {
  @override
  Widget build(BuildContext context) {
    return PlayLayout(
        bg: 'assets/space/space_bg.png',
        backIcon: 'assets/space/back_icon_white.png',
        screenBuilder: (context) => SpaceTutorial1Screen(userId: widget.userId),
        playBtn: 'assets/kikisday/kikiplay_btn.png');
  }
}
