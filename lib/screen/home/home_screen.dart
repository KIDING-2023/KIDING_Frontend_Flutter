import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_play_screen.dart';
import 'package:kiding/screen/ranking/ranking_screen.dart';

import '../mypage/mypage_screen.dart';
import '../space/space_play_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _index = 0; // 기본으로 홈이 선택된 상태
  // Initialize selected index to 'Main'
  int _selectedSortIndex = 0;
  bool _kikiStar = false;
  bool _spaceStar = false;
  String kikiStarImage = 'unselected_star.png';
  String spaceStarImage = 'unselected_star.png';

  List<Widget> _pages = [
    HomeScreen(),
    MyPageScreen(),
    RankingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경색을 흰색으로 설정
        elevation: 0, // AppBar의 그림자 제거
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: IconButton(
            icon: Image.asset(
              'assets/home/menu.png',
              width: 21.65,
              height: 20,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10, top: 10), // 검색 아이콘의 위치 조정
            child: IconButton(
              icon: Image.asset(
                'assets/home/search.png',
                width: 20.95,
                height: 20,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 하단바
          Positioned(
              bottom: 75,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 0.1,
                color: Colors.black,
              )),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      'assets/home/ranking_unselected.png',
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/home/home_selected.png',
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/home/mypage_unselected.png',
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPageScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // 바디
          Positioned(
            top: 0,
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                      child: Image.asset('assets/home/home_title.png',
                          width: 192.35, height: 52.02),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 28.35),
                      child: Row(
                        children: <Widget>[
                          _buildSortOption('메인', 0),
                          _buildSortOption('인기순', 1),
                          _buildSortOption('최근순', 2),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: <Widget>[
                          _buildMainSortSection(),
                        ],
                      ),
                    ),
                    // Ranking box placeholder
                    Padding(
                      padding: const EdgeInsets.only(top: 37.18, bottom: 30),
                      child: Center(
                        child: Container(
                          width: 310,
                          height: 111,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/home/ranking_box.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                right: 17.02,
                                top: 19.08,
                                child: Image.asset('assets/home/plus.png',
                                    width: 19.98, height: 19.98),
                              ),
                              Positioned(
                                right: 22.89,
                                bottom: 19.89,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("00",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.96,
                                            fontFamily: 'Nanum')),
                                    Text("번",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18.96,
                                            fontFamily: 'Nanum')),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 5.0 + 22.89 + 48, // '00번' 텍스트와의 간격을 조정
                                bottom: 19.89,
                                child: Text("이용자",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.96,
                                        fontFamily: 'Nanum')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(String title, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSortIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 25.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/home/eclipse.png',
              width: 6.35,
              height: 6.35,
              color: _selectedSortIndex == index
                  ? Colors.orange
                  : Colors.transparent,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                color: _selectedSortIndex == index
                    ? Colors.black
                    : Color(0xFF75777E),
                fontSize: 14.22,
                fontFamily: 'Nanum',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSortSection() {
    return Container(
      height: 317.79,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white.withOpacity(1.0), // 왼쪽의 불투명한 흰색
              Colors.white.withOpacity(0.0), // 중앙의 투명한 흰색
              Colors.white.withOpacity(0.0), // 중앙의 투명한 흰색
              Colors.white.withOpacity(1.0), // 오른쪽의 불투명한 흰색
            ],
            stops: [0.0, 0.15, 0.85, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstOut, // 그라데이션 효과를 합성하는 방식
        child: ListView(
          padding: EdgeInsets.only(right: 30),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _buildKikisdayCard(),
            _buildSpaceCard(),
            // 추가 카드를 이곳에 배치
          ],
        ),
      ),
    );
  }

  Widget _buildKikisdayCard() {
    return GestureDetector(
      onTap: () {
        print('kikisday card tapped');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KikisdayPlayScreen()),
        );
      },
      child: Container(
        width: 231.11,
        margin: EdgeInsets.only(left: 30),
        child: Stack(
          children: <Widget>[
            Image.asset('assets/home/kikisday_card.png', fit: BoxFit.cover),
            // 박스 이미지
            Positioned(
              // '플레이 00명' 텍스트 위치 조정
              left: 20, // 이미지의 좌측으로부터의 거리
              top: 13.18, // 이미지의 상단으로부터의 거리
              child: Row(
                children: <Widget>[
                  Text('플레이 ',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                  Text('00',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                  Text('명',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                ],
              ),
            ),
            // 즐겨찾기 버튼
            Positioned(
                right: 15,
                top: 13.18,
                child: GestureDetector(
                    onTap: () {
                      if (!_kikiStar) {
                        setState(() {
                          _kikiStar = true;
                          kikiStarImage = 'selected_star.png';
                        });
                      } else {
                        setState(() {
                          _kikiStar = false;
                          kikiStarImage = 'unselected_star.png';
                        });
                      }
                    },
                    child: Image.asset('assets/home/$kikiStarImage',
                        width: 19.79, height: 19.79)))
          ],
        ),
      ),
    );
  }

  Widget _buildSpaceCard() {
    return GestureDetector(
      onTap: () {
        print('space card tapped');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SpacePlayScreen()),
        );
      },
      child: Container(
        width: 231.11,
        margin: EdgeInsets.only(left: 30),
        child: Stack(
          children: <Widget>[
            Image.asset('assets/home/space_card.png', fit: BoxFit.cover),
            // 박스 이미지
            Positioned(
              // '플레이 00명' 텍스트 위치 조정
              left: 20, // 이미지의 좌측으로부터의 거리
              top: 13.18, // 이미지의 상단으로부터의 거리
              child: Row(
                children: <Widget>[
                  Text('플레이 ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                  Text('00',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                  Text('명',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                ],
              ),
            ),
            // 즐겨찾기 버튼
            Positioned(
                right: 15,
                top: 13.18,
                child: GestureDetector(
                    onTap: () {
                      if (!_spaceStar) {
                        setState(() {
                          _spaceStar = true;
                          spaceStarImage = 'selected_star.png';
                        });
                      } else {
                        setState(() {
                          _spaceStar = false;
                          spaceStarImage = 'unselected_star.png';
                        });
                      }
                    },
                    child: Image.asset('assets/home/$spaceStarImage',
                        width: 19.79, height: 19.79)))
          ],
        ),
      ),
    );
  }

// Widget _buildCard(String imageName, String userCountText, Color textColor) {
//   return GestureDetector(
//     onTap: () {
//       print('$imageName card tapped');
//       // 여기에서 Navigator.push를 사용하여 새로운 화면으로 이동
//       if ('$imageName' == 'kikisday_card.png') {
//         // kikisday_play_screen으로 이동
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => KikisdayPlayScreen()),
//         );
//       } else {
//         // space_play_screen으로 이동
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SpacePlayScreen()),
//         );
//       }
//     },
//     child: Container(
//       width: 231.11,
//       margin: EdgeInsets.only(left: 30),
//       child: Stack(
//         children: <Widget>[
//           Image.asset('assets/home/$imageName', fit: BoxFit.cover), // 박스 이미지
//           Positioned(
//             // '플레이 00명' 텍스트 위치 조정
//             left: 20, // 이미지의 좌측으로부터의 거리
//             top: 13.18, // 이미지의 상단으로부터의 거리
//             child: Row(
//               children: <Widget>[
//                 Text('플레이 ',
//                     style: TextStyle(
//                         color: textColor,
//                         fontSize: 11.38,
//                         fontFamily: 'Nanum')),
//                 Text('00',
//                     style: TextStyle(
//                         color: textColor,
//                         fontSize: 11.38,
//                         fontFamily: 'Nanum')),
//                 Text('명',
//                     style: TextStyle(
//                         color: textColor,
//                         fontSize: 11.38,
//                         fontFamily: 'Nanum')),
//               ],
//             ),
//           ),
//           // 즐겨찾기 버튼
//           Positioned(
//             right: 15,
//             top: 13.18,
//             child: GestureDetector(
//               onTap: () {
//                 if ('$imageName' == 'kikisday_card.png') {
//                   if (!_kikiStar) {
//                     setState(() {
//                       _kikiStar = true;
//                       kikiStarImage = 'selected_star.png';
//                     });
//                   } else {
//                     setState(() {
//                       _kikiStar = false;
//                       kikiStarImage = 'unselected_star.png';
//                     });
//                   }
//                 } else {
//                   if (!_spaceStar) {
//                     setState(() {
//                       _spaceStar = true;
//                       SpaceStarImage = 'selected_star.png';
//                     });
//                   } else {
//                     setState(() {
//                       _spaceStar = false;
//                       SpaceStarImage = 'unselected_star.png';
//                     });
//                   }
//                 }
//               },
//               child: Image.asset('assets/home/$starImage', width: 19.79, height: 19.79)
//             )
//           )
//         ],
//       ),
//     ),
//   );
// }
}
