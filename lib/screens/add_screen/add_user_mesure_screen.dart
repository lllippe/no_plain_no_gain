import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/calculator/calculo_taxa_metabolica.dart';
import 'package:no_plain_no_gain/models/busca_alimento.dart';
import 'package:no_plain_no_gain/screens/common_screen/error_dialog.dart';
import 'package:no_plain_no_gain/screens/common_screen/success_dialog.dart';
import 'package:no_plain_no_gain/screens/home_screen/home_screen.dart';
import 'package:no_plain_no_gain/services/busca_alimento_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUserMesureScreen extends StatefulWidget {
  final double width_screen;
  final double heigth_screen;

  const AddUserMesureScreen(
      {super.key, required this.width_screen, required this.heigth_screen});

  @override
  State<AddUserMesureScreen> createState() => _AddUserMesureScreenState();
}

class _AddUserMesureScreenState extends State<AddUserMesureScreen> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController pGorduraController = TextEditingController();
  TextEditingController fAtividadeController = TextEditingController();
  final BuscaAlimentoService _buscaAlimentoService = BuscaAlimentoService();
  Map<int, BuscaAlimento> databaseBuscaAlimento = {};
  List<Card> list = [];
  bool isSelectedPeso = false;
  bool isSelectedAltura = false;
  bool isSelectedGordura = false;
  bool isSelectedIdade = false;
  bool isSelectedGord = false;
  bool isSelectedSex = false;
  List<String> typeActivity = [
    'Selecione um item',
    'Sedentário',
    'Leve(1-2x na semana)',
    'Moderado(3-5x na semana)',
    'Pesado(6-7x na semana)',
    'Atleta(2x por dia)',
  ];
  List<String> sexList = ['Selecione um item', 'Masculino', 'Feminino'];
  String activitySelected = 'Selecione um item';
  String sexSelected = 'Selecione um item';
  String messageToShow = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.greenAccent,
        backgroundColor: Colors.black87,
        title: const Text(
          'Insira suas informações:',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent
          ),
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 10,
        radius: const Radius.circular(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: widget.width_screen,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PESO (EM KG)',
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelectedPeso
                                ? Border.all(
                                    width: 3, color: Colors.greenAccent)
                                : Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          width: widget.width_screen,
                          height: 43,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8),
                            child: TextField(
                              decoration: null,
                              showCursor: true,
                              controller: pesoController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 15),
                              expands: false,
                              minLines: 1,
                              maxLines: 1,
                              onTap: () {
                                setState(() {
                                  isSelectedPeso = true;
                                  isSelectedAltura = false;
                                  isSelectedGordura = false;
                                  isSelectedIdade = false;
                                  isSelectedGord = false;
                                  isSelectedSex = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: widget.width_screen,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ALTURA (EM CM)',
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelectedAltura
                                ? Border.all(
                                    width: 3, color: Colors.greenAccent)
                                : Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          width: widget.width_screen,
                          height: 43,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8),
                            child: TextField(
                              decoration: null,
                              showCursor: true,
                              controller: alturaController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 15),
                              expands: false,
                              minLines: 1,
                              maxLines: 1,
                              onTap: () {
                                setState(() {
                                  isSelectedAltura = true;
                                  isSelectedPeso = false;
                                  isSelectedGordura = false;
                                  isSelectedIdade = false;
                                  isSelectedGord = false;
                                  isSelectedSex = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: widget.width_screen,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'IDADE',
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelectedIdade
                                ? Border.all(
                                    width: 3, color: Colors.greenAccent)
                                : Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          width: widget.width_screen,
                          height: 43,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8),
                            child: TextField(
                              decoration: null,
                              showCursor: true,
                              controller: idadeController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 15),
                              expands: false,
                              minLines: 1,
                              maxLines: 1,
                              onTap: () {
                                setState(() {
                                  isSelectedIdade = true;
                                  isSelectedPeso = false;
                                  isSelectedAltura = false;
                                  isSelectedGordura = false;
                                  isSelectedGord = false;
                                  isSelectedSex = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: widget.width_screen,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PERCENTUAL DE GORDURA',
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelectedGordura
                                ? Border.all(
                                    width: 3, color: Colors.greenAccent)
                                : Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          width: widget.width_screen,
                          height: 43,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8),
                            child: TextField(
                              decoration: null,
                              showCursor: true,
                              controller: pGorduraController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 15),
                              expands: false,
                              minLines: 1,
                              maxLines: 1,
                              onTap: () {
                                setState(() {
                                  isSelectedGordura = true;
                                  isSelectedPeso = false;
                                  isSelectedAltura = false;
                                  isSelectedIdade = false;
                                  isSelectedGord = false;
                                  isSelectedSex = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: widget.width_screen,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'QUANTIDADE DE ATIVIDADE FÍSICA',
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelectedGord
                                ? Border.all(
                                    width: 3, color: Colors.greenAccent)
                                : Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: DropdownButton<String>(
                              elevation: 8,
                              value: activitySelected,
                              items: typeActivity.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: 250,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  isSelectedGordura = false;
                                  isSelectedPeso = false;
                                  isSelectedAltura = false;
                                  isSelectedIdade = false;
                                  isSelectedGord = true;
                                  isSelectedSex = false;
                                  activitySelected = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: widget.width_screen,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SEXO',
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelectedSex
                                ? Border.all(
                                    width: 3, color: Colors.greenAccent)
                                : Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 8),
                            child: DropdownButton<String>(
                              value: sexSelected,
                              items: sexList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: 250,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  isSelectedGordura = false;
                                  isSelectedPeso = false;
                                  isSelectedAltura = false;
                                  isSelectedIdade = false;
                                  isSelectedGord = false;
                                  isSelectedSex = true;
                                  sexSelected = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.greenAccent,
        backgroundColor: Colors.black87,
        onPressed: () {
          if (pesoController.text != '') {
            if (alturaController.text != '') {
              if (idadeController.text != '') {
                if (sexSelected != 'Selecione um item') {
                  if (activitySelected != 'Selecione um item') {
                    FocusScope.of(context).requestFocus(FocusNode());
                    SaveUserMesures(
                        double.parse(pesoController.text.contains(',')
                            ? pesoController.text.replaceAll(',', '.')
                            : pesoController.text),
                        double.parse(alturaController.text.contains(',')
                            ? alturaController.text.replaceAll(',', '.')
                            : alturaController.text),
                        int.parse(idadeController.text),
                        activitySelected,
                        pGorduraController.text != ''
                            ? double.parse(pGorduraController.text.contains(',')
                                ? pGorduraController.text.replaceAll(',', '.')
                                : pGorduraController.text)
                            : 0,
                        sexSelected);
                    SuccessDialog(
                      context,
                      'Os dados:${
                        calculoMetabolismo(
                          double.parse(pesoController.text.contains(',')
                             ? pesoController.text.replaceAll(',', '.')
                             : pesoController.text),
                          double.parse(alturaController.text.contains(',')
                              ? alturaController.text.replaceAll(',', '.')
                              : alturaController.text),
                          int.parse(idadeController.text),
                          activitySelected,
                          pGorduraController.text != ''
                              ? double.parse(pGorduraController.text)
                              : 0,
                          sexSelected,
                        )
                      }\n foram adicionados com sucesso!',
                    );
                    transferScreen();
                  } else {
                    ErrorDialog(
                        context, 'Favor selecionar atividade física semanal!');
                  }
                } else {
                  ErrorDialog(context, 'Favor selecionar seu sexo!');
                }
              } else {
                ErrorDialog(context, 'Favor preencher sua idade!');
              }
            } else {
              ErrorDialog(context, 'Favor preencher sua altura!');
            }
          } else {
            ErrorDialog(context, 'Favor preencher seu peso!');
          }
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void SaveUserMesures(
      double pesoController,
      double alturaController,
      int idadeController,
      String activitySelected,
      double pGorduraController,
      String sexSelected) async {
    double userPeso = pesoController;
    double userAltura = alturaController;
    int userIdade = idadeController;
    String userActivity = activitySelected;
    double userGordura = pGorduraController;
    String userSex = sexSelected;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('peso', userPeso);
    prefs.setDouble('altura', userAltura);
    prefs.setInt('idade', userIdade);
    prefs.setString('activity', userActivity);
    prefs.setDouble('gordura', userGordura);
    prefs.setString('sexo', userSex);


  }

  void transferScreen() {
    Navigator.pop(
      context,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HomeScreen(
            selectedIndex: 1,
          )),
    );
  }
}
