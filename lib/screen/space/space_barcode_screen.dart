import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as mlkit;
import 'package:image_picker/image_picker.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';
import 'package:kiding/screen/space/space_saturn_complete_screen.dart';
import 'package:kiding/screen/space/space_venus_complete_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' as io;

class SpaceBarcodeScreen extends StatefulWidget {
  final int currentNumber;
  final bool canread;

  const SpaceBarcodeScreen({super.key, required this.currentNumber, required this.canread});

  @override
  State<SpaceBarcodeScreen> createState() => _SpaceBarcodeScreenState();
}

class _SpaceBarcodeScreenState extends State<SpaceBarcodeScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Barcode');

  bool useCamera = true;
  final picker = ImagePicker();

  // 다음 화면
  late var nextScreen;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    bool hasPermission = await requestCameraPermission(context);
    if (hasPermission) {
      print("Camera permission granted.");
    } else {
      print("Camera permission denied.");
    }
  }

  Future<bool> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = await Permission.camera.request();

    if(!status.isGranted) { // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("권한 설정을 확인해주세요."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                    },
                    child: Text('설정하기')),
              ],
            );
          });
      return false;
    }
    return true;
  }

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
      body: Container(
        color: Color(0xFF363E7C).withOpacity(0.5),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildQrView(context),
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
                      style: TextStyle(fontFamily: 'Nanum', color: Color(0xFFFF8A5B)),
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
                bottom: 200,
                child: Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                  style: TextStyle(fontSize: 15, fontFamily: 'NanumRegular', color: Colors.white),
                ),
              ),
            Positioned(
              bottom: 200,
              child: Text(
                result == null ? 'Scan a code' : '',
                style: TextStyle(fontSize: 15, fontFamily: 'NanumRegular', color: Colors.white),
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

  Widget _buildQrView(BuildContext context) {
    var scanWidth = 250.0;
    var scanHeight = 150.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xFFFF8A5B),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 20,
          cutOutWidth: scanWidth,
          cutOutHeight: scanHeight),
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

  void _navigateToNextScreen() {
    setState(() {
      controller?.pauseCamera();
      controller?.dispose();
    });
    // 각 카드덱의 답변 완료 화면으로 이동
    if (widget.currentNumber <= 6) {
      nextScreen = SpaceVenusCompleteScreen(currentNumber: widget.currentNumber);
    } else if (widget.currentNumber >= 7 && widget.currentNumber <= 9) {
      nextScreen = SpaceMarsCompleteScreen(currentNumber: widget.currentNumber);
    } else {
      nextScreen = SpaceSaturnCompleteScreen(currentNumber: widget.currentNumber);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
    log('currentNumber: ${widget.currentNumber}');
  }
}
