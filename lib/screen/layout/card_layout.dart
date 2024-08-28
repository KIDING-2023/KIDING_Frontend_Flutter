import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/exit_layout.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'card_qr_text_screen.dart';

class CardLayout extends StatelessWidget {
  final String bgStr;
  final String backBtnStr;
  final String textStr;
  final String cardStr;
  final Widget completeScreen;
  final String okBtnStr;
  final Color timerColor;
  final int currentNumber;

  const CardLayout(
      {super.key,
      required this.bgStr,
      required this.backBtnStr,
      required this.textStr,
      required this.cardStr,
      required this.completeScreen,
      required this.okBtnStr,
      required this.timerColor,
      required this.currentNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              bgStr,
              fit: BoxFit.cover,
            ),
          ),
          // 뒤로 가기 버튼 및 타이머
          Positioned(
            top: 45,
            left: 15,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExitLayout(
                                onKeepPressed: () {},
                                onExitPressed: () {},
                                isFromDiceOrCamera: false,
                                isFromCard: true,
                              )),
                    );
                  },
                  icon: Image.asset(backBtnStr, width: 13.16, height: 20.0),
                ),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: timerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 카드 텍스트 이미지
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Image.asset(textStr, width: 336.93, height: 118),
          ),
          // 카드 이미지
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            child: Image.asset(cardStr, width: 170.57, height: 239.34),
          ),
          // 버튼
          Positioned(
              top: 448.44,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // complete 화면으로 전환합니다.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => completeScreen),
                  );
                },
                child: Image.asset(okBtnStr, width: 120, height: 40.58),
              )),
          // 카드덱 읽기 버튼
          Positioned(
              top: 540,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // 바코드 인식 안내 화면으로 이동
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CardQRTextScreen(
                              currentNumber: currentNumber,
                              completeScreen: completeScreen)));
                },
                child: Image.asset('assets/space/read_card_btn.png',
                    width: 112.3, height: 32.68),
              ))
        ],
      ),
    );
    ;
  }
}
