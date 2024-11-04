import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerModel with ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _formattedTime = '0:00';

  String get formattedTime => _formattedTime;

  void startTimer() {
    if (_stopwatch.isRunning) return;
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final minutes = _stopwatch.elapsed.inMinutes.remainder(60).toString();
      final seconds = _stopwatch.elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
      _formattedTime = '$minutes:$seconds';
      notifyListeners(); // 리스너에게 상태 변경을 알림
    });
  }

  void stopTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      notifyListeners();
    }
  }

  void resetTimer() {
    stopTimer();
    _stopwatch.reset();
    _formattedTime = '0:00';
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
