import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/screen/kikisday/set_player_number_screen.dart';
import 'package:kiding_frontend/screen/layout/exit_layout.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'dart:io' as io;

class KikisdayQrScreen extends StatefulWidget {
  const KikisdayQrScreen({super.key});

  @override
  State<KikisdayQrScreen> createState() => _KikisdayQrScreenState();
}

class _KikisdayQrScreenState extends State<KikisdayQrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String errorMessage = ""; // 에러 메시지 상태

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            top: screenHeight * 0.25,
            left: 0,
            right: 0,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '책 뒷면\n큐알코드',
                    style: TextStyle(fontFamily: 'Nanum'),
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
              bottom: screenHeight * 0.25,
              child: Text(
                errorMessage,
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: 'NanumRegular',
                    color: Colors.white),
              ),
            ),
          Positioned(
            top: screenHeight * 0.0375,
            left: screenWidth * 0.0417,
            child: IconButton(
                onPressed: () {
                  _pauseCamera(); // 카메라 일시정지
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
                  width: screenWidth * 0.0366,
                  height: screenHeight * 0.025,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 300.0;
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
        if (result?.code == 'kiding-book-code') {
          _navigateToNextScreen();
        } else {
          errorMessage = '잘못된 코드입니다.';
        }
      });
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
    controller?.pauseCamera();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPlayerNumberScreen(),
      ),
    );
  }
}
