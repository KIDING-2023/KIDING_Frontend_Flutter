import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'find_nickname_result_screen.dart';

class NicknamePhoneScreen extends StatefulWidget {
  final String nickname;
  final String phone;

  const NicknamePhoneScreen({super.key, required this.nickname, required this.phone});

  @override
  State<NicknamePhoneScreen> createState() => _NicknamePhoneScreenState();
}

class _NicknamePhoneScreenState extends State<NicknamePhoneScreen> {
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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // 뒤로가기 버튼
          Positioned(
            top: 30.0,
            left: 30.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/kikisday/back_icon.png',
                    width: 13.16, height: 20.0),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 안내문
              Image.asset('assets/login/phone_greeting_text.png',
                  width: 267.47, height: 128),
              Column(
                // 인증번호 입력 칸
                children: [
                  Container(
                    width: screenSize.width * 0.7,
                    child: TextField(
                      controller: _codeController,
                      decoration: InputDecoration(
                          hintText: '인증번호를 입력하세요',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                          contentPadding: EdgeInsets.only(left: 20)),
                      style: TextStyle(
                        fontFamily: 'nanum',
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // 인증번호 오류 메시지
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // 닉네임 찾기 버튼
                  IconButton(
                    onPressed: _verifyCode,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/find_nickname_btn.png',
                        width: screenSize.width * 0.7),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
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
                builder: (context) => FindNicknameResultScreen(nickname: widget.nickname)
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
