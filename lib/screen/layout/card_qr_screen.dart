import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiding_frontend/screen/layout/card_read_layout.dart';
import 'package:kiding_frontend/screen/layout/exit_layout.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'dart:io' as io;

class CardQRScreen extends StatefulWidget {
  final int currentNumber;
  final Color color;
  final int chips;

  const CardQRScreen(
      {super.key,
      required this.currentNumber,
      required this.color,
      required this.chips});

  @override
  State<CardQRScreen> createState() => _CardQRScreenState();
}

class _CardQRScreenState extends State<CardQRScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool useCamera = true;
  final picker = ImagePicker();

  String codeResult = "";

  @override
  void reassemble() {
    super.reassemble();
    if (io.Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (io.Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            top: 200.h,
            left: 0,
            right: 0,
            child: RichText(
              textAlign: TextAlign.center, // 텍스트 정렬
              text: TextSpan(
                style: TextStyle(
                  fontSize: 25.sp,
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
          if (result != null)
            Positioned(
              bottom: 200.h,
              child: Text(
                'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NanumRegular',
                    color: Colors.white),
              ),
            ),
          Positioned(
            bottom: 200.h,
            child: Text(
              result == null ? 'Scan a code' : '',
              style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'NanumRegular',
                  color: Colors.white),
            ),
          ),
          Positioned(
            top: 30.h,
            left: 15.w,
            child: IconButton(
                onPressed: () {
                  _pauseCamera();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExitLayout(
                              onKeepPressed: _resumeCamera,
                              onExitPressed: _disposeCamera,
                              isFromDiceOrCamera: true,
                              isFromCard: false,
                            )),
                  );
                },
                icon: Image.asset(
                  'assets/kikisday/back_icon.png',
                  width: 13.16.w,
                  height: 20.h,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xFFFF8A5B),
          borderRadius: 10,
          borderLength: 50,
          borderWidth: 20,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        codeResult = result!.code!;
        _navigateToNextScreen();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _pauseCamera() {
    controller?.pauseCamera();
  }

  void _resumeCamera() {
    controller?.resumeCamera();
  }

  void _disposeCamera() {
    controller?.dispose();
  }

  void _navigateToNextScreen() {
    setState(() {
      controller?.pauseCamera();
      controller?.dispose();
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardReadLayout(
              currentNumber: widget.currentNumber,
              codeResult: codeResult,
              color: widget.color,
              chips: widget.chips)),
    );
  }
}
