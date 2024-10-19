import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding/constants/api_constants.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:kiding/screen/login/signup_screen.dart';

import 'find_nickname_screen.dart';
import 'find_password_screen.dart';

import 'dart:convert'; // JSON 인코딩, 디코딩을 위한 패키지
import 'package:http/http.dart' as http;

// 시작 화면 (로그인 화면)
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _nicknameController = TextEditingController(); // 닉네임 컨트롤러
  final _passwordController = TextEditingController(); // 비밀번호 컨트롤러
  bool errorVisible = false; // 에러 메시지 가시성
  String errorMessage = ""; // 에러 메시지
  bool _isStayLoggedIn = false; // 로그인 상태 유지 체크
  final _storage = FlutterSecureStorage(); // Secure storage 객체 생성

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기의 화면 크기
    return Scaffold(
        body: Center(
      // 중앙 정렬
      child: Container(
        color: Colors.white, // 배경색: white
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // 동일한 간격으로 위젯 배치
          children: [
            // '환영합니다! 키딩북' 텍스트
            Image.asset('assets/login/start_greeting_text.png',
                width: screenSize.width * 0.69,
                height: screenSize.height * 0.1),
            // 닉네임 입력칸
            Column(
              children: [
                Container(
                  width: screenSize.width * 0.7259,
                  height: screenSize.height * 0.0623,
                  child: TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                        hintText: '닉네임',
                        hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                        filled: true,
                        fillColor: Color(0xfff6f6f6),
                        border: OutlineInputBorder(
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
                // 닉네임 입력칸과 비밀번호 입력칸 사이의 공백
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                // 비밀번호 입력칸
                Container(
                  width: screenSize.width * 0.7259,
                  height: screenSize.height * 0.0623,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: '비밀번호',
                        hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                        filled: true,
                        fillColor: Color(0xfff6f6f6),
                        border: OutlineInputBorder(
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
                // 비밀번호 입력칸과 시작하기 버튼 사이의 여백
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                // 에러메세지
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
                // 시작하기 버튼
                Container(
                  width: screenSize.width * 0.7259,
                  height: screenSize.height * 0.0623,
                  child: IconButton(
                    onPressed: _login,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/start_btn.png'),
                  ),
                ),
                // 시작하기 버튼과 로그인 유지 버튼 사이의 여백
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                // 로그인 상태 유지 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _toggleLoginState();
                      },
                      child: Image.asset(
                        _isStayLoggedIn
                            ? 'assets/login/keep_login_selected_btn.png' // 로그인 상태 유지 활성화 이미지
                            : 'assets/login/keep_login_btn.png',
                        // 로그인 상태 유지 비활성화 이미지
                        width: 100,
                        height: 22,
                      ),
                    ),
                    // 체크박스와 '로그인 유지' 텍스트 사이의 여백
                    SizedBox(
                      width: screenSize.width * 0.02,
                    )
                  ],
                ),
                // 로그인 유지 버튼과 에러 메시지 사이의 여백
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
              ],
            ),
            // 회원가입하기 | 닉네임 찾기 | 비밀번호 찾기
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 회원가입 버튼
                Container(
                  width: screenSize.width * 0.19,
                  height: screenSize.height * 0.02,
                  child: IconButton(
                    onPressed: _signup,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/to_signup_btn.png'),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                // 구분선
                Image.asset('assets/login/vertical_line.png',
                    width: screenSize.width * 0.01,
                    height: screenSize.height * 0.02),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                // 닉네임 찾기 버튼
                Container(
                  width: screenSize.width * 0.16,
                  height: screenSize.height * 0.02,
                  child: IconButton(
                    onPressed: _findNickname,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/to_find_nickname_btn.png'),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                // 구분선
                Image.asset('assets/login/vertical_line.png',
                    width: screenSize.width * 0.01,
                    height: screenSize.height * 0.02),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                // 비밀번호 찾기 버튼
                Container(
                  width: screenSize.width * 0.2,
                  height: screenSize.height * 0.02,
                  child: IconButton(
                    onPressed: _findPassword,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/to_find_password_btn.png'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  // 로그인 유지 버튼 토글
  void _toggleLoginState() {
    setState(() {
      _isStayLoggedIn = !_isStayLoggedIn; // 상태 토글
    });
  }

  Future<void> _login() async {
    String nickname = _nicknameController.text.trim();
    String password = _passwordController.text.trim();

    try {
      var response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nickname': nickname,
          'password': password,
        }),
      );

      // 서버 응답 데이터
      var responseData = json.decode(response.body);
      print("서버 응답 데이터: $responseData"); // 서버 응답 로그 출력

      // 로그인 성공 여부를 토큰의 유무로 판단
      if (responseData['accessToken'] != null &&
          responseData['refreshToken'] != null) {
        // 로그인 상태 유지 옵션이 선택된 경우 토큰 저장
        if (_isStayLoggedIn) {
          await _storage.write(key: 'isLoggedIn', value: 'true');
          await _storage.write(key: 'nickname', value: nickname);
          await _storage.write(
              key: 'accessToken', value: responseData['accessToken']);
          await _storage.write(
              key: 'refreshToken', value: responseData['refreshToken']);
        }

        // 홈 화면으로 이동
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // 토큰이 없으면 로그인 실패 처리
        print("로그인 실패: 서버에서 토큰을 반환하지 않았습니다.");
        if (responseData['result'] == "가입된 닉네임이 아닙니다.") {
          setState(() {
            errorVisible = true; // 에러 메시지 표시
            errorMessage = "없는 닉네임입니다.";
          });
        } else {
          setState(() {
            errorVisible = true; // 에러 메시지 표시
            errorMessage = "비밀번호가 틀립니다.";
          });
        }
      }
    } catch (error) {
      // 에러가 발생한 경우, 에러 로그 출력
      print("에러 발생: $error");

      if (error is http.ClientException) {
        print("HTTP 요청 중 오류 발생: ${error.message}");
      } else if (error is FormatException) {
        print("응답 형식 오류: ${error.message}");
      } else {
        print("기타 오류: ${error.toString()}");
      }

      setState(() {
        errorVisible = true; // 에러 메시지 표시
        errorMessage = "로그인에 실패했습니다.";
      });
    }
  }

  // 로그인 유지 여부 확인
  Future<void> checkLoginStatus() async {
    String? isLoggedIn = await _storage.read(key: 'isLoggedIn');
    if (isLoggedIn != null && isLoggedIn == 'true') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // 회원가입 화면으로 이동
  void _signup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  // 닉네임 찾기 화면으로 이동
  void _findNickname() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindNicknameScreen()));
  }

  // 비밀번호 찾기 화면으로 이동
  void _findPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindPasswordScreen()));
  }
}
