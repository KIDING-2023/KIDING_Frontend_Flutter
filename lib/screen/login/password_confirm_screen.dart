import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'back_screen.dart';
import 'login_splash_screen.dart';

// 회원가입 비밀번호 입력 확인 화면
class PasswordConfirmScreen extends StatefulWidget {
  final String nickname; // 닉네임 받아오기
  final String phoneNumber; // 전화번호 받아오기
  final String password; // 비밀번호 받아오기

  const PasswordConfirmScreen(
      {super.key,
      required this.nickname,
      required this.phoneNumber,
      required this.password});

  @override
  State<PasswordConfirmScreen> createState() => _PasswordConfirmScreenState();
}

class _PasswordConfirmScreenState extends State<PasswordConfirmScreen> {
  final TextEditingController _pwController =
      TextEditingController(); // 비밀번호 입력 컨트롤러
  String errorMessage = "비밀번호를 다시 입력하세요"; // 에러 메시지 (항상 표시)
  bool _isErrorVisible = true; // 에러 메시지 앞 동그라미 가시성
  bool _isLoading = false; // 로딩 상태 표시

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
              // 안내문
              Image.asset('assets/login/password_confirm_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.16),
              // 비밀번호 입력칸, 입력 완료 버튼
              Column(
                // 비밀번호 입력 칸
                children: [
                  Container(
                    width: screenSize.width * 0.73,
                    height: screenSize.height * 0.06,
                    child: TextField(
                      controller: _pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '비밀번호를 다시 입력하세요',
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
                  // 비밀번호 오류 메시지
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.21)),
                      Visibility(
                        visible: _isErrorVisible,
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
                    onPressed: _pw,
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
                  Image.asset('assets/login/progress.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Image.asset('assets/login/progress_colored.png',
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

  // 비밀번호 일치 여부 확인 및 서버로 회원가입 요청
  void _pw() async {
    String pw_test = _pwController.text;
    String pw = widget.password;

    if (pw_test != pw) {
      setState(() {
        _isErrorVisible = true;
        errorMessage = "비밀번호가 일치하지 않습니다.";
      });
    } else {
      // 비밀번호가 일치하는 경우 회원가입 요청
      setState(() {
        _isLoading = true; // 로딩 상태 표시
      });

      // 회원가입 요청 후 토큰 받아오기
      String? token = await signupAndLogin(widget.nickname, pw_test, widget.phoneNumber);

      setState(() {
        _isLoading = false; // 로딩 상태 해제
      });

      if (token != null) {
        // 회원가입 및 로그인 성공 시 토큰을 LoginSplashScreen으로 전달
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginSplashScreen(
              nickname: widget.nickname,
              //token: token, // 토큰 전달
            ),
          ),
        );
      } else {
        // 회원가입 실패 시 오류 메시지 표시
        setState(() {
          _isErrorVisible = true;
          errorMessage = "회원가입에 실패했습니다.";
        });
      }
    }
  }

  // Flutter Secure Storage 인스턴스
  final storage = FlutterSecureStorage();

  Future<String?> signupAndLogin(String nickname, String password, String phoneNumber) async {
    final signupUrl = Uri.parse('https://6a4c-182-209-67-24.ngrok-free.app/signup');
    final loginUrl = Uri.parse('https://6a4c-182-209-67-24.ngrok-free.app/signin');
    final headers = {'Content-Type': 'application/json'};

    final signupBody = jsonEncode({
      'nickname': nickname,
      'password': password,
      'phone': phoneNumber,
    });

    try {
      // 회원가입 요청
      final signupResponse = await http.post(signupUrl, headers: headers, body: signupBody);

      if (signupResponse.statusCode == 200) {
        final signupData = jsonDecode(signupResponse.body);
        print('Signup Response Data: $signupData');

        if (signupData['isSuccess']) {
          // 로그인 요청
          final loginBody = jsonEncode({
            'nickname': nickname,
            'password': password,
          });

          final loginResponse = await http.post(loginUrl, headers: headers, body: loginBody);
          if (loginResponse.statusCode == 200) {
            final loginData = jsonDecode(loginResponse.body);
            print('Login Response Data: $loginData');

            if (loginData['isSuccess']) {
              final String token = loginData['result']['accessToken']; // 토큰 받기
              return token; // 토큰 반환
            } else {
              print('Login failed: ${loginData['message']}');
              return null;
            }
          } else {
            print('Login Server Error: ${loginResponse.statusCode}');
            print('Login Response Body: ${loginResponse.body}');
            return null;
          }
        } else {
          print('Signup failed: ${signupData['message']}');
          return null;
        }
      } else {
        print('Signup Server Error: ${signupResponse.statusCode}');
        print('Signup Response Body: ${signupResponse.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null; // 네트워크 오류 시 null 반환
    }
  }
}
