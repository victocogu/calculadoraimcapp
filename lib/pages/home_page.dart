import 'package:calculadoraimcapp/model/imc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/widgets/text_label.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController pesoController = TextEditingController(text: "");
  TextEditingController alturaController = TextEditingController(text: "");
  var _imc = <Imc>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Calculador IMC")),
        body: Column(children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Expanded(flex: 1, child: TextLabel(texto: "Peso:")),
              Expanded(
                flex: 2,
                child: TextField(
                    controller: pesoController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ]),
              ),
              const SizedBox(
                width: 30,
              ),
              const Expanded(flex: 1, child: TextLabel(texto: "Altura:")),
              Expanded(
                flex: 2,
                child: TextField(
                    controller: alturaController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ]),
              ),
              const SizedBox(
                width: 25,
              ),
              TextButton(
                onPressed: () {
                  _imc.add(Imc(double.parse(pesoController.text),
                      double.parse(alturaController.text)));
                  setState(() {});
                },
                child: const Text("Calcular"),
              ),
              const SizedBox(
                width: 10,
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _imc.length,
                itemBuilder: (BuildContext bc, int index) {
                  var imc = _imc[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) {
                      _imc.remove(imc);
                    },
                    key: Key(imc.id),
                    child: ListTile(
                      title: Text(
                          "Peso: ${imc.peso}   Altura: ${imc.altura}   IMC: ${imc.getClassificacaoIMC()}"),
                    ),
                  );
                }),
          ),
        ]));
  }
}
