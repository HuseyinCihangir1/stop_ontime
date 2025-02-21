import 'package:flutter/material.dart';

class AnimationTextControll extends StatefulWidget {
  const AnimationTextControll({super.key});

  @override
  State<AnimationTextControll> createState() => _AnimationTextControllState();
}

class _AnimationTextControllState extends State<AnimationTextControll>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  final List<String> _metinSahneleri = [
    "%",
    "%.",
    ".%.",
    ".%..",
    "..%..",
    "..%...",
    "...%..."
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      //Animas. burada başlıyo
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); //Animasyonu döngüye sokar...
    _animation = IntTween(begin: 0, end: _metinSahneleri.length - 1)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Animasyon bitiriliyor...
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final text = _metinSahneleri[_animation.value];
          return Text(
            text,
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          );
        });
  }
}
