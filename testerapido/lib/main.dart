import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Aplicativo Divide Conta",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tValorTotal = TextEditingController();
  final _tNumPessoas = TextEditingController();
  double numPorcentagemGarcon = 10;
  var porcentagemText = "Porcentagem do Garçon";
  var infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Divide Conta"),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Valor total"),
              controller: _tValorTotal,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Numero de pessoas"),
              controller: _tNumPessoas,
            ),
            Text(
              porcentagemText,
              textAlign: TextAlign.left
            ),
            Slider(
              value: numPorcentagemGarcon,
              max: 100,
              divisions: 20,
              label: numPorcentagemGarcon.round().toString(),
              onChanged: (double value) {
                setState(() {
                  numPorcentagemGarcon = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: calcular,
              child: const Text("Dividir Conta"),
            ),
            Text(
              infoText,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  calcular() {
    setState(() {
      double total = double.parse(_tValorTotal.text);
      int numPessoas = int.parse(_tNumPessoas.text);
      int porcentagemGarcon = numPorcentagemGarcon.toInt();

      double valorTotalIndividual = (total/numPessoas)*(1+(porcentagemGarcon/100));
      double valorDoGarcon = valorTotalIndividual - (total/numPessoas);
      double valorIndividual = total/numPessoas;

      infoText = "Valor Total Por Pessoa: R\$" + valorTotalIndividual.toStringAsFixed(2) +
      "\nConta: R\$" + valorIndividual.toStringAsFixed(2) + " + " + porcentagemGarcon.toString() + "%(R\$" + valorDoGarcon.toStringAsFixed(2) + ")";

    });
  }
}