import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/core/utils/set_kikisday_card_color.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice_screen.dart';
import 'package:kiding/core/widgets/complete_layout.dart';
import 'package:provider/provider.dart';
import '../../core/constants/api_constants.dart';
import '../../model/game_provider.dart';
import '../layout/exit_layout.dart';

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class KikisdayCompleteScreen extends StatefulWidget {
  KikisdayCompleteScreen({Key? key}) : super(key: key);

  @override
  State<KikisdayCompleteScreen> createState() => _KikisdayCompleteScreenState();
}

class _KikisdayCompleteScreenState extends State<KikisdayCompleteScreen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환
  int remainingTime = 3;

  // 다음 화면
  late var nextScreen;

  @override
  void initState() {
    super.initState();
    _startTimer(remainingTime);
  }

  void _startTimer(int duration) {
    _timer = Timer(Duration(seconds: duration), _navigateToRandomDiceScreen);
  }

  void _pauseTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }

  void _resumeTimer() {
    _startTimer(remainingTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final storage = FlutterSecureStorage();

  // 서버에 키딩칩 개수를 전송하는 함수
  Future<void> _sendChipsToServer() async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.boardgameEndpoint}'); // 서버 URL
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      print("토큰이 없습니다.");
      return;
    }

    final headers = {
      'Authorization': 'Bearer $token', // 토큰을 Authorization 헤더에 포함
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'boardGameId': 1, // 고정된 보드게임 ID
      'count': 1, // 전송할 키딩칩 개수
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['isSuccess']) {
          print('서버 응답: ${data['message']}');
        } else {
          print('전송 실패: ${data['message']}');
        }
      } else {
        print('서버 오류: 상태 코드 ${response.statusCode}');
      }
    } catch (e) {
      print('네트워크 오류: $e');
    }
  }

  void _navigateToRandomDiceScreen() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int chips = arguments['chips'];

    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    gameProvider.updatePlayerChips(1);
    log("플레이어${gameProvider.currentPlayer.playerNum}의 현재 칩 수: ${gameProvider.currentPlayer.chips}");
    gameProvider.nextPlayerTurn(); // 다음 플레이어 턴으로 넘겨주기

    // // 다음 주사위 화면
    // nextScreen = setDiceScreen(
    //     position: gameProvider.currentPlayer.position, chips: chips + 1);

    // 서버에 키딩칩 개수 전송
    _sendChipsToServer();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => KikisdayRandomDiceScreen(),
        settings: RouteSettings(
          arguments: {
            'position': gameProvider.currentPlayer.position,
            'chips': chips + 1,
          },
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    _pauseTimer(); // 타이머 일시정지
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExitLayout(
          onKeepPressed: _resumeTimer,
          onExitPressed: () {},
          isFromDiceOrCamera: false,
          isFromCard: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int currentNumber = arguments['currentNumber'];

    String setBg(currentNumber) {
      if (currentNumber <= 5) {
        return 'assets/kikisday/kikisday_1_dice_bg.png';
      } else if (currentNumber > 6 && currentNumber <= 10) {
        return 'assets/kikisday/kikisday_2_dice_bg.png';
      } else if (currentNumber > 11 && currentNumber <= 15) {
        return 'assets/kikisday/kikisday_3_dice_bg.png';
      } else {
        return 'assets/kikisday/kikisday_4_dice_bg.png';
      }
    }

    return CompleteLayout(
      bgStr: setBg(currentNumber),
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr:
          'assets/kikisday/${SetKikisdayCardColor.setCardColor(currentNumber)}_complete.png',
      timerColor: Color(0xFF868686),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
