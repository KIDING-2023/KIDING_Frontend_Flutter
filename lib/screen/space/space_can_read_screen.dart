import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kiding/screen/space/space_tutorial1_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';

// 필요 없어질 예정...

class SpaceCanReadScreen extends StatefulWidget {
  const SpaceCanReadScreen({super.key});

  @override
  State<SpaceCanReadScreen> createState() => _SpaceCanReadScreenState();
}

class _SpaceCanReadScreenState extends State<SpaceCanReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/space/space_tutorial_bg.png'),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0, left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('assets/space/back_icon_white.png',
                      width: 13.16, height: 20.0),
                ),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: Color(0xFFE7E7E7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 100,
              child: Image.asset('assets/space/can_read_text_box.png',
                  width: 339.79, height: 334.89)),
          Positioned(
              left: 0,
              right: 0,
              top: 285,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SpaceTutorial1Screen()));
                },
                child: Image.asset('assets/space/can_read_button.png',
                    width: 268.06, height: 44.75),
              )),
          Positioned(
              left: 0,
              right: 0,
              top: 340,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SpaceTutorial1Screen()));
                },
                child: Image.asset('assets/space/can_not_read_button.png',
                    width: 268.06, height: 44.75),
              )),
          Positioned(
            left: 0,
            right: 0,
            top: 400,
            child: Image.asset('assets/space/space_tutorial1_ch.png',
                width: 360, height: 348.39),
          ),
        ],
      ),
    );
  }
}
