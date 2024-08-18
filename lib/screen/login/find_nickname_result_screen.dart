import 'package:flutter/material.dart';
import 'package:kiding/screen/login/find_password_screen.dart';
import 'package:kiding/screen/login/start_screen.dart';

// 닉네임 찾기 결과 화면
class FindNicknameResultScreen extends StatefulWidget {
  final String nickname; // 닉네임 받아오기

  const FindNicknameResultScreen({super.key, required this.nickname});

  @override
  State<FindNicknameResultScreen> createState() =>
      _FindNicknameResultScreenState();
}

class _FindNicknameResultScreenState extends State<FindNicknameResultScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: [
          // '닉네임을 찾았습니다!' 텍스트
          Positioned(
            top: screenSize.height * 0.13,
            left: 0,
            right: 0,
            child: Image.asset('assets/login/nickname_result_text.png',
                width: screenSize.width * 0.74,
                height: screenSize.height * 0.11),
          ),
          // 닉네임 찾기 결과, 로그인하기 & 비밀번호 찾기 버튼
          Positioned(
            top: screenSize.height * 0.46,
            left: 0,
            right: 0,
            child: Text(
              '닉네임: ${widget.nickname}입니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'nanum', fontSize: 17, color: Colors.black),
            ),
          ),
          // 로그인 & 비밀번호 찾기 버튼 배경
          Positioned(
            top: screenSize.height * 0.51,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/login/nickname_result_btn_bg.png',
              width: screenSize.width * 0.72,
              height: screenSize.height * 0.07,
            ),
          ),
          // 로그인하기, 비밀번호 찾기 버튼 가로 배치
          Positioned(
            top: screenSize.height * 0.516,
            left: screenSize.width * 0.15,
            right: screenSize.width * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 로그인 버튼
                IconButton(
                  onPressed: _toLoginScreen,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/nickname_login_btn.png',
                      width: screenSize.width * 0.34,
                      height: screenSize.height * 0.05),
                ),
                // 비밀번호 찾기 버튼
                IconButton(
                  onPressed: _toFindPasswordScreen,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/nickname_password_btn.png',
                      width: screenSize.width * 0.34,
                      height: screenSize.height * 0.05),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // 로그인 버튼 클릭 시 로그인 화면으로 이동
  void _toLoginScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => StartScreen()));
  }

  // 비밀번호 찾기 버튼 클릭 시 비밀번호 찾기 화면으로 이동
  void _toFindPasswordScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindPasswordScreen()));
  }
}
