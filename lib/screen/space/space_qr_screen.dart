import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as mlkit;
import 'package:image_picker/image_picker.dart';
import 'package:kiding/screen/space/space_tutorial1_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' as io;

import '../layout/exit_layout.dart';

class SpaceQrScreen extends StatefulWidget {
  const SpaceQrScreen({super.key});

  @override
  State<SpaceQrScreen> createState() => _SpaceQrScreenState();
}

class _SpaceQrScreenState extends State<SpaceQrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool useCamera = true;
  final picker = ImagePicker();

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
              textAlign: TextAlign.center, // 텍스트 정렬
              text: TextSpan(
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white, // 기본 텍스트 색상
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '책 뒷면\n큐알코드',
                    style: TextStyle(fontFamily: 'Nanum'), // 두께 굵게
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
                'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NanumRegular',
                    color: Colors.white),
              ),
            ),
          Positioned(
            bottom: screenHeight * 0.25,
            child: Text(
              result == null ? 'Scan a code' : '',
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'NanumRegular',
                  color: Colors.white),
            ),
          ),
          Positioned(
            top: screenHeight * 0.0375,
            left: screenWidth * 0.0417,
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
                  'assets/space/back_icon_white.png',
                  width: screenWidth * 0.0366,
                  height: screenHeight * 0.025,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 250.0;
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
        builder: (context) => SpaceTutorial1Screen(),
      ),
    );
  }
}
