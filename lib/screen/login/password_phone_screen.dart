import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'find_password_result_screen.dart';

class PasswordPhoneScreen extends StatefulWidget {
  final String password;
  final String phone;

  const PasswordPhoneScreen({super.key, required this.password, required this.phone});

  @override
  State<PasswordPhoneScreen> createState() => _PasswordPhoneScreenState();
}

class _PasswordPhoneScreenState extends State<PasswordPhoneScreen> {
  final _codeController = TextEditingController();
  bool errorVisible = false;
  String errorMessage = "";

  bool codeSent = false;
  late String _verificationId;
  late String smsCode;

  @override
  void initState() {
    super.initState();
    _sendCode();  // 화면 로드 시 인증번호 전송 함수 실행
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 전화번호 인증 안내문
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/phone_greeting_text.png',
                  width: 267.47, height: 128)),
          // 인증번호 입력칸
          Positioned(
              top: 351.64,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/nickname_box.png',
                  width: 261.32, height: 49.82)),
          Positioned(
              top: 351.64,
              left: 80.56,
              right: 0,
              child: TextField(
                controller: _codeController,
                decoration: InputDecoration(
                    hintText: '인증번호를 입력하세요',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    border: InputBorder.none),
                style: TextStyle(
                    fontFamily: 'nanum', fontSize: 17, color: Colors.black),
              )),
          // 인증번호 안내문
          Positioned(
              top: 413.29,
              left: 76.93,
              child: Row(
                children: [
                  Visibility(
                    visible: errorVisible,
                    child: Icon(
                      Icons.circle,
                      size: 2.63,
                      fill: 1.0,
                      color: Color(0xFFFFA37C),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 5.0)),
                  Text(
                    errorMessage,
                    style: TextStyle(
                        fontFamily: 'nanum',
                        fontSize: 13,
                        color: Color(0xFFFFA37C)),
                  ),
                ],
              )),
          // 비밀번호 찾기 버튼
          Positioned(
              top: 439.01,
              left: 0,
              right: 0,
              child: IconButton(
                onPressed: _verifyCode,
                padding: EdgeInsets.zero,
                icon: Image.asset('assets/login/find_password_btn.png',
                    width: 261.32, height: 49.82),
              )),
        ],
      ),
    );
  }

  // 인증번호 전송
  void _sendCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print("번호 인증 완료");
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print("The provided phone number is not valid.");
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          codeSent = true;
          errorVisible = true;
          errorMessage = "인증번호가 전송되었습니다.";
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (timeout) {
        print("handling code auto retrieval timeout");
      },
    );
  }


  // 인증번호 확인
  void _verifyCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _codeController.text
      );
      await auth.signInWithCredential(credential).then((UserCredential userCredential) {
        // 인증 성공, 다음 화면으로 네비게이션
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FindPasswordResultScreen(password: widget.password)
            )
        );
      }).catchError((error) {
        // 인증 실패, 에러 메시지 설정
        setState(() {
          errorVisible = true;
          errorMessage = '인증번호가 일치하지 않습니다.';
        });
      });
    } catch (e) {
      // 다른 예외 처리, 예를 들어 네트워크 에러 등
      setState(() {
        errorVisible = true;
        errorMessage = '인증 처리 중 문제가 발생했습니다: ${e.toString()}';
      });
    }
  }
}
