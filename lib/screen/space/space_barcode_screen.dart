import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:kiding/screen/space/space_earth_complete_screen.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';
import 'package:kiding/screen/space/space_saturn_complete_screen.dart';
import 'package:kiding/screen/space/space_venus_complete_screen.dart';
import 'package:mysql_client/mysql_protocol.dart';

class SpaceBarcodeScreen extends StatefulWidget {
  final int currentNumber;

  const SpaceBarcodeScreen({super.key, required this.currentNumber});

  @override
  State<SpaceBarcodeScreen> createState() => _SpaceBarcodeScreenState();
}

class _SpaceBarcodeScreenState extends State<SpaceBarcodeScreen> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  // 다음 화면
  late var nextScreen;

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });

    // 3초의 딜레이 후 다음 화면으로 전환
    Future.delayed(Duration(seconds: 3), () {
      _navigateToNextScreen();
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _navigateToNextScreen() {
    // 각 카드덱의 답변 완료 화면으로 이동
    if (widget.currentNumber <= 3) {
      nextScreen =
          SpaceEarthCompleteScreen(currentNumber: widget.currentNumber);
    } else if (widget.currentNumber >= 4 && widget.currentNumber <= 6) {
      nextScreen =
          SpaceVenusCompleteScreen(currentNumber: widget.currentNumber);
    } else if (widget.currentNumber >= 7 && widget.currentNumber <= 9) {
      nextScreen = SpaceMarsCompleteScreen(currentNumber: widget.currentNumber);
    } else {
      nextScreen =
          SpaceSaturnCompleteScreen(currentNumber: widget.currentNumber);
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
      body: Container(
        color: Color(0xFF363E7C),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _camState
                ? Center(
                    child: SizedBox(
                    width: 250,
                    height: 150,
                    child: QRBarScannerCamera(
                      onError: (context, error) => Text(
                        error.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      qrCodeCallback: (code) {
                        _qrCallback(code);
                      },
                    ),
                  ))
                : Positioned(bottom: 200, child: Text(_qrInfo!)),
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: RichText(
                textAlign: TextAlign.center, // 텍스트 정렬
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white, // 기본 텍스트 색상
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '카드덱의\n',
                      style: TextStyle(fontFamily: 'Nanum'), // 두께 굵게
                    ),
                    TextSpan(
                      text: '바코드',
                      style: TextStyle(
                          fontFamily: 'Nanum', color: Color(0xFFFF8A5B)),
                    ),
                    TextSpan(
                        text: '를 인식해주세요',
                        style: TextStyle(fontFamily: 'NanumRegular')),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 30,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/space/back_icon_white.png',
                  width: 13.16,
                  height: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
