import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_barcode_screen.dart';

class SpaceBarcodeTextScreen extends StatefulWidget {
  final int currentNumber;
  final bool canread;

  const SpaceBarcodeTextScreen(
      {super.key, required this.currentNumber, required this.canread});

  @override
  State<SpaceBarcodeTextScreen> createState() => _SpaceBarcodeTextScreenState();
}

class _SpaceBarcodeTextScreenState extends State<SpaceBarcodeTextScreen> {
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
          builder: (context) => SpaceBarcodeScreen(
              currentNumber: widget.currentNumber, canread: widget.canread)),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/space/barcode_text_screen.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
