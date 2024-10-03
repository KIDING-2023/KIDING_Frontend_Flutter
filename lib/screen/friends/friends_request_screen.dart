import 'package:flutter/material.dart';

import '../mypage/mypage_screen.dart';

class FriendsRequestScreen extends StatefulWidget {
  const FriendsRequestScreen({super.key});

  @override
  State<FriendsRequestScreen> createState() => _FriendsRequestScreenState();
}

class _FriendsRequestScreenState extends State<FriendsRequestScreen> {
  List<Map<String, String>> friendRequests = [
    {'name': 'OOO 친구', 'rank': '랭킹 1위'},
    {'name': 'OOO 친구', 'rank': '랭킹 3위'},
    {'name': 'OOO 친구', 'rank': '랭킹 5위'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xFFe7e7e7),
        body: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.0375,
              left: screenWidth * 0.0417,
              child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: IconButton(
                    icon: Image.asset('assets/kikisday/kikisday_back_btn.png',
                        width: screenWidth * 0.0366,
                        height: screenHeight * 0.025),
                    onPressed: () {
                      // 타이머 종료
                      Navigator.pop(context);
                    },
                  )),
            ),
            Positioned(
                top: screenHeight * 0.1106,
                left: screenWidth * 0.0831,
                child: Text(
                  '친구요청',
                  style: TextStyle(
                      fontSize: 15.79,
                      fontFamily: 'Nanum',
                      color: Colors.black),
                )),
            Positioned(
                top: screenHeight * 0.1464,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: screenHeight * 0.65,
                  child: ListView.builder(
                      itemCount: friendRequests.length,
                      itemBuilder: (context, index) {
                        return _buildFriendRequestCard(
                            friendRequests[index]['name']!,
                            friendRequests[index]['rank']!);
                      }),
                )),
            // 하단바 구분선
            Positioned(
                top: screenHeight * 0.79,
                child: Container(
                  width: screenWidth,
                  height: 0.1,
                  color: Colors.black,
                )),
            // 하단바
            Positioned(
                top: screenHeight * 0.8,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset(
                          'assets/home/ranking_unselected.png',
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.04,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Image.asset(
                          'assets/home/home_selected.png',
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.04,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Image.asset(
                          'assets/home/mypage_unselected.png',
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.04,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPageScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }

  Widget _buildFriendRequestCard(String name, String rank) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      width: screenWidth * 0.8332,
      height: screenHeight * 0.1464,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/friends/request_box.png'),
              fit: BoxFit.cover)),
      child: Stack(
        children: [
          Positioned(
              top: screenHeight * 0.0137,
              left: screenWidth * 0.0309,
              child: Image.asset(
                'assets/friends/icon.png',
                width: screenWidth * 0.20794,
                height: screenHeight * 0.0936,
              )),
          Positioned(
              top: screenHeight * 0.0393,
              left: screenWidth * 0.277,
              child: Text(
                name,
                style: TextStyle(
                    fontFamily: 'Nanum', fontSize: 17, color: Colors.black),
              )),
          Positioned(
              top: screenHeight * 0.063,
              left: screenWidth * 0.277,
              child: Text(
                rank,
                style: TextStyle(
                    fontFamily: 'Nanum',
                    fontSize: 12,
                    color: Color(0xFFb3b3b3)),
              )),
          Positioned(
              top: screenHeight * 0.1128,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/friends/reject_btn.png',
                      width: screenWidth * 0.3798,
                      height: screenHeight * 0.0335,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/friends/accept_btn.png',
                      width: screenWidth * 0.3798,
                      height: screenHeight * 0.0335,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
