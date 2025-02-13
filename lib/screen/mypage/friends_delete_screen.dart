import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';

import 'package:http/http.dart' as http;
import 'package:kiding_frontend/screen/mypage/mypage_screen.dart';

class FriendsDeleteScreen extends StatefulWidget {
  final String name;

  const FriendsDeleteScreen({super.key, required this.name});

  @override
  State<FriendsDeleteScreen> createState() => _FriendsDeleteScreenState();
}

class _FriendsDeleteScreenState extends State<FriendsDeleteScreen> {
  bool _isLoading = false;
  final storage = FlutterSecureStorage(); // Secure Storage 인스턴스 생성

  Future<void> _deleteFriend() async {
    setState(() {
      _isLoading = true;
    });

    String? token = await storage.read(key: 'accessToken');

    var url = Uri.parse('${ApiConstants.baseUrl}/friends/delete');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var body = widget.name;

    try {
      final response = await http.delete(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // 성공적으로 친구 삭제함
        final responseData = jsonDecode(response.body);
        debugPrint('친구 삭제 성공: ${responseData['message']}');

        // 친구 삭제 후 마이페이지 화면으로 이동
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyPageScreen()),
          (route) => false,
        );
      } else {
        // 실패 처리
        final responseData = jsonDecode(response.body);
        debugPrint('친구 삭제 실패: ${responseData['error']}');
        _showErrorDialog('친구 삭제에 실패했습니다. 다시 시도해주세요.');
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
                  widget.name,
                  style: TextStyle(
                    fontFamily: 'Nanum',
                    fontSize: 15.sp,
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
                            fontSize: 12.sp,
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
                      _deleteFriend();
                    },
                    child: Container(
                      width: 136.71.w,
                      height: 26.76.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF883D1F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '친구 삭제하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
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
