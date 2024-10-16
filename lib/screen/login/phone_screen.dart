import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiding/screen/login/password_screen.dart';
import 'back_screen.dart';

// 회원가입 전화번호 인증 화면
class PhoneScreen extends StatefulWidget {
  final String nickname;

  const PhoneScreen({super.key, required this.nickname});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _phoneController = TextEditingController(); // 전화번호 입력 컨트롤러
  final _codeController = TextEditingController(); // 인증 코드 입력 컨트롤러
  bool codeSent = false; // 인증 코드 전송 여부
  bool errorVisible = false; // 에러 발생 여부
  String errorMessage = ""; // 에러 메시지
  late String _verificationId; // 인증 코드

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          // 뒤로가기 버튼
          Positioned(
            top: screenSize.height * 0.06,
            left: screenSize.width * 0.03,
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BackScreen()));
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
              Column(
                // 전화번호 입력칸 || 인증번호 입력칸
                children: [
                  Container(
                    width: screenSize.width * 0.73,
                    height: screenSize.height * 0.06,
                    child: TextField(
                      controller: codeSent ? _codeController : _phoneController,
                      decoration: InputDecoration(
                          hintText: codeSent ? '인증번호를 입력하세요' : 'ex.01012345678',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          filled: true,
                          fillColor: Color(0xfff6f6f6),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                          contentPadding: EdgeInsets.all(20)),
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
                  // 인증번호 전송 여부 메세지
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.21)),
                      Visibility(
                        visible: errorVisible,
                        child: Icon(
                          Icons.circle,
                          size: screenSize.width * 0.01,
                          fill: 1.0,
                          color: Color(0xFFFFA37C),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.01)),
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
                  // 입력 완료 버튼
                  IconButton(
                    onPressed: codeSent ? _verifyCode : _sendCode,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/input_finish_btn.png',
                        width: screenSize.width * 0.73),
                  ),
                ],
              ),
              // 진행 표시 선
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/login/progress.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Image.asset('assets/login/progress_colored.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Image.asset('assets/login/progress.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                ],
              )
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
      // 3분 시간 제한
      phoneNumber: _phoneController.text.replaceFirst('0', '+82'),
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
    String phoneNumber = _phoneController.text;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: _codeController.text);
      await auth
          .signInWithCredential(credential)
          .then((UserCredential userCredential) {
        // 인증 성공, 다음 화면으로 이동
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PasswordScreen(
                    nickname: widget.nickname, phoneNumber: phoneNumber)));
      }).catchError((error) {
        // 인증 실패, 에러 메시지 표시
        setState(() {
          errorVisible = true;
          errorMessage = '인증번호가 일치하지 않습니다.';
        });
      });
    } catch (e) {
      // 다른 예외 처리
      setState(() {
        errorVisible = true;
        errorMessage = '인증 처리 중 문제가 발생했습니다: ${e.toString()}';
      });
    }
  }
}
