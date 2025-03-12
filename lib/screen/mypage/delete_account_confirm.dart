import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';

import 'package:http/http.dart' as http;
import 'package:kiding_frontend/screen/login/start_screen.dart';

class DeleteAccountConfirm extends StatefulWidget {
  const DeleteAccountConfirm({super.key});

  @override
  State<DeleteAccountConfirm> createState() => _DeleteAccountConfirmState();
}

class _DeleteAccountConfirmState extends State<DeleteAccountConfirm> {
  bool _isLoading = false;
  final storage = FlutterSecureStorage(); // Secure Storage 인스턴스 생성

  Future<void> _deleteAccount() async {
    setState(() {
      _isLoading = true;
    });

    String? token = await storage.read(key: 'accessToken');

    var url = Uri.parse('${ApiConstants.baseUrl}/user/delete');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        // 성공적으로 계정 탈퇴됨
        final responseData = jsonDecode(response.body);
        debugPrint('계정 탈퇴 성공: ${responseData['message']}');

        // 탈퇴 후 로그인 화면으로 이동
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => StartScreen()),
          (route) => false,
        );
      } else {
        // 실패 처리
        final responseData = jsonDecode(response.body);
        debugPrint('탈퇴 실패: ${responseData['error']}');
        _showErrorDialog('탈퇴에 실패했습니다. 다시 시도해주세요.');
      }
    } catch (error) {
      debugPrint('에러 발생: $error');
      _showErrorDialog('네트워크 오류가 발생했습니다.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
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
                  '본인 계정을 탈퇴하고\n키딩북을 떠나시겠습니까?',
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
                      _deleteAccount();
                    }, // 계정 탈퇴 로직 추가
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
                          '탈퇴하기',
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
