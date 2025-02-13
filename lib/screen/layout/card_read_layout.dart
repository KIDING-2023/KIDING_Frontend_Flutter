import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class CardReadLayout extends StatefulWidget {
  final String codeResult;
  final Color color;
  final int currentNumber;
  final int chips;

  const CardReadLayout({
    super.key,
    required this.codeResult,
    required this.color,
    required this.currentNumber,
    required this.chips,
  });

  @override
  State<CardReadLayout> createState() => _CardReadLayoutState();
}

class _CardReadLayoutState extends State<CardReadLayout> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeAndPlayAudio();
  }

  void _initializeAndPlayAudio() {
    // mp3 파일 재생용 컨트롤러 초기화
    _controller =
        VideoPlayerController.asset('assets/kikisday/${widget.codeResult}.mp3')
          ..initialize().then((_) {
            setState(() {}); // 화면을 재구성하여 오디오가 재생되도록 설정
            _controller?.play(); // 초기 재생
            _controller?.addListener(_checkAudioCompletion); // 오디오 완료 체크
          });
  }

  void _checkAudioCompletion() {
    // 오디오 재생 완료 확인
    if (_controller != null &&
        _controller!.value.position == _controller!.value.duration) {
      _controller?.removeListener(_checkAudioCompletion); // 리스너 제거
    }
  }

  void _restartAudio() {
    // 다시 듣기 기능 구현
    if (_controller != null && _controller!.value.isInitialized) {
      _controller?.seekTo(Duration.zero); // 처음부터 재생
      _controller?.play();
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_checkAudioCompletion); // 리스너 해제
    _controller?.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String game = widget.color == Color(0xFF868686) ? 'kikisday' : 'space';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$game/${widget.codeResult}.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // 뒤로가기 버튼
            Positioned(
              top: screenHeight * 0.0375,
              left: screenWidth * 0.0417,
              child: Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: IconButton(
                  icon: Image.asset(
                    'assets/kikisday/kikisday_back_btn.png',
                    width: screenWidth * 0.0366,
                    height: screenHeight * 0.025,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/kikisday${widget.currentNumber}',
                        arguments: {'chips': widget.chips});
                  },
                ),
              ),
            ),
            // 다시 듣기 버튼
            Positioned(
              top: screenHeight * 0.7243,
              left: 0,
              right: 0,
              child: Center(
                child: IconButton(
                  onPressed: _restartAudio, // 다시 듣기 기능 실행
                  icon: Image.asset(
                    'assets/kikisday/listen_again_btn.png',
                    width: screenWidth * 0.2648,
                    height: screenHeight * 0.0439,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
