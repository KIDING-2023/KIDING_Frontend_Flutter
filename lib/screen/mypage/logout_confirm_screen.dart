import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/screen/login/start_screen.dart';

class LogoutConfirmScreen extends StatefulWidget {
  const LogoutConfirmScreen({super.key});

  @override
  State<LogoutConfirmScreen> createState() => _LogoutConfirmState();
}

class _LogoutConfirmState extends State<LogoutConfirmScreen> {
  // final bool _isLoading = false;
  final storage = FlutterSecureStorage(); // Secure Storage 인스턴스 생성

  Future<void> _clearStoredTokens() async {
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
    await storage.delete(key: 'isLoggedIn');
    debugPrint("저장된 토큰 삭제 완료");
  }

  Future<void> logout() async {
    await _clearStoredTokens();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => StartScreen()));
    debugPrint("로그아웃 완료");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 93, 108),
      body: Center(
        child: Container(
          width: 300.w,
          height: 180.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: const AssetImage('assets/ranking/friends_icon.png'),
                width: screenWidth * 0.1819,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  '키딩북에서\n로그아웃하시겠습니까?',
                  style: TextStyle(
                    fontFamily: 'Nanum',
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 136.71.w,
                      height: 26.76.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF838383),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w800,
                            height: 1.40.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      logout();
                    },
                    child: Container(
                      width: 136.71.w,
                      height: 26.76.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF8A5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '로그아웃하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w800,
                            height: 1.40.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
