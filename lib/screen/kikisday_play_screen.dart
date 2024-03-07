import 'package:flutter/material.dart';

class KikisdayPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/kikisday/kikiplay_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 30.0,
              left: 30.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context), // 홈 화면으로 돌아가기
                  child: Image.asset('assets/kikisday/back_icon.png', width: 13.16, height: 20.0),
                ),
              ),
            ),
            Positioned(
              bottom: 60.0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // 튜토리얼1로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KikisdayTutorial1Screen()),
                  );
                },
                child: Center(
                  child: Image.asset('assets/kikisday/kikiplay_btn.png', width: 300.0, height: 45.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KikisdayTutorial1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // KikisdayTutorial1Screen 위젯 구현
    return Scaffold(
      appBar: AppBar(
        title: Text('튜토리얼1'),
      ),
      body: Center(
        child: Text('Kikisday Tutorial1 내용'),
      ),
    );
  }
}