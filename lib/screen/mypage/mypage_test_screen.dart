import 'package:flutter/material.dart';

class MyPageTestScreen extends StatefulWidget {
  const MyPageTestScreen({super.key});

  @override
  State<MyPageTestScreen> createState() => _MyPageTestScreenState();
}

class _MyPageTestScreenState extends State<MyPageTestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _topPosition = -100;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: -100, end: 600).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    _controller.addListener(() {
      setState(() {
        _topPosition = _animation.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 컨트롤러를 정지
        _controller.stop();
      }
    });

    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _topPosition,
          left: MediaQuery.of(context).size.width / 2 - 25,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.blue,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _startAnimation,
                  child: Text('Start Animation'),
                ),
                ElevatedButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
