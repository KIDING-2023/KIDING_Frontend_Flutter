import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';

class KikisdayQrScreen extends StatefulWidget {
  const KikisdayQrScreen({Key? key}) : super(key: key);

  @override
  State<KikisdayQrScreen> createState() => _KikisdayQrScreenState();
}

class _KikisdayQrScreenState extends State<KikisdayQrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool useCamera = true;
  final picker = ImagePicker();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            top: 216.09,
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
          Positioned(
            bottom: 100,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF788CC2),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ToggleButtons(
                  fillColor: Color(0xFFFF8A5B), // 선택된 버튼의 배경 색상
                  selectedColor: Colors.white, // 선택된 버튼의 텍스트 색상
                  color: Colors.white,
                  renderBorder: false,
                  borderRadius: BorderRadius.circular(100), // 버튼의 모서리 둥글기
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('카메라'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('갤러리'),
                    ),
                  ],
                  isSelected: [useCamera, !useCamera],
                  onPressed: (int index) {
                    if (index == 0) {
                      // 카메라 사용
                      controller?.resumeCamera();
                    } else {
                      // 갤러리 사용
                      _getPictureFromGallery();
                    }
                    setState(() {
                      useCamera = index == 0;
                    });
                  },
                  textStyle: TextStyle(
                    fontFamily: 'Nanum',
                    fontSize: 20, // 폰트 굵기
                  ),
                ),
              ),
            ),
          ),
          if (result != null)
            Positioned(
              bottom: 200,
              child: Text(
                'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'NanumRegular',
                  color: Colors.white,
                ),
              ),
            )
          else
            Positioned(
                bottom: 200,
                child: const Text(
                  'Scan a code',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'NanumRegular',
                    color: Colors.white,
                  ),
                )),
          Positioned(
            top: 30,
            left: 30,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/kikisday/back_icon.png',
                width: 13.16,
                height: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getPictureFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      );
      setState(() {
        useCamera = true;
      });
    }
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 200.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xFFFF8A5B),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
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
}
