import 'package:flutter/material.dart';
import 'package:kiding_frontend/core/widgets/bottom_app_bar_widget.dart';

class FriendsRequestScreen extends StatefulWidget {
  const FriendsRequestScreen({super.key});

  @override
  State<FriendsRequestScreen> createState() => _FriendsRequestScreenState();
}

class _FriendsRequestScreenState extends State<FriendsRequestScreen> {
  final List<Map<String, String>> friendRequests = [
    {
      "name": "키딩",
      "rank": '1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFe7e7e7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 뒤로 가기 버튼
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
              SizedBox(
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
            ],
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
    return Center(
      child: Container(
        width: 299.95,
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
                Image.asset(
                  'assets/friends/icon.png',
                  width: 74.86,
                  height: 74.86,
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
                Container(
                  width: 136.71,
                  height: 26.76,
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
                Container(
                  width: 136.71,
                  height: 26.76,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
