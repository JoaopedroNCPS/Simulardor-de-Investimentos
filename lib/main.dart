import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(SimuladorInvestimentosApp());
}

class SimuladorInvestimentosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Investimentos',
      home: SimuladorInvestimentos(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SimuladorInvestimentos extends StatefulWidget {
  @override
  _SimuladorInvestimentosState createState() => _SimuladorInvestimentosState();
}

class _SimuladorInvestimentosState extends State<SimuladorInvestimentos> {
  final TextEditingController _valorMensalController = TextEditingController();
  final TextEditingController _mesesController = TextEditingController();
  final TextEditingController _taxaJurosController = TextEditingController();

  void _simularInvestimento() {
    double valorMensal = double.tryParse(_valorMensalController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    double taxa = double.tryParse(_taxaJurosController.text.replaceAll('%', '')) ?? 0;

    double taxaDecimal = taxa / 100;
    double valorSemJuros = valorMensal * meses;
    double valorComJuros = valorMensal * ((pow(1 + taxaDecimal, meses) - 1) / taxaDecimal);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resultado'),
        content: Text('Valor total com juros compostos: R\$ ${valorComJuros.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF4EC),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 41, 160, 73),
        title: Text('Simulador de Investimentos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 12),
            Text('Investimento mensal:'),
            TextField(
              controller: _valorMensalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite o valor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Número de meses:'),
            TextField(
              controller: _mesesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Quantos meses deseja investir',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Taxa de juros ao mês:'),
            TextField(
              controller: _taxaJurosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite a taxa de juros',
                suffixText: '%',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 170, 71, 38),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: _simularInvestimento,
              child: Text('Simular'),
            ),
          ],
        ),
      ),
    );
  }
}
