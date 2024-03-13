import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice2_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';

class KikisdaySkyblueCompleteScreen extends StatefulWidget {
  final int currentNumber;

  KikisdaySkyblueCompleteScreen({Key? key, required this.currentNumber})
      : super(key: key);

  @override
  State<KikisdaySkyblueCompleteScreen> createState() =>
      _KikisdaySkyblueCompleteScreenState();
}

class _KikisdaySkyblueCompleteScreenState
    extends State<KikisdaySkyblueCompleteScreen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환

  // 다음 화면
  late var nextScreen;

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
    switch (widget.currentNumber) {
      case 10:
        nextScreen =
            KikisdayRandomDice3Screen(currentNumber: widget.currentNumber);
        break;
      default:
        nextScreen =
            KikisdayRandomDice2Screen(currentNumber: widget.currentNumber);
        break;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_2_dice_bg.png',
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
                  child: Image.asset('assets/kikisday/kikisday_back_btn.png',
                      width: 13.16, height: 20.0),
                ),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
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
          // 키딩칩 획득 이미지
          Positioned(
            top: 127.66,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/skyblue_complete.png',
                width: 336.93, height: 370.14),
          ),
        ],
      ),
    );
  }
}

class KikisdayRandomDice3Screen extends StatelessWidget {
  const KikisdayRandomDice3Screen({super.key, required int currentNumber});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

