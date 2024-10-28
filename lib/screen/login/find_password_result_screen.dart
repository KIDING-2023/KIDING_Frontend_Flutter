import 'package:flutter/material.dart';
import 'package:kiding/screen/login/start_screen.dart';
import 'find_nickname_screen.dart';

// 비밀번호 찾기 - 결과 화면
class FindPasswordResultScreen extends StatefulWidget {
  const FindPasswordResultScreen({super.key});

  @override
  State<FindPasswordResultScreen> createState() =>
      _FindPasswordResultScreenState();
}

class _FindPasswordResultScreenState extends State<FindPasswordResultScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: [
          // '비밀번호가 재설정 되었습니다!' 텍스트
          Positioned(
            top: screenSize.height * 0.125,
            left: 0,
            right: 0,
            child: Image.asset('assets/login/password_result_text.png',
                width: screenSize.width * 0.74,
                height: screenSize.height * 0.11),
          ),
          // 로그인 & 닉네임 찾기 버튼 배경
          Positioned(
            top: screenSize.height * 0.51,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/login/nickname_result_btn_bg.png',
              width: screenSize.width * 0.7,
              height: screenSize.height * 0.065,
            ),
          ),
          // 로그인하기, 닉네임 찾기 버튼 가로 배치
          Positioned(
            top: screenSize.height * 0.518,
            left: screenSize.width * 0.16,
            right: screenSize.width * 0.16,
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
                // 닉네임 찾기 버튼
                IconButton(
                  onPressed: _toFindNicknameScreen,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/password_nickname_btn.png',
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

  // 닉네임 찾기 버튼 클릭 시 닉네임 찾기 화면으로 이동
  void _toFindNicknameScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindNicknameScreen()));
  }
}
