import 'package:flutter/material.dart';
import 'package:taller2_semana2/page/home-page.dart';

void main() {
  runApp(MyCalculator());
}

class MyCalculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Calculator',
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}