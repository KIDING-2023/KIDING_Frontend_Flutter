import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/core/services/friends_list_service.dart';
import 'package:http/http.dart' as http;

class RankingFriendsScreen extends StatefulWidget {
  final String name;

  const RankingFriendsScreen({super.key, required this.name});

  @override
  State<RankingFriendsScreen> createState() => _RankingFriendsScreenState();
}

class _RankingFriendsScreenState extends State<RankingFriendsScreen> {
  final storage = FlutterSecureStorage();
  final friendsListService = FriendsListService();

  String content = ""; // 기본 멘트
  bool isAvailable = true;

  @override
  void initState() {
    super.initState();
    content = "'${widget.name}' 친구에게\n친구 신청을 보내시겠습니까?"; // 기본 멘트 설정
    _initializeContent();
  }

  Future<void> _initializeContent() async {
    String? nickname = await storage.read(key: 'nickname'); // 본인 닉네임 읽기

    if (nickname == widget.name) {
      // 본인에게 요청 시
      setState(() {
        content = "본인입니다.";
        isAvailable = false;
      });
      return;
    }

    bool isFriend = await checkIfFriendExists();
    if (isFriend) {
      // 이미 친구인 경우
      setState(() {
        content = "'${widget.name}'친구는\n나와 이미 친구입니다.";
        isAvailable = false;
      });
      return;
    }

    setState(() {
      content = "'${widget.name}' 친구에게\n친구 신청을 보내시겠습니까?";
      isAvailable = true;
    });
  }

  Future<bool> checkIfFriendExists() async {
    List<Map<String, dynamic>> friendsList =
        await friendsListService.fetchFriendsList();
    return friendsList.any((friend) => friend['nickname'] == widget.name);
  }

  Future<void> _sendFriendsRequest() async {
    String? token = await storage.read(key: 'accessToken');
    var url = Uri.parse('${ApiConstants.baseUrl}/api/friends/request');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({'receiverNickname': widget.name});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // 요청 성공
        Navigator.of(context).pop();
      } else if (response.statusCode == 500) {
        // 서버 오류 처리
        setState(() {
          content = "이미 친구신청을 보낸 친구입니다.";
          isAvailable = false;
        });
      } else {
        print("서버 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("네트워크 오류: $e");
      setState(() {
        content = "네트워크 오류가 발생했습니다.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 93, 108),
      body: Center(
        child: Container(
          width: 300,
          height: 180,
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
                  content,
                  style: const TextStyle(
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
                      width: 136.71,
                      height: 26.76,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF838383),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '취소',
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
                      if (isAvailable) {
                        _sendFriendsRequest();
                      }
                    },
                    child: Container(
                      width: 136.71,
                      height: 26.76,
                      decoration: ShapeDecoration(
                        color: isAvailable
                            ? const Color(0xFFFF8A5B)
                            : const Color(0xFF838383),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '보내기',
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
      ),
    );
  }
}
