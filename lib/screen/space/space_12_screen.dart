import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/card_qr_text_screen.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';
import 'package:kiding/screen/space/space_saturn_complete_screen.dart';

import '../../core/widgets/card_layout.dart';
import '../layout/space_card_layout.dart';

class Space12Screen extends StatefulWidget {
  const Space12Screen({super.key});

  @override
  State<Space12Screen> createState() => _Space12ScreenState();
}

class _Space12ScreenState extends State<Space12Screen> {
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
  //             MaterialPageRoute(builder: (context) => SpaceBarcodeTextScreen(currentNumber: 12, canread: canread)),
  //           );
  //         });
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SpaceCardLayout(
        bgStr: 'assets/space/saturn_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/12_text.png',
        cardStr: 'assets/space/saturn_card.png',
        completeScreen: SpaceSaturnCompleteScreen(
          currentNumber: 12
        ),
        okBtnStr: 'assets/space/saturn_card_btn.png',
        timerColor: Color(0xFFE7E7E7), currentNumber: 12,);
  }
}
