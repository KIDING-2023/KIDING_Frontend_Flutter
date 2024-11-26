import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/card_qr_text_screen.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';

import '../../core/widgets/card_layout.dart';
import '../layout/space_card_layout.dart';

class Space7Screen extends StatefulWidget {
  const Space7Screen({super.key});

  @override
  State<Space7Screen> createState() => _Space7ScreenState();
}

class _Space7ScreenState extends State<Space7Screen> {
  // late bool canread;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   // 인자를 추출합니다.
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final args = ModalRoute.of(context)!.settings.arguments as Map;
  //     if (args != null) {
  //       canread = args['canread'];
  //       // canread가 false인 경우 3초 후에 화면 전환
  //       if (!canread) {
  //         Timer(Duration(seconds: 3), () {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => SpaceBarcodeTextScreen(currentNumber: 7, canread: canread)),
  //           );
  //         });
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SpaceCardLayout(
        bgStr: 'assets/space/mars_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/7_text.png',
        cardStr: 'assets/space/mars_card.png',
        completeScreen: SpaceMarsCompleteScreen(
          currentNumber: 7
        ),
        okBtnStr: 'assets/space/mars_card_btn.png',
        timerColor: Color(0xFFE7E7E7), currentNumber: 7,);
  }
}
