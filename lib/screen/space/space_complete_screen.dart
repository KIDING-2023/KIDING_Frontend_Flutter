import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/core/widgets/complete_layout.dart';
import 'package:kiding_frontend/model/game_provider.dart';
import 'package:kiding_frontend/screen/layout/exit_layout.dart';
import 'package:kiding_frontend/screen/space/space_random_dice_screen.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class SpaceCompleteScreen extends StatefulWidget {
  const SpaceCompleteScreen({super.key});

  @override
  State<SpaceCompleteScreen> createState() => _SpaceCompleteScreenState();
}

class _SpaceCompleteScreenState extends State<SpaceCompleteScreen> {
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

    final headers = {
      'Authorization': 'Bearer $token', // 토큰을 Authorization 헤더에 포함
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'boardGameId': 2, // 고정된 보드게임 ID
      'count': 1, // 전송할 키딩칩 개수
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['isSuccess']) {
          debugPrint('서버 응답: ${data['message']}');
        } else {
          debugPrint('전송 실패: ${data['message']}');
        }
      } else {
        debugPrint('서버 오류: 상태 코드 ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('네트워크 오류: $e');
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

    // 서버에 키딩칩 개수 전송
    _sendChipsToServer();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SpaceRandomDiceScreen(),
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
    _timer.cancel(); // 타이머 취소
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExitLayout(
                onKeepPressed: _resumeTimer,
                onExitPressed: () {},
                isFromDiceOrCamera: false,
                isFromCard: false,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int currentNumber = arguments['currentNumber'];

    String setBg(currentNumber) {
      if (currentNumber <= 3) {
        return 'earth';
      } else if (currentNumber >= 4 && currentNumber <= 6) {
        return 'venus';
      } else if (currentNumber >= 7 && currentNumber <= 9) {
        return 'mars';
      } else {
        return 'saturn';
      }
    }

    return CompleteLayout(
      bgStr: 'assets/space/${setBg(currentNumber)}_dice_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      completeStr: 'assets/space/${setBg(currentNumber)}_complete_text.png',
      timerColor: Color(0xFFE7E7E7),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
