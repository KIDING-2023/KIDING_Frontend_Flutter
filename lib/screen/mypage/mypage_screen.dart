import 'dart:math';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  int answerCount = 8; // 대답수 임시
  int ranking = 4; // 순위 임시
  int sameScore = 12; // 동점자수 임시

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // 상단바
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
          title: Text(
            '마이페이지',
            style: TextStyle(
              color: Colors.black, // 텍스트 색상
              fontSize: 18, // 텍스트 크기
              fontFamily: 'Nanum', // 폰트
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
        // 하단바
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: Stack(
          children: <Widget>[
            // 오늘의 랭킹
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 29.54, right: 29.54),
                child: Container(
                  width: 300.93,
                  height: 117.73,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/mypage/ranking_box_mypage.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      // 대답수
                      Positioned(
                        top: 55.11,
                        left: 37.29,
                        child: Text("대답수" + answerCount.toString() + "번",
                            style: TextStyle(
                                color: Color(0xFFFFc3a0),
                                fontSize: 25,
                                fontFamily: 'Nanum')),
                      ),
                      // 순위
                      Positioned(
                        top: 55.11,
                        right: 37.29,
                        child: Text(ranking.toString() + "위",
                            style: TextStyle(
                                color: Color(0xFFFF8a5b),
                                fontSize: 25,
                                fontFamily: 'Nanum')),
                      ),
                      // 동점자
                      Positioned(
                        top: 97.71,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            "동점자:" + sameScore.toString() + "명",
                            style: TextStyle(
                                color: Color(0xFFFFc3a0),
                                fontSize: 12,
                                fontFamily: 'Nanum'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // 나의 기록, 새로고침
            Positioned(
                top: 155.14,
                left: 39.54,
                right: 39.54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 나의 기록 텍스트
                    Image.asset('assets/mypage/my_record_text.png',
                        width: 61, height: 17),
                    // 새로고침 버튼
                    GestureDetector(
                      child: Image.asset('assets/mypage/reset_btn.png',
                          width: 15.52, height: 15.52),
                      onTap: () {},
                    )
                  ],
                )),
            // 나의 기록 아이템들
            Positioned(
                top: 177.01,
                left: 29.54,
                right: 29.54,
                child: FallingItems()
            )
          ],
        ));
  }

  BottomAppBar _buildBottomNavigationBar() {
    return BottomAppBar(
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Image.asset('assets/mypage/ranking_unselected.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('assets/mypage/home_unselected.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('assets/mypage/mypage_selected.png'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class FallingItems extends StatefulWidget {
  const FallingItems({super.key});

  @override
  State<FallingItems> createState() => _FallingItemsState();
}

class _FallingItemsState extends State<FallingItems> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rankingAnimation;
  double _topPosition = -100;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rankingAnimation = Tween<double>(begin: -100, end: 276.55).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    _controller.addListener(() {
      setState(() {
        _topPosition = _rankingAnimation.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 컨트롤러를 정지
        _controller.stop();
      }
    });

    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.93,
      height: 461.18,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/mypage/my_record_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: _topPosition,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: Transform.rotate(
              angle: pi / 4,
              child: Container(
                width: 184.63,
                height: 184.63,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/mypage/chips_bg.png'),
                    fit: BoxFit.fill
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 113.06),
                  child: Text(
                    "8개",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Nanum'
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _startAnimation,
                child: Text('Start Animation'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

