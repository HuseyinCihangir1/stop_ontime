import 'package:flutter/material.dart';
import 'package:stop_ontime/screens/homeScreen.dart';
import 'package:stop_ontime/widgets/backgroundDec_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Menu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainMenu(), // Doğru başlangıç ekranı atanmalı
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: const Text(
          "<--HowToPlay",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        leading: IconButton(
          iconSize: 40,
          color: Colors.black,
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            // İkon tıklanınca dialog göster
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("How to play?"),
                  content: const Text(
                    "Stop the time in half of the given time.",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Tamam"),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      body: GradientBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 185),
            const Text(
              'STOPonTIME!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 75),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text(
                'START the TIME  .%.',
                style: TextStyle(color: Colors.cyanAccent, fontSize: 21),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
