import 'package:flutter/material.dart';
import 'package:stop_ontime/widgets/backgroundDec_widget.dart';

class GameScreen extends StatefulWidget {
  final double remainingTime;
  final double targetTime;
  final bool isFailed;

  const GameScreen({
    super.key,
    required this.remainingTime,
    required this.targetTime,
    required this.isFailed,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int stars;

  @override
  void initState() {
    super.initState();
    stars = _calculateStars(widget.remainingTime, widget.targetTime);
  }

  int _calculateStars(double remainingTime, double targetTime) {
    double difference = (remainingTime - targetTime).abs();
    if (difference == 0) {
      return 3;
    } else if (difference <= 1.0) {
      return 2;
    } else if (difference <= 3.0) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: const Text("Game Screen"),
      ),
      body: Stack(
        children: [
          const GradientBackground(child: SizedBox.expand()),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.isFailed)
                  const Text(
                    "Failed! Missed the time..",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  )
                else
                  Column(
                    children: [
                      Text(
                        "Target Time: ${widget.targetTime.toStringAsFixed(1)} sec",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Your Time: ${widget.remainingTime.toStringAsFixed(1)} sec",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Icon(
                            index < stars ? Icons.star : Icons.star_border,
                            color: Colors.yellow.shade100,
                            size: 40,
                          );
                        }),
                      ),
                    ],
                  ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 18),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text(
                    'TRY-AGAIN',
                    style: TextStyle(color: Colors.black, fontSize: 24),
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
