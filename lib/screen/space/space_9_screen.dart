import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_barcode_text_screen.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';

import '../layout/card_layout.dart';
import '../layout/space_card_layout.dart';

class Space9Screen extends StatefulWidget {
  const Space9Screen({super.key});

  @override
  State<Space9Screen> createState() => _Space9ScreenState();
}

class _Space9ScreenState extends State<Space9Screen> {
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
  //             MaterialPageRoute(builder: (context) => SpaceBarcodeTextScreen(currentNumber: 9, canread: canread)),
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
        textStr: 'assets/space/9_text.png',
        cardStr: 'assets/space/mars_card.png',
        completeScreen: SpaceMarsCompleteScreen(
          currentNumber: 9
        ),
        okBtnStr: 'assets/space/mars_card_btn.png',
        timerColor: Color(0xFFE7E7E7), currentNumber: 9,);
  }
}
