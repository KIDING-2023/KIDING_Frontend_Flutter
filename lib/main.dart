
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiding/model/game_provider.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_10_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_11_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_12_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_13_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_14_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_15_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_16_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_17_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_18_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_19_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_20_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_2_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_3_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_4_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_5_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_6_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_7_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_8_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_9_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_dice_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_play_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_qr_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_tutorial1_screen.dart';
import 'package:kiding/screen/kikisday/kikisday_tutorial2_screen.dart';
import 'package:kiding/screen/kikisday/set_player_number_screen.dart';
import 'package:kiding/screen/kikisday/talmud_question_2_screen.dart';
import 'package:kiding/screen/login/start_screen.dart';
import 'package:kiding/screen/mypage/mypage_screen.dart';
import 'package:kiding/screen/ranking/ranking_screen.dart';
import 'package:kiding/screen/space/space_10_screen.dart';
import 'package:kiding/screen/space/space_11_screen.dart';
import 'package:kiding/screen/space/space_12_screen.dart';
import 'package:kiding/screen/space/space_1_screen.dart';
import 'package:kiding/screen/space/space_2_screen.dart';
import 'package:kiding/screen/space/space_3_screen.dart';
import 'package:kiding/screen/space/space_4_screen.dart';
import 'package:kiding/screen/space/space_5_screen.dart';
import 'package:kiding/screen/space/space_6_screen.dart';
import 'package:kiding/screen/space/space_7_screen.dart';
import 'package:kiding/screen/space/space_8_screen.dart';
import 'package:kiding/screen/space/space_9_screen.dart';
import 'package:kiding/screen/space/space_qr_screen.dart';
import 'package:kiding/screen/space/space_random_dice_screen.dart';
import 'package:kiding/screen/space/space_tutorial1_screen.dart';
import 'package:kiding/screen/space/space_tutorial2_screen.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:provider/provider.dart';

import 'firebase_option.dart';
import 'model/timer_model.dart';

const HOME_ROUTE = '/';

void main() async {
  //dbConnector();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider( // 여러 Provider를 사용할 경우 MultiProvider 사용
      providers: [
        ChangeNotifierProvider(create: (_) => TimerModel()), // TimerModel을 Provider로 추가
        ChangeNotifierProvider(create: (_) => GameProvider()), // 플레이어 인원수
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          HOME_ROUTE: (context) => MyPageScreen(),
          '/kikisday_qr': (context) => KikisdayQrScreen(),
          '/kikisday_set_player_num': (context) => SetPlayerNumberScreen(),
          '/space_qr': (context) => SpaceQrScreen(),
          '/space_tutorial1': (context) => SpaceTutorial1Screen(),
          '/kikisday2': (context) => Kikisday2Screen(),
          '/kikisday3': (context) => Kikisday3Screen(),
          '/kikisday4': (context) => Kikisday4Screen(),
          '/kikisday5': (context) => Kikisday5Screen(),
          '/kikisday6': (context) => Kikisday6Screen(),
          '/kikisday7': (context) => Kikisday7Screen(),
          '/kikisday8': (context) => Kikisday8Screen(),
          '/kikisday9': (context) => Kikisday9Screen(),
          '/kikisday10': (context) => Kikisday10Screen(),
          '/kikisday11': (context) => Kikisday11Screen(),
          '/kikisday12': (context) => Kikisday12Screen(),
          '/kikisday13': (context) => Kikisday13Screen(),
          '/kikisday14': (context) => Kikisday14Screen(),
          '/kikisday15': (context) => Kikisday15Screen(),
          '/kikisday16': (context) => Kikisday16Screen(),
          '/kikisday17': (context) => Kikisday17Screen(),
          '/kikisday18': (context) => Kikisday18Screen(),
          '/kikisday19': (context) => Kikisday19Screen(),
          '/kikisday20': (context) => Kikisday20Screen(),
          '/space1': (context) => Space1Screen(),
          '/space2': (context) => Space2Screen(),
          '/space3': (context) => Space3Screen(),
          '/space4': (context) => Space4Screen(),
          '/space5': (context) => Space5Screen(),
          '/space6': (context) => Space6Screen(),
          '/space7': (context) => Space7Screen(),
          '/space8': (context) => Space8Screen(),
          '/space9': (context) => Space9Screen(),
          '/space10': (context) => Space10Screen(),
          '/space11': (context) => Space11Screen(),
          '/space12': (context) => Space12Screen()
        },
      ),
    ),
  );
}

// // mysql 연결
// Future<void> dbConnector() async {
//   print("Connecting to mysql server...");
//
//   // MySQL 접속 설정
//   final conn = await MySQLConnection.createConnection(
//     host: 'kiding.cjmcuiii67x9.ap-northeast-2.rds.amazonaws.com',
//     port: 3306,
//     userName: 'admin',
//     password: 'Abcd1234',
//     //databaseName: 'testdb', // optional
//   );
//
//   // 연결 대기
//   await conn.connect();
//
//   log("log: Database Connected");
//
//   // 종료 대기
//   await conn.close();
// }
