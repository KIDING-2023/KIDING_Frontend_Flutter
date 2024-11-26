import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/core/widgets/card_layout.dart';
import 'package:kiding/screen/layout/card_qr_text_screen.dart';
import 'package:kiding/screen/space/space_venus_complete_screen.dart';

import '../layout/space_card_layout.dart';

class Space4Screen extends StatefulWidget {
  const Space4Screen({super.key});

  @override
  State<Space4Screen> createState() => _Space4ScreenState();
}

class _Space4ScreenState extends State<Space4Screen> {
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
  //             MaterialPageRoute(builder: (context) => SpaceBarcodeTextScreen(currentNumber: 4, canread: canread)),
  //           );
  //         });
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SpaceCardLayout(
        bgStr: 'assets/space/venus_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/4_text.png',
        cardStr: 'assets/space/venus_card.png',
        completeScreen: SpaceVenusCompleteScreen(
          currentNumber: 4
        ),
        okBtnStr: 'assets/space/venus_card_btn.png',
        timerColor: Color(0xFFE7E7E7), currentNumber: 4,);
  }
}
