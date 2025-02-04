import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/core/widgets/bottom_app_bar_widget.dart';

import 'package:http/http.dart' as http;

class FriendsRequestScreen extends StatefulWidget {
  const FriendsRequestScreen({super.key});

  @override
  State<FriendsRequestScreen> createState() => _FriendsRequestScreenState();
}

class _FriendsRequestScreenState extends State<FriendsRequestScreen> {
  final storage = FlutterSecureStorage();

  List<Map<String, dynamic>> friendRequests = []; // 닉네임, 순위, 프로필 사진 포함

  @override
  void initState() {
    super.initState();
    fetchFriendRequests(); // 초기화 시 친구 요청 목록 가져오기
  }

  // 서버에서 친구 요청 목록 가져오기
  Future<void> fetchFriendRequests() async {
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.parse('${ApiConstants.baseUrl}/api/friends/request-box');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}'); // 서버 응답 출력

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['isSuccess']) {
          // 요청 성공 시 데이터 업데이트
          setState(() {
            friendRequests = List<Map<String, dynamic>>.from(
                data['result'].map((request) => {
                      "name": request['senderNickname'],
                      "rank": request['senderRank'].toString(),
                      "profileImage": request['senderProfile'],
                    }));
          });
        } else {
          _showDialog(context, "오류", data['message']);
        }
      } else {
        _showDialog(context, "오류", "서버 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("네트워크 오류: $e");
      _showDialog(context, "오류", "네트워크 오류가 발생했습니다.");
    }
  }

  // 친구 요청 수락/거절
  Future<void> handleFriendRequest({
    required String senderNickname,
    required bool isAccepted,
    required BuildContext context,
  }) async {
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.parse('${ApiConstants.baseUrl}/api/friends/respond');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      'senderNickname': senderNickname,
      'isAccepted': isAccepted,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        String message = isAccepted ? "친구 요청을 수락했습니다." : "친구 요청을 거절했습니다.";
        _showDialog(context, "알림", message);
      } else {
        _showDialog(context, "오류", "서버 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("네트워크 오류: $e");
      _showDialog(context, "오류", "네트워크 오류가 발생했습니다.");
    }
  }

  // 다이얼로그 표시
  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFe7e7e7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 뒤로 가기 버튼
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 50),
                child: IconButton(
                  icon: Image.asset(
                    'assets/kikisday/kikisday_back_btn.png',
                    width: screenWidth * 0.0366,
                    height: screenHeight * 0.025,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // 친구 요청 타이틀
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: const Text(
                  '친구요청',
                  style: TextStyle(
                    fontSize: 15.79,
                    fontFamily: 'Nanum',
                    color: Colors.black,
                  ),
                ),
              ),
              // 친구 요청 목록
              if (friendRequests.isEmpty == false)
                SizedBox(
                  height: screenHeight * 0.65,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: List.generate(
                        friendRequests.length,
                        (index) {
                          return _buildFriendRequestCard(
                            friendRequests[index]['name']!,
                            friendRequests[index]['rank']!,
                            friendRequests[index]['profileImage'],
                            screenWidth,
                            screenHeight,
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // 하단바
          BottomAppBarWidget(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            screen: "home",
            hasAppBar: false,
          ),
        ],
      ),
    );
  }

  Widget _buildFriendRequestCard(String name, String rank, String? profileImage,
      double screenWidth, double screenHeight) {
    return Center(
      child: Container(
        width: screenWidth - 60,
        height: 128.18,
        padding: EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: profileImage != null
                      ? NetworkImage(profileImage)
                      : AssetImage('assets/ranking/small_icon_1.png'),
                  radius: 35, // 프로필 이미지 크기
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          '$name 친구',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w800,
                            height: 0.99,
                          ),
                        ),
                      ),
                      Text(
                        '랭킹 $rank위',
                        style: TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 12,
                          fontFamily: 'Nanum',
                          fontWeight: FontWeight.w800,
                          height: 1.40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    handleFriendRequest(
                      senderNickname: name,
                      isAccepted: false,
                      context: context,
                    );
                  },
                  child: Container(
                    height: 26.76,
                    padding: EdgeInsets.symmetric(horizontal: 52),
                    decoration: ShapeDecoration(
                      color: Color(0xFF838383),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.38),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '거절하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Nanum',
                          fontWeight: FontWeight.w800,
                          height: 1.40,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleFriendRequest(
                      senderNickname: name,
                      isAccepted: true,
                      context: context,
                    );
                  },
                  child: Container(
                    height: 26.76,
                    padding: EdgeInsets.symmetric(horizontal: 52),
                    decoration: ShapeDecoration(
                      color: Color(0xFFFF8A5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.38),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '수락하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Nanum',
                          fontWeight: FontWeight.w800,
                          height: 1.40,
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
    );
  }
}
