// common_classes.dart
import 'dart:math';
import 'package:flutter/material.dart';

// Rastgele sayıları üreten NumberCircleList widget'ı
class NumberCircleList extends StatefulWidget {
  const NumberCircleList(
      {super.key, required Null Function(dynamic score) onScoreCalculated});

  @override
  _NumberCircleListState createState() => _NumberCircleListState();
}

class _NumberCircleListState extends State<NumberCircleList> {
  final List<double> numbers = List.generate(
    15,
    (index) => (Random().nextDouble() * 14 + 1)
        .toDouble(), // 1 ile 15 arasında rastgele sayılar
  );

  double _simdikiSayi = 0;

  @override
  void initState() {
    super.initState();
    randomSayiUret(); // Başlangıçta bir sayı üret
  }

  void randomSayiUret() {
    setState(() {
      _simdikiSayi = numbers[Random().nextInt(numbers.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Rastgele seçilen sayı
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            width: 85,
            height: 85,
            decoration: const BoxDecoration(
              color: Colors.cyanAccent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _simdikiSayi.toStringAsFixed(2),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    backgroundColor: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Skor hesaplamayı ve yıldızları döndüren fonksiyon
int hesaplaYildiz(double tahmin, double hedefSayi) {
  double yuvarliSimdikiSayi = double.parse(hedefSayi.toStringAsFixed(2));
  double yuvarliTahmin = double.parse(tahmin.toStringAsFixed(2));

  if (yuvarliSimdikiSayi == yuvarliTahmin) {
    return 3; // tam sayı doğru tahmin
  }

  if (yuvarliSimdikiSayi.toStringAsFixed(1) ==
      yuvarliTahmin.toStringAsFixed(1)) {
    return 2; // tam kısmı doğru tahmin
  }

  if (yuvarliSimdikiSayi.toStringAsFixed(2) ==
      yuvarliTahmin.toStringAsFixed(2)) {
    return 1; // bir ondalık kısmı doğru tahmin
  }

  return 0; // Hiçbiri doğru değil
}
