import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../model/game_provider.dart';
import '../../model/timer_model.dart';
import '../layout/exit_layout.dart';

class KikisdayRandomDice3Screen extends StatefulWidget {
  final int currentNumber;
  final int chips;

  KikisdayRandomDice3Screen(
      {Key? key, required this.currentNumber, required this.chips})
      : super(key: key);

  @override
  State<KikisdayRandomDice3Screen> createState() =>
      _KikisdayRandomDice3ScreenState();
}

class _KikisdayRandomDice3ScreenState extends State<KikisdayRandomDice3Screen> {
  late VideoPlayerController _controller;
  Future<void>? _initializeVideoPlayerFuture;

  // 주사위를 굴렸는지 여부를 나타내는 상태 변수
  bool _rolledDice = false;

  // 랜덤 주사위값
  late int randomNumber;

  // 주사위 굴린 후 넘겨줄 주사위값
  late int totalDice;

  // 다음 화면
  late var nextScreen;

  @override
  void initState() {
    super.initState();
    // 컨트롤러 초기화를 initState에서 하지 않고, 스와이프 감지 시에만 진행합니다.
  }

  void _initializeAndPlayVideo() {
    _controller = VideoPlayerController.asset(
        'assets/kikisday/kikisday_3_dice_${randomNumber}.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(_checkVideo);
      });
  }

  void _checkVideo() {
    // 현재 재생 위치와 비디오 길이가 같은지 확인
    if (_controller.value.position == _controller.value.duration) {
      _controller.removeListener(_checkVideo); // 리스너 제거
      //_controller.dispose(); // 컨트롤러 해제
      Navigator.of(context).pushNamed(nextScreen, arguments: {
        'chips': widget.chips,
      });
    }
  }

  void _pauseVideo() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
  }

  void _resumeVideo() {
    if (!_controller.value.isPlaying) {
      _controller.play();
    }
  }

  void _stopVideo() {
    _controller.removeListener(_checkVideo);
    _controller.dispose();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 현재 플레이어 순서에 따라 말풍선 텍스트 이미지 변경
    String playerNum = "";
    switch (gameProvider.currentPlayer.playerNum) {
      case 1:
        playerNum = "첫번째 순서";
        break;
      case 2:
        playerNum = "두번째 순서";
        break;
      case 3:
        playerNum = "세번째 순서";
        break;
      case 4:
        playerNum = "네번째 순서";
        break;
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_3_dice_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // FutureBuilder를 이용해 스와이프 동작이 감지되기 전과 후의 화면을 다르게 구성
          Positioned.fill(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0 && !_rolledDice) {
                  setState(() {
                    developer.log(
                        "플레이어${gameProvider.currentPlayer.playerNum}의 순서입니다.");
                    _rolledDice = true;
                    randomNumber = Random().nextInt(3) + 1;
                    gameProvider.updatePlayerPosition(randomNumber);
                    nextScreen =
                        '/kikisday${gameProvider.currentPlayer.position}'; // 주사위값에 따른 다음 화면 설정
                    developer.log(
                        "플레이어${gameProvider.currentPlayer.playerNum}의 주사위 결과: ${randomNumber}");
                    developer.log(
                        "플레이어${gameProvider.currentPlayer.playerNum}가 이동할 위치: ${gameProvider.currentPlayer.position}");
                    _initializeAndPlayVideo();
                  });
                }
              },
              child: _rolledDice && _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Stack(
                      children: <Widget>[
                        Positioned(
                          top: screenHeight * 0.39375,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset('assets/kikisday/dice_swipe.png',
                                width: screenWidth * 0.2441,
                                height: screenHeight * 0.1749),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.475,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset('assets/kikisday/dice_img3.png',
                                width: screenWidth,
                                height: screenHeight * 0.33335),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          // 주사위 텍스트 이미지
          Positioned(
            top: screenHeight * 0.1565,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/kikisday_dice_text.png',
                width: screenWidth * 0.9439, height: screenHeight * 0.212225),
          ),
          // 말풍선 안 텍스트 - 몇번째 플레이어인지
          Positioned(
            top: screenHeight * 0.225,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                playerNum,
                style: TextStyle(
                  fontFamily: 'Nanum',
                  fontSize: 15,
                  color: Color(0xff4d4d4d),
                ),
              ),
            ),
          ),
          // 뒤로 가기 버튼
          Positioned(
            top: screenHeight * 0.05625,
            left: screenWidth * 0.0417,
            right: screenWidth * 0.0833,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExitLayout(
                                  onKeepPressed: _resumeVideo,
                                  onExitPressed: _stopVideo,
                                  isFromDiceOrCamera: true,
                                  isFromCard: false,
                                )),
                      );
                    },
                    icon: Image.asset('assets/kikisday/kikisday_back_btn.png',
                        width: screenWidth * 0.0366,
                        height: screenHeight * 0.025)),
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
