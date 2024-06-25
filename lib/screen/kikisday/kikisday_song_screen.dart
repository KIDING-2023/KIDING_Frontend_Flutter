import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/talmud_story_1_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';

class KikisdaySongScreen extends StatefulWidget {
  final int userId;

  const KikisdaySongScreen({super.key, required this.userId});

  @override
  State<KikisdaySongScreen> createState() => _KikisdaySongScreenState();
}

class _KikisdaySongScreenState extends State<KikisdaySongScreen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: duration), _navigateToRandomDiceScreen);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _navigateToRandomDiceScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => KikisdayTalmudStory1Screen(
          currentNumber: 1,
          userId: widget.userId
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // 뒤로 가기 버튼 및 타이머
          Positioned(
            top: 45,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('assets/kikisday/kikisday_back_btn.png', width: 13.16, height: 20.0),
                ),
                Consumer<TimerModel>( // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: Color(0xFF868686),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 카드 텍스트 이미지
          Positioned(
            top: 120.44,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/song_card_text.png',
                width: 339.79, height: 117.56),
          ),
          // 카드 이미지
          Positioned(
            top: 257.79,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/talmud_card.png',
                width: 157.77, height: 221.39),
          ),
        ],
      ),
    );
  }
}

