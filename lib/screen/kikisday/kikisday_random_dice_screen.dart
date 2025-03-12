import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/core/utils/set_kikisday_card_color.dart';
import 'package:kiding_frontend/model/game_provider.dart';
import 'package:kiding_frontend/model/timer_mode.dart';
import 'package:kiding_frontend/screen/layout/exit_layout.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'dart:developer' as developer;

class KikisdayRandomDiceScreen extends StatefulWidget {
  const KikisdayRandomDiceScreen({super.key});

  @override
  State<KikisdayRandomDiceScreen> createState() =>
      _KikisdayRandomDiceScreenState();
}

class _KikisdayRandomDiceScreenState extends State<KikisdayRandomDiceScreen> {
  VideoPlayerController? _controller;

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
  }

  void _initializeAndPlayVideo() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int position = arguments['position'];

    int setVideo(position) {
      if (position <= 4) {
        return 1;
      } else if (position >= 5 && position <= 9) {
        return 2;
      } else if (position >= 10 && position <= 14) {
        return 3;
      } else {
        return 4;
      }
    }

    _controller = VideoPlayerController.asset(
        'assets/kikisday/kikisday_${setVideo(position)}_dice_$randomNumber.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller?.play();
        _controller?.addListener(_checkVideo);
      });
  }

  void _checkVideo() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int chips = arguments['chips'];

    int setBg(int nextScreen) {
      if (nextScreen <= 5) {
        return 1;
      } else if (nextScreen >= 6 && nextScreen <= 10) {
        return 2;
      } else if (nextScreen >= 11 && nextScreen <= 15) {
        return 3;
      } else {
        return 4;
      }
    }

    // 현재 재생 위치와 비디오 길이가 같은지 확인
    if (_controller?.value.position == _controller?.value.duration) {
      _controller?.removeListener(_checkVideo); // 리스너 제거

      // nextScreen이 FinishScreen일 경우 타이머를 종료
      if (nextScreen == 21) {
        Provider.of<TimerModel>(context, listen: false).resetTimer();
        Navigator.pushNamed(context, '/kikisday_finish', arguments: {
          'chips': chips,
        });
      } else {
        Navigator.pushNamed(context, '/kikisdayScreen', arguments: {
          'bgStr': 'assets/kikisday/kikisday_${setBg(nextScreen)}_bg.png',
          'backBtnStr': 'assets/kikisday/kikisday_back_btn.png',
          'textStr': 'assets/kikisday/kikisday_${nextScreen}_text.png',
          'cardStr':
              'assets/kikisday/kikisday_${SetKikisdayCardColor.setCardColor(nextScreen)}_card.png',
          'okBtnStr':
              'assets/kikisday/kikisday_${SetKikisdayCardColor.setCardColor(nextScreen)}_btn.png',
          'timerColor': const Color(0xFF868686),
          'currentNumber': nextScreen,
          'chips': chips,
        });
      }
    }
  }

  void _resumeVideo() {
    _controller?.play();
  }

  void _stopVideo() {
    _controller?.removeListener(_checkVideo);
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int position = arguments['position'];

    int setBg(position) {
      if (position <= 4) {
        return 1;
      } else if (position >= 5 && position <= 9) {
        return 2;
      } else if (position >= 10 && position <= 14) {
        return 3;
      } else {
        return 4;
      }
    }

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
              'assets/kikisday/kikisday_${setBg(position)}_dice_bg.png',
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
                    if (gameProvider.currentPlayer.position == 0) {
                      randomNumber = Random().nextInt(2) + 2;
                    } else {
                      randomNumber = Random().nextInt(3) + 1;
                    }
                    totalDice =
                        gameProvider.currentPlayer.position + randomNumber;
                    gameProvider.updatePlayerPosition(randomNumber);
                    if (totalDice >= 21) {
                      nextScreen = 21;
                    } else {
                      nextScreen = totalDice;
                    }
                    developer.log(
                        "플레이어${gameProvider.currentPlayer.playerNum}의 주사위 결과: $randomNumber");
                    developer.log(
                        "플레이어${gameProvider.currentPlayer.playerNum}가 이동할 위치: ${gameProvider.currentPlayer.position}");
                    _initializeAndPlayVideo();
                  });
                }
              },
              child: _rolledDice && _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
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
          // 주사위 텍스트
          Positioned(
            top: screenHeight * 0.156525,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  'assets/space/speaker_icon.png',
                  width: 39.72.w,
                  height: 47.68.h,
                ),
                Container(
                  width: 100.88.w,
                  height: 30.98.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.49),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      playerNum,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4D4D4D),
                        fontSize: 15,
                        fontFamily: 'Nanum',
                        fontWeight: FontWeight.w800,
                        height: 1.53.h,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/kikisday/dice_text_black.png',
                  width: 270.w,
                  height: 80.h,
                ),
              ],
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
                      fontSize: 15.sp,
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
