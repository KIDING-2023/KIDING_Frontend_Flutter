import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiding/screen/login/start_screen.dart';
import 'find_password_result_screen.dart';

// 비밀번호 찾기 - 전화번호 인증 코드 입력 화면
class PasswordPhoneScreen extends StatefulWidget {
  final String phone; // 전화번호 받아오기

  const PasswordPhoneScreen(
      {super.key, required this.phone});

  @override
  State<PasswordPhoneScreen> createState() => _PasswordPhoneScreenState();
}

class _PasswordPhoneScreenState extends State<PasswordPhoneScreen> {
  final _codeController = TextEditingController(); // 인증코드 입력 컨트롤러
  bool errorVisible = false; // 에러 메시지 가시성
  String errorMessage = ""; // 에러 메시지
  bool codeSent = false; // 인증 코드 전송 여부
  late String _verificationId; // 인증 코드

  @override
  void initState() {
    super.initState();
    _sendCode(); // 화면 로드 시 인증번호 전송 함수 실행
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: [
          // 뒤로가기 버튼
          Positioned(
            top: screenSize.height * 0.06,
            left: screenSize.width * 0.03,
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StartScreen()));
              },
              icon: Image.asset('assets/kikisday/back_icon.png',
                  width: screenSize.width * 0.04,
                  height: screenSize.height * 0.03),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // '전화번호 인증을 진행합니다' 텍스트
              Image.asset('assets/login/phone_greeting_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.16),
              // 인증번호 입력칸, 비밀번호 찾기 버튼
              Column(
                // 인증번호 입력 칸
                children: [
                  Container(
                    width: screenSize.width * 0.73,
                    height: screenSize.height * 0.06,
                    // 텍스트 박스 하단 그림자
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.15),
                            spreadRadius: 0,
                            blurRadius: 1.75,
                            offset:
                                Offset(0, 0.87), // changes position of shadow
                          )
                        ]),
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
                    height: screenSize.height * 0.01,
                  ),
                  // 인증번호 오류 메시지
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: screenSize.width * 0.21)),
                      Visibility(
                        visible: errorVisible,
                        child: Icon(
                          Icons.circle,
                          size: screenSize.width * 0.01,
                          fill: 1.0,
                          color: Color(0xFFFFA37C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: screenSize.width * 0.01)),
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
                    height: screenSize.height * 0.01,
                  ),
                  // 비밀번호 찾기 버튼
                  IconButton(
                    onPressed: _verifyCode,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/find_password_btn.png',
                        width: screenSize.width * 0.73),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }

  // 인증번호 전송
  void _sendCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 180),
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
          verificationId: _verificationId, smsCode: _codeController.text);
      await auth
          .signInWithCredential(credential)
          .then((UserCredential userCredential) {
        // 인증 성공, 다음 화면으로 네비게이션
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FindPasswordResultScreen()));
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

  // 전화번호를 통해 uid (or token) 받아오는 로직 추가 필요 -> 다음 화면으로 전달
}
