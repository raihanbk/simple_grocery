import 'package:flutter/material.dart';
import 'package:simple_grocery/features/home/ui/home.dart';
import 'package:simple_grocery/features/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Home(),
    );
  }
}