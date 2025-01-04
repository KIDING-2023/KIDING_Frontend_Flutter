// 닉네임 찾기 결과 화면
import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/login/back_screen.dart';
import 'package:kiding_frontend/screen/login/find_password_screen.dart';
import 'package:kiding_frontend/screen/login/start_screen.dart';

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
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 뒤로 가기 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BackScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
            ),
            // '닉네임을 찾았습니다!' 텍스트
            Center(
              child: Image.asset('assets/login/nickname_result_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.11),
            ),
            SizedBox(
              height: 150,
            ),
            // 닉네임 찾기 결과, 로그인하기 & 비밀번호 찾기 버튼
            Center(
              child: Column(
                children: [
                  Text(
                    '닉네임: \'${widget.nickname}\' 입니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'nanum', fontSize: 17, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // 로그인 & 비밀번호 찾기 버튼 배경
                  Container(
                    width: 259.96,
                    height: 52.47,
                    decoration: ShapeDecoration(
                      color: Color(0xFFEDEDED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(31.29),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StartScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 121.11,
                            height: 43.63,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF6A2A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31.29),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '로그인하기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Nanum',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FindPasswordScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 121.11,
                            height: 43.63,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF6A2A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31.29),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '비밀번호 찾기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Nanum',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
