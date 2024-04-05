import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_song_screen.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../model/timer_model.dart';

class KikisdayDiceScreen extends StatefulWidget {
  @override
  _KikisdayDiceScreenState createState() => _KikisdayDiceScreenState();
}

class _KikisdayDiceScreenState extends State<KikisdayDiceScreen> {
  late VideoPlayerController _controller;
  // 주사위를 굴렸는지 여부를 나타내는 상태 변수
  bool _rolledDice = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_dice_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // 스와이프 제스처 감지
          Positioned.fill(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0 && !_rolledDice) {
                  // 스와이프 감지 및 상태 업데이트
                  _controller = VideoPlayerController.asset(
                      'assets/kikisday/dice1_video.mp4')
                    ..initialize().then((_) {
                      setState(() {});
                      _controller.play();
                    });
                  _rolledDice = true;
                  // 비디오 재생 완료 체크 및 다음 화면으로 전환
                  _controller.addListener(() {
                    // 현재 재생 위치가 비디오 길이와 같은지 확인
                    if (_controller.value.position ==
                        _controller.value.duration) {
                      // 재생이 완료되었다면 다음 화면으로 전환
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KikisdaySongScreen()),
                      );
                      _controller.dispose(); // 리소스 해제
                      // 상태 업데이트
                      setState(() {
                        _rolledDice = false;
                      });
                    }
                  });
                  // // GIF 재생 시간 후 다음 화면으로 자동 전환
                  // Future.delayed(Duration(seconds: 4), () {
                  //   // 여기에 다음 화면으로 넘어가는 코드를 작성하세요.
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => KikisdaySongScreen()),
                  //   );
                  //   // 상태 업데이트
                  //   setState(() {
                  //     _rolledDice = false;
                  //   });
                  // });
                }
              },
            ),
          ),
          // 주사위 GIF 애니메이션 (스와이프 후 전체 화면)
          Positioned.fill(
            child: _rolledDice
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : Container(),
          ),
          // // 주사위 GIF 애니메이션 (스와이프 후 전체 화면)
          // if (_rolledDice)
          //   Positioned.fill(
          //     child: Image.asset(
          //       'assets/kikisday/dice1.gif', // 주사위 굴리는 GIF
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // 주사위 텍스트 이미지
          Positioned(
            top: 125.22,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/kikisday_dice_text.png',
                width: 339.79, height: 169.78),
          ),
          // 주사위 스와이프 이미지
          if (!_rolledDice)
            Positioned(
              top: 315, // imageView2 아래 적절한 위치 조정
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset('assets/kikisday/dice_swipe.png',
                    width: 87.87, height: 139.91),
              ),
            ),
          if (!_rolledDice)
            Positioned(
              top: 380, // 스와이프 이미지 아래 적절한 위치 조정
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset('assets/kikisday/dice_img3.png',
                    width: 360, height: 266.68),
              ),
            ),
          // 뒤로 가기 버튼
          Positioned(
            top: 45,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('assets/kikisday/kikisday_back_btn.png',
                      width: 13.16, height: 20.0),
                ),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: Color(0xFF868686),
                    ),
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
