import 'package:flutter/material.dart';
import 'package:kiding/core/widgets/bottom_app_bar_widget.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:kiding/screen/ranking/ranking_screen.dart';
import '../mypage/mypage_screen.dart';

class FriendsRequestScreen extends StatefulWidget {
  const FriendsRequestScreen({super.key});

  @override
  State<FriendsRequestScreen> createState() => _FriendsRequestScreenState();
}

class _FriendsRequestScreenState extends State<FriendsRequestScreen> {
  final List<Map<String, String>> friendRequests = [
    {'name': 'OOO 친구', 'rank': '랭킹 1위'},
    {'name': 'OOO 친구', 'rank': '랭킹 3위'},
    {'name': 'OOO 친구', 'rank': '랭킹 5위'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFe7e7e7),
      body: Stack(
        children: [
          // 뒤로 가기 버튼
          Positioned(
            top: screenHeight * 0.0375,
            left: screenWidth * 0.0417,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: IconButton(
                icon: Image.asset(
                  'assets/kikisday/kikisday_back_btn.png',
                  width: screenWidth * 0.0366,
                  height: screenHeight * 0.025,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          // 친구 요청 타이틀
          Positioned(
            top: screenHeight * 0.13,
            left: screenWidth * 0.0831,
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
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: SizedBox(
              height: screenHeight * 0.65,
              child: ListView.builder(
                itemCount: friendRequests.length,
                itemBuilder: (context, index) {
                  return _buildFriendRequestCard(
                    friendRequests[index]['name']!,
                    friendRequests[index]['rank']!,
                    screenWidth,
                    screenHeight,
                  );
                },
              ),
            ),
          ),
          // 하단바
          BottomAppBarWidget(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            screen: "home",
            topPosition: screenHeight * 0.91,
            hasAppBar: false,
          ),
        ],
      ),
    );
  }

  Widget _buildFriendRequestCard(
      String name, String rank, double screenWidth, double screenHeight) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 30),
      width: screenWidth * 0.8332,
      height: screenHeight * 0.1602,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/friends/request_box.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.0137,
            left: screenWidth * 0.0309,
            child: Image.asset(
              'assets/friends/icon.png',
              width: screenWidth * 0.20794,
              height: screenHeight * 0.0936,
            ),
          ),
          Positioned(
            top: screenHeight * 0.03,
            left: screenWidth * 0.277,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'Nanum',
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.063,
            left: screenWidth * 0.277,
            child: Text(
              rank,
              style: const TextStyle(
                fontFamily: 'Nanum',
                fontSize: 12,
                color: Color(0xFFb3b3b3),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/friends/reject_btn.png',
                    width: screenWidth * 0.35,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/friends/accept_btn.png',
                    width: screenWidth * 0.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
