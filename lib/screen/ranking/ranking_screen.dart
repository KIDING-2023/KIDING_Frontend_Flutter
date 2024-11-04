import 'package:flutter/material.dart';
import 'package:kiding/screen/mypage/mypage_screen.dart';

import '../friends/friends_request_screen.dart';
import '../home/home_screen.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  bool isSearchExpanded = false; // 검색창 확장 상태

  String username = '이혜나';  // 사용자 이름
  int chips = 18;  // 키딩칩 수

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      // 상단바
      appBar: AppBar(
        backgroundColor: Color(0xFFE9EEFC),
        elevation: 0,
        // AppBar의 그림자 제거
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: IconButton(
            icon: Image.asset(
              'assets/home/notice.png',
              width: 17.08,
              height: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendsRequestScreen()),
              );
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            '랭킹',
            style: TextStyle(
              color: Colors.black, // 텍스트 색상
              fontSize: 18, // 텍스트 크기
              fontFamily: 'Nanum', // 폰트
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10, top: 10),
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: isSearchExpanded ? screenSize.width * 0.8333 : 40,
              height: screenSize.height * 0.0563,
              decoration: BoxDecoration(
                color:
                    isSearchExpanded ? Color(0xffff8a5b) : Colors.transparent,
                borderRadius: BorderRadius.circular(27.36),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isSearchExpanded)
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                      ),
                    ),
                  Flexible(
                    child: IconButton(
                      icon: Image.asset(
                        isSearchExpanded
                            ? 'assets/home/search_icon_selected.png'
                            : 'assets/home/search.png',
                        width: 20.95,
                        height: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          isSearchExpanded = !isSearchExpanded;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: screenSize.width,
              height: screenSize.height * 0.79,
              decoration: BoxDecoration(
                color: Color(0xffE9EEFC),
              ),
              child: Stack(
                children: [
                  // 배경 선
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/ranking/bg_line.png',
                      width: screenSize.width,
                      height: screenSize.height * 0.79,
                    ),
                  ),
                  //1위
                  Positioned(
                    left: screenSize.width * 0.2028,
                    top: screenSize.height * 0.1205,
                    child: Container(
                      width: screenSize.width * 0.3922,
                      height: screenSize.height * 0.0908,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/ranking/big_container.png'),
                        fit: BoxFit.cover,
                      )),
                      child: Stack(
                        children: [
                          // 캐릭터
                          Positioned(
                            left: screenSize.width * 0.0119,
                            top: screenSize.height * 0.0045,
                            child: Image.asset(
                              'assets/ranking/big_icon_1.png',
                              width: screenSize.width * 0.1819,
                              height: screenSize.height * 0.0818,
                            ),
                          ),
                          // 이름
                          Positioned(
                            left: screenSize.width * 0.2028,
                            top: screenSize.height * 0.0274,
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Nanum',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // 키딩칩 수
                          Positioned(
                            left: screenSize.width * 0.203,
                            top: screenSize.height * 0.0549,
                            child: Text(
                              chips.toString() + '개',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Nanum',
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 플러스 버튼
                  Positioned(
                    left: screenSize.width * 0.5272,
                    top: screenSize.height * 0.11,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/ranking/plus_btn.png',
                        width: screenSize.width * 0.0556,
                        height: screenSize.height * 0.025,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  //2위
                  Positioned(
                    left: screenSize.width * 0.523,
                    top: screenSize.height * 0.2116,
                    child: Container(
                      width: screenSize.width * 0.3922,
                      height: screenSize.height * 0.0908,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/ranking/big_container.png'),
                        fit: BoxFit.cover,
                      )),
                      child: Stack(
                        children: [
                          // 캐릭터
                          Positioned(
                            left: screenSize.width * 0.0119,
                            top: screenSize.height * 0.0045,
                            child: Image.asset(
                              'assets/ranking/big_icon_2.png',
                              width: screenSize.width * 0.1819,
                              height: screenSize.height * 0.0818,
                            ),
                          ),
                          // 이름
                          Positioned(
                            left: screenSize.width * 0.2028,
                            top: screenSize.height * 0.0274,
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Nanum',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // 키딩칩 수
                          Positioned(
                            left: screenSize.width * 0.203,
                            top: screenSize.height * 0.0549,
                            child: Text(
                              chips.toString() + '개',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Nanum',
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 플러스 버튼
                  Positioned(
                    left: screenSize.width * 0.8439,
                    top: screenSize.height * 0.2013,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/ranking/plus_btn.png',
                        width: screenSize.width * 0.0556,
                        height: screenSize.height * 0.025,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  //3위
                  Positioned(
                    left: screenSize.width * 0.0865,
                    top: screenSize.height * 0.3088,
                    child: Container(
                      width: screenSize.width * 0.3922,
                      height: screenSize.height * 0.0908,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/ranking/big_container.png'),
                        fit: BoxFit.cover,
                      )),
                      child: Stack(
                        children: [
                          // 캐릭터
                          Positioned(
                            left: screenSize.width * 0.0119,
                            top: screenSize.height * 0.0045,
                            child: Image.asset(
                              'assets/ranking/big_icon_3.png',
                              width: screenSize.width * 0.1819,
                              height: screenSize.height * 0.0818,
                            ),
                          ),
                          // 이름
                          Positioned(
                            left: screenSize.width * 0.2028,
                            top: screenSize.height * 0.0274,
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Nanum',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // 키딩칩 수
                          Positioned(
                            left: screenSize.width * 0.203,
                            top: screenSize.height * 0.0549,
                            child: Text(
                              chips.toString() + '개',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Nanum',
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 플러스 버튼
                  Positioned(
                    left: screenSize.width * 0.4106,
                    top: screenSize.height * 0.2988,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/ranking/plus_btn.png',
                        width: screenSize.width * 0.0556,
                        height: screenSize.height * 0.025,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  //4위
                  Positioned(
                    left: screenSize.width * 0.3888,
                    top: screenSize.height * 0.4688,
                    child: Container(
                      width: screenSize.width * 0.3279,
                      height: screenSize.height * 0.076,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/ranking/small_container.png'),
                        fit: BoxFit.cover,
                      )),
                      child: Stack(
                        children: [
                          // 캐릭터
                          Positioned(
                            left: screenSize.width * 0.0099,
                            top: screenSize.height * 0.0038,
                            child: Image.asset(
                              'assets/ranking/small_icon_1.png',
                              width: screenSize.width * 0.1521,
                              height: screenSize.height * 0.0684,
                            ),
                          ),
                          // 이름
                          Positioned(
                            left: screenSize.width * 0.1696,
                            top: screenSize.height * 0.0223,
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 16.72,
                                fontFamily: 'Nanum',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // 키딩칩 수
                          Positioned(
                            left: screenSize.width * 0.1697,
                            top: screenSize.height * 0.0459,
                            child: Text(
                              chips.toString() + '개',
                              style: TextStyle(
                                fontSize: 10.87,
                                fontFamily: 'Nanum',
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 플러스 버튼
                  Positioned(
                    left: screenSize.width * 0.655,
                    top: screenSize.height * 0.4588,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/ranking/plus_btn.png',
                        width: screenSize.width * 0.0556,
                        height: screenSize.height * 0.025,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  //5위
                  Positioned(
                    left: screenSize.width * 0.59,
                    top: screenSize.height * 0.5814,
                    child: Container(
                      width: screenSize.width * 0.3279,
                      height: screenSize.height * 0.076,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/ranking/small_container.png'),
                        fit: BoxFit.cover,
                      )),
                      child: Stack(
                        children: [
                          // 캐릭터
                          Positioned(
                            left: screenSize.width * 0.0099,
                            top: screenSize.height * 0.0038,
                            child: Image.asset(
                              'assets/ranking/small_icon_2.png',
                              width: screenSize.width * 0.1521,
                              height: screenSize.height * 0.0684,
                            ),
                          ),
                          // 이름
                          Positioned(
                            left: screenSize.width * 0.1696,
                            top: screenSize.height * 0.0223,
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 16.72,
                                fontFamily: 'Nanum',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // 키딩칩 수
                          Positioned(
                            left: screenSize.width * 0.1697,
                            top: screenSize.height * 0.0459,
                            child: Text(
                              chips.toString() + '개',
                              style: TextStyle(
                                fontSize: 10.87,
                                fontFamily: 'Nanum',
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 플러스 버튼
                  Positioned(
                    left: screenSize.width * 0.855,
                    top: screenSize.height * 0.5713,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/ranking/plus_btn.png',
                        width: screenSize.width * 0.0556,
                        height: screenSize.height * 0.025,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  //6위
                  Positioned(
                    left: screenSize.width * 0.3349,
                    top: screenSize.height * 0.6811,
                    child: Container(
                      width: screenSize.width * 0.3279,
                      height: screenSize.height * 0.076,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/ranking/small_container.png'),
                        fit: BoxFit.cover,
                      )),
                      child: Stack(
                        children: [
                          // 캐릭터
                          Positioned(
                            left: screenSize.width * 0.0099,
                            top: screenSize.height * 0.0038,
                            child: Image.asset(
                              'assets/ranking/small_icon_3.png',
                              width: screenSize.width * 0.1521,
                              height: screenSize.height * 0.0684,
                            ),
                          ),
                          // 이름
                          Positioned(
                            left: screenSize.width * 0.1696,
                            top: screenSize.height * 0.0223,
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 16.72,
                                fontFamily: 'Nanum',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // 키딩칩 수
                          Positioned(
                            left: screenSize.width * 0.1697,
                            top: screenSize.height * 0.0459,
                            child: Text(
                              chips.toString() + '개',
                              style: TextStyle(
                                fontSize: 10.87,
                                fontFamily: 'Nanum',
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 플러스 버튼
                  Positioned(
                    left: screenSize.width * 0.5994,
                    top: screenSize.height * 0.6713,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/ranking/plus_btn.png',
                        width: screenSize.width * 0.0556,
                        height: screenSize.height * 0.025,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 하단바 구분선
          Positioned(
              top: screenSize.height * 0.79,
              child: Container(
                width: screenSize.width,
                height: 0.1,
                color: Colors.black,
              )),
          // 하단바
          Positioned(
            top: screenSize.height * 0.8,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      'assets/ranking/ranking_selected.png',
                      width: screenSize.width * 0.1,
                      height: screenSize.height * 0.04,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/mypage/home_unselected.png',
                      width: screenSize.width * 0.1,
                      height: screenSize.height * 0.04,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/home/mypage_unselected.png',
                      width: screenSize.width * 0.1,
                      height: screenSize.height * 0.04,
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
        ],
      ),
    );
  }
}
