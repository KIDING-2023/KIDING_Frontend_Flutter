import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/timer_model.dart';

class KikisdayDiceScreen extends StatefulWidget {
  @override
  _KikisdayDiceScreenState createState() => _KikisdayDiceScreenState();
}

class _KikisdayDiceScreenState extends State<KikisdayDiceScreen> {
  bool _showGif = false; // 주사위 GIF를 표시할지 여부를 결정하는 플래그

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/kikisday/kikisday_dice_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            // 사용자가 아래에서 위로 스와이프할 경우 GIF 애니메이션을 표시합니다.
            if (details.primaryDelta! < 0 && !_showGif) {
              setState(() {
                _showGif = true;
              });
              Future.delayed(Duration(milliseconds: 500), () {
                // GIF 애니메이션 재생 완료 후 다음 액션 수행 (예시: 새 화면으로 이동)
              });
            }
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 45.0, left: 30.0, right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                          'assets/kikisday/kikisday_back_btn.png',
                          width: 13.16,
                          height: 20.0),
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
              Expanded(
                child: Stack(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 50,
                      child: Image.asset('assets/kikisday/kikisday_dice_text.png',
                          width: 339.79, height: 169.78),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: !_showGif, // GIF가 표시되지 않을 때만 swipe 이미지를 보여줍니다.
                        child: Padding(
                          padding: const EdgeInsets.only(top: 19.89),
                          child: Image.asset('assets/kikisday/dice_swipe.png',
                              width: 87.87, height: 139.91),
                        ),
                      ),
                    ),
                    _showGif
                        ? Image.asset(
                            'assets/kikisday/dice1.gif') // 주사위 GIF 애니메이션
                        : Image.asset('assets/kikisday/dice_img3.png',
                            width: 360, height: 266.68), // 정적 주사위 이미지
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
