import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/calculator/calculo_selecao_alimento.dart';
import 'package:no_plain_no_gain/models/busca_alimento.dart';

Future<dynamic> PortionDialog(
    BuildContext context, String message, BuscaAlimento value) {
  BuscaAlimento alimento = BuscaAlimento(
      alimento: '',
      porcao: '',
      calorias: '',
      gorduras: '',
      carboidratos: '',
      proteinas: '');
  TextEditingController portionController = TextEditingController();
  String porcaoText = value.porcao;
  String alimentoText = value.alimento;
  String proteinasText = value.proteinas;
  String carboidratosText = value.carboidratos;
  String gordurasText = value.gorduras;
  String caloriasText = value.calorias;
  String mealPortionType = '';

  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text('Selecione a quantidade'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  children: [
                    const Text(
                      'Digite a quantidade:',
                      style: TextStyle(fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        height: 43,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            decoration: null,
                            showCursor: true,
                            controller: portionController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 15),
                            expands: false,
                            minLines: 1,
                            maxLines: 1,
                            onEditingComplete: () {
                              BuscaAlimento alimentoNew =
                                  calculaSelecaoAlimento(
                                      portionController.text, value);
                              setState(() {
                                mealPortionType = cleanPortionType(value);
                                alimento.alimento = alimentoNew.alimento;
                                alimento.porcao = '${alimentoNew.porcao}$mealPortionType';
                                alimento.proteinas = alimentoNew.proteinas;
                                alimento.carboidratos = alimentoNew.carboidratos;
                                alimento.gorduras = alimentoNew.gorduras;
                                alimento.calorias = alimentoNew.calorias;
                                alimentoText = alimentoNew.alimento;
                                porcaoText = '${alimentoNew.porcao}$mealPortionType';
                                proteinasText = '${alimentoNew.proteinas}gr';
                                carboidratosText = '${alimentoNew.carboidratos}gr';
                                gordurasText = '${alimentoNew.gorduras}gr';
                                caloriasText = '${alimentoNew.calorias}kcal';
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text('Alimento: $alimentoText'),
                Text('Porção: $porcaoText'),
                Text('Calorias: $caloriasText'),
                Text('Proteínas: $proteinasText'),
                Text('Carboidratos: $carboidratosText'),
                Text('Gorduras: $gordurasText'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pop(context, alimento);
              },
            ),
          ],
        );
      });
    },
  );
}

String cleanPortionType(BuscaAlimento meal) {
  String treatPortion = meal.porcao;
  String portionMeal = '';
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  for(String a in treatPortion.split('')){
    if (!numericRegex.hasMatch(a) && a != ','){
      portionMeal += a;
    }
  }

  return portionMeal;
}