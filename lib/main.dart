import 'package:flutter/material.dart';
import 'package:kiding/screen/login/login_screen.dart';
import 'package:provider/provider.dart';

import 'model/timer_model.dart';

void main() {
  runApp(
    MultiProvider( // 여러 Provider를 사용할 경우 MultiProvider 사용
      providers: [
        ChangeNotifierProvider(create: (_) => TimerModel()), // TimerModel을 Provider로 추가
        // 필요한 다른 Provider들도 여기에 추가할 수 있습니다.
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    ),
  );
}
