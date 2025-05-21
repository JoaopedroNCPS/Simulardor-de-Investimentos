import 'package:flutter/material.dart';

void main() {
  runApp(const AvaliacaoIMCApp());
}

class AvaliacaoIMCApp extends StatelessWidget {
  const AvaliacaoIMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avaliador de IMC',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const IMCCalculatorScreen(),
    );
  }
}

class IMCCalculatorScreen extends StatefulWidget {
  const IMCCalculatorScreen({super.key});

  @override
  State<IMCCalculatorScreen> createState() => _IMCCalculatorScreenState();
}

class _IMCCalculatorScreenState extends State<IMCCalculatorScreen> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  void calcularIMC() {
    final double? peso = double.tryParse(pesoController.text);
    final double? altura = double.tryParse(alturaController.text);

    if (peso == null || altura == null || altura == 0) {
      showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          title: Text('Erro'),
          content: Text('Por favor, preencha corretamente os campos.'),
        ),
      );
      return;
    }

    final double imc = peso / (altura * altura);
    String classificacao;

    if (imc < 18.5) {
      classificacao = 'Abaixo do peso';
    } else if (imc < 24.9) {
      classificacao = 'Peso normal';
    } else if (imc < 29.9) {
      classificacao = 'Sobrepeso';
    } else if (imc < 34.9) {
      classificacao = 'Obesidade grau 1';
    } else if (imc < 39.9) {
      classificacao = 'Obesidade grau 2';
    } else {
      classificacao = 'Obesidade grau 3';
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Resultado do IMC'),
        content: Text('IMC: ${imc.toStringAsFixed(2)}\nClassificação: $classificacao'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Peso (kg):', style: TextStyle(fontSize: 18)),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Ex: 70'),
            ),
            const SizedBox(height: 20),
            const Text('Altura (m):', style: TextStyle(fontSize: 18)),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Ex: 1.75'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: calcularIMC,
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
