import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';

class CalculadoraIMC extends StatefulWidget {
  const CalculadoraIMC({Key? key}) : super(key: key);

  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  double peso = 0.0;
  double altura = 0.0;
  double imc = 0.0;
  String situacao = "------";

  double calculaIMC(peso, altura) {
    return peso / (altura * altura);
  }

  String calculaSituacao(double imc) {
    bool naoIniciou = imc == 0;
    bool magro = imc > 0 && imc < 18.5;
    bool normal = imc >= 18.5 && imc < 25.0;
    bool sobrepeso = imc >= 25.0 && imc < 30.0;
    bool obeso = imc >= 30.0 && imc < 40.0;
    bool obesidadeGrave = imc >= 40.0;

    if (naoIniciou) return "------";
    if (magro) return "MAGREZA";
    if (normal) return "NORMAL";
    if (sobrepeso) return "SOBREPESO";
    if (obeso) return "OBESIDADE";
    if (obesidadeGrave) return "OBESIDADE GRAVE";

    return "ERRO";
  }

  lidandoComClick() {
    double newImc = calculaIMC(peso, altura);
    setState(() {
      imc = (newImc > 0) ? calculaIMC(peso, altura) : 0;
      situacao = calculaSituacao(imc);
    });
  }

  Widget get _body {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: [
                  Text(
                    "Resultado IMC: ${situacao} ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${imc.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 60),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (text) {
                      peso = double.parse(text);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Peso',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (text) {
                      altura = double.parse(text);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Altura',
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      lidandoComClick();
                    },
                    child: Text('Calcular'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan,
                      onPrimary: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/images/bg.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.white.withOpacity(0.0),
            ),
            _body,
          ],
        ));
  }
}
