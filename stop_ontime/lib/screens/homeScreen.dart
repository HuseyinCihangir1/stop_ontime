import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stop_ontime/screens/gameScreen.dart';
import 'package:stop_ontime/widgets/animation1_widget.dart';
import 'package:stop_ontime/widgets/backgroundDec_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _remainingTime = 0.00; // Kronometre başlangıç süresi
  late double _targetTime; // Rastgele oluşturulan hedef süre
  late Timer _timer;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _targetTime = _generateTargetTime(); // Rastgele süreyi belirle
    _startTimer(); // Kronometreyi başlat
  }

  double _generateTargetTime() {
    return (Random().nextDouble() * 10 + 2)
        .toDouble(); // 2.0 ile 12.0 saniye arasında rastgele süre
  }

  void _startTimer() {
    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _remainingTime += 0.1; // Süreyi artır
        if (_remainingTime >= 15.0) {
          _stopTimer(forceFail: true); // 15 sn dolunca otomatik başarısız yap
        }
      });
    });
  }

  void _stopTimer({bool forceFail = false}) {
    if (_isTimerRunning) {
      _isTimerRunning = false;
      _timer.cancel();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameScreen(
            remainingTime: _remainingTime,
            targetTime: _targetTime, // Hedef süreyi GameScreen'e aktarıyoruz
            isFailed: forceFail ||
                (_remainingTime >= 15.0), // 15 sn geçtiyse başarısız kabul et
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("  ~STOPONTIME~ "),
      ),
      body: Stack(
        children: [
          const GradientBackground(child: SizedBox.expand()),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Time is started...",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  "Target Time: ${_targetTime.toStringAsFixed(1)} sec",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                ),
                const SizedBox(height: 20),
                const AnimationTextControll(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _stopTimer(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 18),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('STOP',
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
