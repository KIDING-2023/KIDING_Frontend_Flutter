// 비밀번호 찾기 - 결과 화면
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/screen/login/back_screen.dart';
import 'package:kiding_frontend/screen/login/find_nickname_screen.dart';
import 'package:kiding_frontend/screen/login/start_screen.dart';

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
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 뒤로 가기 버튼
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
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
            // '비밀번호가 재설정 되었습니다!' 텍스트
            Center(
              child: Image.asset('assets/login/password_result_text.png',
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.15),
            ),
            SizedBox(
              height: 150.h,
            ),
            Center(
              child: Container(
                width: 259.96.w,
                height: 52.47.h,
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
                        _toLoginScreen();
                      },
                      child: Container(
                        width: 121.11.w,
                        height: 43.63.h,
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
                              fontSize: 17.sp,
                              fontFamily: 'Nanum',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _toFindNicknameScreen();
                      },
                      child: Container(
                        width: 121.11.w,
                        height: 43.63.h,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFF6A2A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(31.29),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '닉네임 찾기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
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
            ),
          ],
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
