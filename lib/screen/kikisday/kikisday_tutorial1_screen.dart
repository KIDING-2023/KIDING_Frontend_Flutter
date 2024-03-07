import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'kikisday_tutorial2_screen.dart';

void main() {
  runApp(MaterialApp(home: KikisdayTutorial1Screen()));
}

class KikisdayTutorial1Screen extends StatefulWidget {
  @override
  _KikisdayTutorial1ScreenState createState() => _KikisdayTutorial1ScreenState();
}

class _KikisdayTutorial1ScreenState extends State<KikisdayTutorial1Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/kikisday/kikisday_tutorial1_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 30.0, right: 30.0),
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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/kikisday/kikisday_tutorial1_text.png', width: 339.79, height: 296.58),
                    Image.asset('assets/kikisday/kikisday_tutorial1_ch.png', width: 360, height: 348.39),
                    GestureDetector(
                      onTap: () {
                        // 튜토리얼2로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => KikisdayTutorial2Screen()),
                        );
                      },
                      child: Image.asset('assets/kikisday/kikisday_ok_btn.png', width: 322.07, height: 44.75),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}