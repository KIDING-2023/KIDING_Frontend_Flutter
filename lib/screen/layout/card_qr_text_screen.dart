import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/layout/card_qr_screen.dart';

class CardQRTextScreen extends StatefulWidget {
  final int currentNumber;
  final Color color;
  final int chips;

  //final bool canread;

  const CardQRTextScreen(
      {super.key,
      required this.currentNumber,
      required this.color,
      required this.chips});

  @override
  State<CardQRTextScreen> createState() => _CardQRTextScreenState();
}

class _CardQRTextScreenState extends State<CardQRTextScreen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: duration), _navigateToScanScreen);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _navigateToScanScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => CardQRScreen(
              currentNumber: widget.currentNumber,
              color: widget.color,
              chips: widget.chips)),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    String game = widget.color == Color(0xFF868686) ? 'kikisday' : 'space';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$game/card_qr_text_screen.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
