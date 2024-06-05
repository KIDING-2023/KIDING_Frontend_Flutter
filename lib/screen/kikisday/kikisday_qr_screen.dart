import 'dart:developer';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as mlkit;
import 'package:kiding/screen/kikisday/kikisday_tutorial1_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';

class KikisdayQrScreen extends StatefulWidget {
  const KikisdayQrScreen({Key? key}) : super(key: key);

  @override
  State<KikisdayQrScreen> createState() => _KikisdayQrScreenState();
}

class _KikisdayQrScreenState extends State<KikisdayQrScreen> {
  // mlkit.Barcode? mlresult;

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool useCamera = true;
  final picker = ImagePicker();

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
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            top: 150,
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
                  fillColor:
                      Colors.transparent, // ToggleButtons 자체의 배경색을 투명하게 설정
                  splashColor: Colors.transparent, // Splash 효과를 없애기 위해 투명하게 설정
                  highlightColor:
                      Colors.transparent, // Highlight 효과를 없애기 위해 투명하게 설정
                  selectedColor: Colors.white,
                  color: Colors.white,
                  renderBorder: false,
                  children: <Widget>[
                    _buildToggleButton(
                        '카메라', useCamera), // 변경된 _buildToggleButton 함수를 사용
                    _buildToggleButton(
                        '갤러리', !useCamera), // 변경된 _buildToggleButton 함수를 사용
                  ],
                  isSelected: [useCamera, !useCamera],
                  onPressed: (int index) {
                    if (index == 0) {
                      controller?.resumeCamera();
                    } else {
                      //_getPictureFromGallery();
                      // 이 부분을 제거합니다. _getPictureFromGallery 메소드 내부에서 상태를 관리하게 합니다.
                    }
                  },
                  textStyle: TextStyle(
                    fontFamily: 'Nanum',
                    fontSize: 20,
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

  // _buildToggleButton 함수는 선택된 상태에 따라 다르게 보이는 버튼을 생성합니다.
  Widget _buildToggleButton(String text, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? Color(0xFFFF8A5B)
            : Colors.transparent, // 선택된 상태에 따른 색상
        borderRadius: BorderRadius.circular(100), // 모든 모서리를 둥글게 설정
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Text(text),
      ),
    );
  }

  // void _getPictureFromGallery() async {
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final inputImage = mlkit.InputImage.fromFilePath(pickedFile.path);
  //     final barcodeScanner = mlkit.GoogleMlKit.vision.barcodeScanner();
  //
  //     try {
  //       final List<mlkit.Barcode> barcodes = await barcodeScanner.processImage(inputImage);
  //
  //       for (mlkit.Barcode barcode in barcodes) {
  //         if (barcode.format == mlkit.BarcodeFormat.qrCode) {
  //           // Assume barcode is of type text and access text property
  //           final String qrCodeValue = barcode.displayValue ?? 'No QR code data';
  //
  //           // QR 코드의 값을 사용합니다.
  //           print('Found QR Code: $qrCodeValue');
  //
  //           // Update the state with the scanned QR code
  //           setState(() {
  //             mlresult = barcode;
  //           });
  //
  //           // Optionally, navigate to the next screen or perform other actions
  //           // _navigateToNextScreen(context, barcode);
  //         }
  //       }
  //     } on Exception catch (e) {
  //       print('Error occurred while scanning the QR Code: $e');
  //     } finally {
  //       // 자원을 해제합니다.
  //       barcodeScanner.close();
  //     }
  //   }
  // }

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
    if (result != null) {
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          controller?.pauseCamera();
          controller?.dispose();
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KikisdayTutorial1Screen(),
          ),
        );
      });
    }
  }
}
