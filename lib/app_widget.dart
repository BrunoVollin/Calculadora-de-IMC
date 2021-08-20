import 'package:flutter/material.dart';
import 'package:ola_mundo/calculadora_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: CalculadoraIMC(),
    );
  }
}
