import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_plain_no_gain/models/busca_alimento.dart';
import 'package:no_plain_no_gain/models/user_mesures.dart';
import 'package:no_plain_no_gain/screens/add_screen/add_food_search_screen.dart';
import 'package:no_plain_no_gain/screens/add_screen/add_user_mesure_screen.dart';
import 'package:no_plain_no_gain/screens/allUserDiets_screen/widgets/create_list_meal.dart';
import 'package:no_plain_no_gain/screens/common_screen/error_dialog.dart';
import 'package:no_plain_no_gain/screens/common_screen/message_dialog.dart';
import 'package:no_plain_no_gain/screens/home_screen/home_screen.dart';
import 'package:no_plain_no_gain/services/busca_alimento_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pie_chart/pie_chart.dart';

class UserDietScreen extends StatefulWidget {
  const UserDietScreen({
    super.key,
  });

  @override
  State<UserDietScreen> createState() => _UserDietScreenState();
}

class _UserDietScreenState extends State<UserDietScreen> {
  String email = '';
  String userId = '';
  String proteinasGrKg = '- gr/Kg';
  String carboidratosGrKg = '- gr/Kg';
  String gordurasGrKg = '- gr/Kg';
  List<String> objectiveList = ['Emagrecimento', 'Hipertrofia', 'Manutenção'];
  UserMesures mesure = UserMesures(
      weight: 0,
      age: 0,
      heigth: 0,
      fatPercentage: 0,
      activity: '',
      sex: '',
      tmb: 0,
      gcd: 0);
  String objectiveSelected = 'Manutenção';
  bool isObjectiveSelected = false;
  final dataMap = <String, double>{
    "Proteinas": 0,
    "Carboidratos": 0,
    "Gorduras": 0,
  };
  final colorList = <Color>[
    Colors.redAccent,
    Colors.blue,
    Colors.amber,
  ];
  final ScrollController _controller = ScrollController();
  final ScrollController _controllerListView = ScrollController();
  bool isExpanded = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  bool isExpanded4 = false;
  bool isExpanded5 = false;
  bool isExpanded6 = false;
  int gcdUser = 0;
  String usedFormula = '';
  int superavitDeficit = 0;
  int totalCalorias = 0;
  BuscaAlimento emptyMeal = BuscaAlimento(
      alimento: '',
      porcao: '',
      calorias: '',
      gorduras: '',
      carboidratos: '',
      proteinas: '');
  Map<int, BuscaAlimento> refeicao1Map = {};
  Map<int, BuscaAlimento> refeicao2Map = {};
  Map<int, BuscaAlimento> refeicao3Map = {};
  Map<int, BuscaAlimento> refeicao4Map = {};
  Map<int, BuscaAlimento> refeicao5Map = {};
  Map<int, BuscaAlimento> refeicao6Map = {};
  List<BuscaAlimento> listRefeicao1 = [];
  List<BuscaAlimento> listRefeicao2 = [];
  List<BuscaAlimento> listRefeicao3 = [];
  List<BuscaAlimento> listRefeicao4 = [];
  List<BuscaAlimento> listRefeicao5 = [];
  List<BuscaAlimento> listRefeicao6 = [];
  int removeItemMap = 0;
  BuscaAlimentoService registerMeals = BuscaAlimentoService();
  bool createEmptyTile = false;

  @override
  void initState() {
    super.initState();
    getMesures();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    double widthScreen = deviceData.size.width;
    double heightScreen = deviceData.size.height;

    return Scrollbar(
      thumbVisibility: true,
      thickness: 10,
      radius: const Radius.circular(5),
      controller: _controller,
      child: SingleChildScrollView(
        controller: _controller,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: widthScreen - 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.greenAccent, width: 2),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.greenAccent,
                                  spreadRadius: 2,
                                  blurStyle: BlurStyle.inner,
                                  blurRadius: 15,
                                  offset: Offset(3, 3))
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Minhas medidas',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Peso: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${mesure.weight.toString()} Kg',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Idade: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${mesure.age.toString()} anos',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Altura: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${mesure.heigth.toString()} cm',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      '% Gord: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      mesure.fatPercentage.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Freq ativ: ',
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      mesure.activity,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Sexo: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      mesure.sex,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 8),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0, top: 8),
                                            child: FloatingActionButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddUserMesureScreen(
                                                            width_screen:
                                                                widthScreen,
                                                            heigth_screen:
                                                                heightScreen,
                                                          )),
                                                );
                                              },
                                              backgroundColor:
                                                  Colors.greenAccent,
                                              foregroundColor: Colors.black,
                                              child: const Icon(
                                                Icons.add,
                                                size: 45,
                                              ),
                                            ),
                                          ),
                                          const Text('adicionar'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: widthScreen - 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.inner,
                                blurRadius: 15,
                                offset: Offset(3, 3))
                          ],
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Escolha seu objetivo',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8),
                              child: DropdownButton<String>(
                                value: objectiveSelected,
                                items: objectiveList
                                    .map<DropdownMenuItem<String>>(
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
                                    isObjectiveSelected = !isObjectiveSelected;
                                    objectiveSelected = value!;
                                    saveObjectOnShared(value);
                                    if (objectiveSelected == 'Emagrecimento') {
                                      gcdUser = mesure.gcd - 300;
                                      superavitDeficit = -300;
                                    } else if (objectiveSelected ==
                                        'Hipertrofia') {
                                      gcdUser = mesure.gcd + 300;
                                      superavitDeficit = 300;
                                    } else if (objectiveSelected ==
                                        'Manutenção') {
                                      gcdUser = mesure.gcd;
                                      superavitDeficit = 0;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: widthScreen - 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.greenAccent, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.greenAccent,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.inner,
                                blurRadius: 15,
                                offset: Offset(3, 3))
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Taxa metabólica basal: ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    mesure.tmb.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    usedFormula,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Gasto calórico diário: ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    mesure.gcd.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Superavit/Défict Calórico: ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    superavitDeficit.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Ingestão calórica diário: ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    gcdUser.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Container(
                        width: widthScreen - 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.inner,
                                blurRadius: 15,
                                offset: Offset(3, 3))
                          ],
                        ),
                        child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                  'Divisão de macros da sua dieta',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, bottom: 8, top: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.red,
                                            spreadRadius: 2,
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 15,
                                            offset: Offset(3, 3))
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, left: 6, right: 6),
                                          child: Text(
                                            'Proteínas',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Text(
                                            proteinasGrKg,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.blue,
                                            spreadRadius: 2,
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 15,
                                            offset: Offset(3, 3))
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, left: 6, right: 6),
                                          child: Text(
                                            'Carboidratos',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Text(
                                            carboidratosGrKg,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.amber, width: 2),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.amber,
                                            spreadRadius: 2,
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 15,
                                            offset: Offset(3, 3))
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, left: 6, right: 6),
                                          child: Text(
                                            'Gorduras',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Text(
                                            gordurasGrKg,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              height: 200,
                              child: PieChart(
                                animationDuration: const Duration(seconds: 5),
                                ringStrokeWidth: 30,
                                dataMap: dataMap,
                                chartType: ChartType.disc,
                                baseChartColor: Colors.black.withOpacity(0.15),
                                colorList: colorList,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.right,
                                    legendTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: true,
                                    chartValueStyle: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        backgroundColor: Colors.white)),
                                totalValue: 100.0,
                              ),
                            ),
                            Row(
                              children: [
                                const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Total de Calorias:',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      calculateTotalCalories(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      (gcdUser > totalCalorias)
                                          ? 'Calorias faltantes:'
                                          : 'Calorias excedentes:',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      '${(gcdUser - totalCalorias).toString()} kcal',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: widthScreen - 30,
                        height: 450,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.greenAccent, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.greenAccent,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.inner,
                                blurRadius: 15,
                                offset: Offset(3, 3))
                          ],
                        ),
                        child: buildColumnMeals(context, widthScreen),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(8),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.greenAccent),
                        ),
                        onPressed: () {
                          removeSharedPreferences();
                        },
                        child: Text(
                          'Apagar dados',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(fontSize: 30),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  Column buildColumnMeals(BuildContext context, double widthScreen) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Refeições',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        SizedBox(
          width: widthScreen - 50,
          height: 350,
          child: Scrollbar(
            controller: _controller,
            thumbVisibility: true,
            thickness: 13.0,
            radius: const Radius.circular(20.0),
            child: buildListViewMeals(),
          ),
        ),
      ],
    );
  }

  ListView buildListViewMeals() {
    return ListView(
      children: [
        ExpansionPanelList(
          dividerColor: Colors.grey,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              this.isExpanded = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        createListTotalCalories(refeicao1Map);
                      },
                      child: const Text('Refeição 1'),
                    ),
                  );
                },
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: SizedBox(
                        height: refeicao1Map.isEmpty ? 100 : 200,
                        child: Scrollbar(
                          controller: _controller,
                          thumbVisibility: true,
                          thickness: 13.0,
                          radius: const Radius.circular(20.0),
                          child: ListView(
                            controller: _controllerListView,
                            children: generateListTile(
                                refeicao: refeicao1Map, mealNumber: 1),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        validateUserMesures(
                            refeicao: refeicao1Map, mealNumber: 1);
                      },
                      child: const Icon(
                        Icons.add_circle,
                        size: 35,
                      ),
                    ),
                    const Text(
                      'adicionar alimento',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                isExpanded: isExpanded),
          ],
        ),
        ExpansionPanelList(
          dividerColor: Colors.grey,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              isExpanded2 = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        createListTotalCalories(refeicao2Map);
                      },
                      child: const Text('Refeição 2'),
                    ),
                  );
                },
                body: Column(
                  children: [
                    SizedBox(
                      height: refeicao2Map.isEmpty ? 100 : 200,
                      child: Scrollbar(
                        controller: _controller,
                        thumbVisibility: true,
                        thickness: 13.0,
                        radius: const Radius.circular(20.0),
                        child: ListView(
                          controller: _controllerListView,
                          children: generateListTile(
                              refeicao: refeicao2Map, mealNumber: 2),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        validateUserMesures(
                            refeicao: refeicao2Map, mealNumber: 2);
                      },
                      child: const Icon(
                        Icons.add_circle,
                        size: 35,
                      ),
                    ),
                    const Text(
                      'adicionar alimento',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                isExpanded: isExpanded2),
          ],
        ),
        ExpansionPanelList(
          dividerColor: Colors.grey,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              isExpanded3 = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        createListTotalCalories(refeicao3Map);
                      },
                      child: const Text('Refeição 3'),
                    ),
                  );
                },
                body: Column(
                  children: [
                    SizedBox(
                      height: refeicao3Map.isEmpty ? 100 : 200,
                      child: Scrollbar(
                        controller: _controller,
                        thumbVisibility: true,
                        thickness: 13.0,
                        radius: const Radius.circular(20.0),
                        child: ListView(
                          controller: _controllerListView,
                          children: generateListTile(
                              refeicao: refeicao3Map, mealNumber: 3),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        validateUserMesures(
                            refeicao: refeicao3Map, mealNumber: 3);
                      },
                      child: const Icon(
                        Icons.add_circle,
                        size: 35,
                      ),
                    ),
                    const Text(
                      'adicionar alimento',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                isExpanded: isExpanded3),
          ],
        ),
        ExpansionPanelList(
          dividerColor: Colors.grey,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              isExpanded4 = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        createListTotalCalories(refeicao4Map);
                      },
                      child: const Text('Refeição 4'),
                    ),
                  );
                },
                body: Column(
                  children: [
                    SizedBox(
                      height: refeicao4Map.isEmpty ? 100 : 200,
                      child: Scrollbar(
                        controller: _controller,
                        thumbVisibility: true,
                        thickness: 13.0,
                        radius: const Radius.circular(20.0),
                        child: ListView(
                          controller: _controllerListView,
                          children: generateListTile(
                              refeicao: refeicao4Map, mealNumber: 4),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        validateUserMesures(
                            refeicao: refeicao4Map, mealNumber: 4);
                      },
                      child: const Icon(
                        Icons.add_circle,
                        size: 35,
                      ),
                    ),
                    const Text(
                      'adicionar alimento',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                isExpanded: isExpanded4),
          ],
        ),
        ExpansionPanelList(
          dividerColor: Colors.grey,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              isExpanded5 = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        createListTotalCalories(refeicao5Map);
                      },
                      child: const Text('Refeição 5'),
                    ),
                  );
                },
                body: Column(
                  children: [
                    SizedBox(
                      height: refeicao5Map.isEmpty ? 100 : 200,
                      child: Scrollbar(
                        controller: _controller,
                        thumbVisibility: true,
                        thickness: 13.0,
                        radius: const Radius.circular(20.0),
                        child: ListView(
                          controller: _controllerListView,
                          children: generateListTile(
                              refeicao: refeicao5Map, mealNumber: 5),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        validateUserMesures(
                            refeicao: refeicao5Map, mealNumber: 5);
                      },
                      child: const Icon(
                        Icons.add_circle,
                        size: 35,
                      ),
                    ),
                    const Text(
                      'adicionar alimento',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                isExpanded: isExpanded5),
          ],
        ),
        ExpansionPanelList(
          dividerColor: Colors.grey,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              isExpanded6 = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        createListTotalCalories(refeicao6Map);
                      },
                      child: const Text('Refeição 6'),
                    ),
                  );
                },
                body: Column(
                  children: [
                    SizedBox(
                      height: refeicao6Map.isEmpty ? 100 : 200,
                      child: Scrollbar(
                        controller: _controller,
                        thumbVisibility: true,
                        thickness: 13.0,
                        radius: const Radius.circular(20.0),
                        child: ListView(
                          controller: _controllerListView,
                          children: generateListTile(
                              refeicao: refeicao6Map, mealNumber: 6),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        validateUserMesures(
                            refeicao: refeicao6Map, mealNumber: 6);
                      },
                      child: const Icon(
                        Icons.add_circle,
                        size: 35,
                      ),
                    ),
                    const Text(
                      'adicionar alimento',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                isExpanded: isExpanded6),
          ],
        )
      ],
    );
  }

  void getMesures() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? weight = prefs.getDouble('peso');
    double? heigth = prefs.getDouble('altura');
    int? idade = prefs.getInt('idade');
    String? activity = prefs.getString('activity');
    double? fatPercentage = prefs.getDouble('gordura');
    String? sex = prefs.getString('sexo');
    int? tmb = prefs.getInt('tmb');
    int? gcd = prefs.getInt('gcd');
    String? formula = prefs.getString('formula');

    setState(() {
      mesure.weight = weight!;
      mesure.heigth = heigth!;
      mesure.age = idade!;
      mesure.activity = activity!;
      mesure.fatPercentage = fatPercentage!;
      mesure.sex = sex!;
      mesure.tmb = tmb!;
      mesure.gcd = gcd!;
      gcdUser = gcd;
      usedFormula = formula!;
    });
  }

  List<CreateListMeal> generateListTile(
      {required Map<int, BuscaAlimento> refeicao, required int mealNumber}) {
    List<CreateListMeal> listTile = [];
    createEmptyTile = false;

    if (refeicao.isEmpty) {
      listTile.add(
        CreateListMeal(
          meal: emptyMeal,
          itemMap: 0,
          refeicao: refeicao,
          createEmptyTile: createEmptyTile,
          mealNumber: mealNumber,
        ),
      );
    }

    refeicao.forEach(
      (key, value) {
        listTile.add(
          CreateListMeal(
            meal: value,
            itemMap: key,
            refeicao: refeicao,
            createEmptyTile: createEmptyTile,
            mealNumber: mealNumber,
          ),
        );
      },
    );

    return listTile;
  }

  void refresh() async {
    SharedPreferences.getInstance().then((prefs) {
      String? firstName = prefs.getString('first_name');
      String? lastName = prefs.getString('last_name');
      String? refeicao1 = prefs.getString('refeicao1');
      String? refeicao2 = prefs.getString('refeicao2');
      String? refeicao3 = prefs.getString('refeicao3');
      String? refeicao4 = prefs.getString('refeicao4');
      String? refeicao5 = prefs.getString('refeicao5');
      String? refeicao6 = prefs.getString('refeicao6');
      String? getObjective = prefs.getString('objective');
      int foodNumber = 0;

      if (getObjective != null) {
        objectiveSelected = getObjective;
        if (objectiveSelected == 'Emagrecimento') {
          setState(() {
            gcdUser = mesure.gcd - 300;
            superavitDeficit = -300;
          });
        } else if (objectiveSelected == 'Hipertrofia') {
          setState(() {
            gcdUser = mesure.gcd + 300;
            superavitDeficit = 300;
          });
        } else if (objectiveSelected == 'Manutenção') {
          setState(() {
            gcdUser = mesure.gcd;
            superavitDeficit = 0;
          });
        }
      } else {
        objectiveSelected = 'Manutenção';
      }

      if (refeicao1 != null) {
        String meal = '';
        for (String a in refeicao1.split('')) {
          if (a != '}') {
            meal += a;
          } else if (a == '}') {
            meal += a;
            BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
            listRefeicao1.add(alimento);
            meal = '';
          }
        }
        for (BuscaAlimento alimento in listRefeicao1) {
          if (alimento.alimento != '') {
            foodNumber++;
            refeicao1Map[foodNumber] = alimento;
          }
        }
      }
      if (refeicao2 != null) {
        String meal = '';
        for (String a in refeicao2.split('')) {
          if (a != '}') {
            meal += a;
          } else if (a == '}') {
            meal += a;
            BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
            listRefeicao2.add(alimento);
            meal = '';
          }
        }
        for (BuscaAlimento alimento in listRefeicao2) {
          if (alimento.alimento != '') {
            foodNumber++;
            refeicao2Map[foodNumber] = alimento;
          }
        }
      }
      if (refeicao3 != null) {
        String meal = '';
        for (String a in refeicao3.split('')) {
          if (a != '}') {
            meal += a;
          } else if (a == '}') {
            meal += a;
            BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
            listRefeicao3.add(alimento);
            meal = '';
          }
        }
        for (BuscaAlimento alimento in listRefeicao3) {
          if (alimento.alimento != '') {
            foodNumber++;
            refeicao3Map[foodNumber] = alimento;
          }
        }
      }
      if (refeicao4 != null) {
        String meal = '';
        for (String a in refeicao4.split('')) {
          if (a != '}') {
            meal += a;
          } else if (a == '}') {
            meal += a;
            BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
            listRefeicao4.add(alimento);
            meal = '';
          }
        }
        for (BuscaAlimento alimento in listRefeicao4) {
          if (alimento.alimento != '') {
            foodNumber++;
            refeicao4Map[foodNumber] = alimento;
          }
        }
      }
      if (refeicao5 != null) {
        String meal = '';
        for (String a in refeicao5.split('')) {
          if (a != '}') {
            meal += a;
          } else if (a == '}') {
            meal += a;
            BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
            listRefeicao5.add(alimento);
            meal = '';
          }
        }
        for (BuscaAlimento alimento in listRefeicao5) {
          if (alimento.alimento != '') {
            foodNumber++;
            refeicao5Map[foodNumber] = alimento;
          }
        }
      }
      if (refeicao6 != null) {
        String meal = '';
        for (String a in refeicao6.split('')) {
          if (a != '}') {
            meal += a;
          } else if (a == '}') {
            meal += a;
            BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
            listRefeicao6.add(alimento);
            meal = '';
          }
        }
        for (BuscaAlimento alimento in listRefeicao6) {
          if (alimento.alimento != '') {
            foodNumber++;
            refeicao6Map[foodNumber] = alimento;
          }
        }
      }
      calculateTotalCalories();
      //if (firstName != null && lastName != null) {
      //  email = firstName;
      //} else {
      //  Navigator.pushReplacementNamed(context, 'login');
      //}
    });
  }

  void createListTotalCalories(Map<int, BuscaAlimento> refeicao) {
    double calorias = 0;
    double proteinas = 0;
    double carboidratos = 0;
    double gorduras = 0;

    if (refeicao.isNotEmpty) {
      refeicao.forEach((key, value) {
        if (value.calorias != '') {
          calorias += double.parse(value.calorias.replaceAll(',', '.'));
          proteinas += double.parse(value.proteinas.replaceAll(',', '.'));
          carboidratos += double.parse(value.carboidratos.replaceAll(',', '.'));
          gorduras += double.parse(value.gorduras.replaceAll(',', '.'));
        }
      });
    }

    messageDialog(
        context,
        'Total da refeição:\n'
        'Calorias: ${calorias.round()} kcal\n'
        'Proteinas: ${proteinas.round()} gr\n'
        'Carboidratos: ${carboidratos.round()} gr\n'
        'Gorduras: ${gorduras.round()} gr');
  }

  void calculateTotalMacros() {
    double proteinas = 0;
    double carboidratos = 0;
    double gorduras = 0;
    double calorias = 0;
    double percentagemProteinas = 0;
    double percentagemCarboidratos = 0;
    double percentagemGorduras = 0;
    String protGrKg = '';
    String carbGrKg = '';
    String gordGrKg = '';

    refeicao1Map.forEach((key, value) {
      if (value.calorias != '') {
        proteinas += double.parse(value.proteinas.replaceAll(',', '.'));
        carboidratos += double.parse(value.carboidratos.replaceAll(',', '.'));
        gorduras += double.parse(value.gorduras.replaceAll(',', '.'));
      }
    });
    refeicao2Map.forEach((key, value) {
      if (value.calorias != '') {
        proteinas += double.parse(value.proteinas.replaceAll(',', '.'));
        carboidratos += double.parse(value.carboidratos.replaceAll(',', '.'));
        gorduras += double.parse(value.gorduras.replaceAll(',', '.'));
      }
    });
    refeicao3Map.forEach((key, value) {
      if (value.calorias != '') {
        proteinas += double.parse(value.proteinas.replaceAll(',', '.'));
        carboidratos += double.parse(value.carboidratos.replaceAll(',', '.'));
        gorduras += double.parse(value.gorduras.replaceAll(',', '.'));
      }
    });
    refeicao4Map.forEach((key, value) {
      if (value.calorias != '') {
        proteinas += double.parse(value.proteinas.replaceAll(',', '.'));
        carboidratos += double.parse(value.carboidratos.replaceAll(',', '.'));
        gorduras += double.parse(value.gorduras.replaceAll(',', '.'));
      }
    });
    refeicao5Map.forEach((key, value) {
      if (value.calorias != '') {
        proteinas += double.parse(value.proteinas.replaceAll(',', '.'));
        carboidratos += double.parse(value.carboidratos.replaceAll(',', '.'));
        gorduras += double.parse(value.gorduras.replaceAll(',', '.'));
      }
    });
    refeicao6Map.forEach((key, value) {
      if (value.calorias != '') {
        proteinas += double.parse(value.proteinas.replaceAll(',', '.'));
        carboidratos += double.parse(value.carboidratos.replaceAll(',', '.'));
        gorduras += double.parse(value.gorduras.replaceAll(',', '.'));
      }
    });

    calorias = (proteinas * 4).roundToDouble() +
        (carboidratos * 4).roundToDouble() +
        (gorduras * 9).roundToDouble();

    percentagemProteinas = double.parse(
        (((proteinas * 4).roundToDouble() / calorias) * 100)
            .toStringAsFixed(2));
    percentagemCarboidratos = double.parse(
        (((carboidratos * 4).roundToDouble() / calorias) * 100)
            .toStringAsFixed(2));
    percentagemGorduras = double.parse(
        (((gorduras * 9).roundToDouble() / calorias) * 100).toStringAsFixed(2));

    protGrKg =
        '${((proteinas / mesure.weight).toStringAsFixed(2).replaceAll('.', ','))}\ngr/Kg';
    carbGrKg =
        '${((carboidratos / mesure.weight).toStringAsFixed(2).replaceAll('.', ','))}\ngr/Kg';
    gordGrKg =
        '${((gorduras / mesure.weight).toStringAsFixed(2).replaceAll('.', ','))}\ngr/Kg';

    if (totalCalorias > 0) {
      setState(() {
        dataMap['Proteinas'] = percentagemProteinas;
        dataMap['Carboidratos'] = percentagemCarboidratos;
        dataMap['Gorduras'] = percentagemGorduras;
        proteinasGrKg = protGrKg;
        carboidratosGrKg = carbGrKg;
        gordurasGrKg = gordGrKg;
      });
    } else {
      setState(() {
        dataMap['Proteinas'] = 0;
        dataMap['Carboidratos'] = 0;
        dataMap['Gorduras'] = 0;
        proteinasGrKg = '-\ngr/Kg';
        carboidratosGrKg = '-\ngr/Kg';
        gordurasGrKg = '-\ngr/Kg';
      });
    }
  }

  String calculateTotalCalories() {
    double calories = 0;

    refeicao1Map.forEach((key, value) {
      if (value.calorias != '') {
        calories += double.parse(value.calorias.contains(',')
            ? value.calorias.replaceAll(',', '.')
            : value.calorias);
      }
    });
    refeicao2Map.forEach((key, value) {
      if (value.calorias != '') {
        calories += double.parse(value.calorias.contains(',')
            ? value.calorias.replaceAll(',', '.')
            : value.calorias);
      }
    });
    refeicao3Map.forEach((key, value) {
      if (value.calorias != '') {
        calories += double.parse(value.calorias.contains(',')
            ? value.calorias.replaceAll(',', '.')
            : value.calorias);
      }
    });
    refeicao4Map.forEach((key, value) {
      if (value.calorias != '') {
        calories += double.parse(value.calorias.contains(',')
            ? value.calorias.replaceAll(',', '.')
            : value.calorias);
      }
    });
    refeicao5Map.forEach((key, value) {
      if (value.calorias != '') {
        calories += double.parse(value.calorias.contains(',')
            ? value.calorias.replaceAll(',', '.')
            : value.calorias);
      }
    });
    refeicao6Map.forEach((key, value) {
      if (value.calorias != '') {
        calories += double.parse(value.calorias.contains(',')
            ? value.calorias.replaceAll(',', '.')
            : value.calorias);
      }
    });

    totalCalorias = calories.round();

    calculateTotalMacros();

    return '${(calories.round()).toString()} kcal';
  }

  void removeSharedPreferences() async {
    List<BuscaAlimento> listRemove = [];
    registerMeals.registerSharedPreferences(listRemove, 1);
    registerMeals.registerSharedPreferences(listRemove, 2);
    registerMeals.registerSharedPreferences(listRemove, 3);
    registerMeals.registerSharedPreferences(listRemove, 4);
    registerMeals.registerSharedPreferences(listRemove, 5);
    registerMeals.registerSharedPreferences(listRemove, 6);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('peso', 0);
    prefs.setDouble('altura', 0);
    prefs.setInt('idade', 0);
    prefs.setString('activity', '');
    prefs.setString('objective', '');
    prefs.setDouble('gordura', 0);
    prefs.setString('sexo', '');
    prefs.setInt('tmb', 0);
    prefs.setInt('gcd', 0);
    prefs.setString('formula', '');
    prefs.setString('objective', '');

    transferScreen();
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

  void validateUserMesures(
      {required Map<int, BuscaAlimento> refeicao, required int mealNumber}) {
    if (mesure.weight != 0 &&
        mesure.age != 0 &&
        mesure.tmb != 0 &&
        mesure.gcd != 0 &&
        mesure.activity != '' &&
        mesure.sex != '' &&
        mesure.heigth != 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodSearchScreen(
            refeicao: refeicao,
            mealNumber: mealNumber,
          ),
        ),
      );
      setState(() {
        isExpanded6 = !isExpanded6;
        calculateTotalMacros();
        refresh();
      });
    } else {
      ErrorDialog(context,
          'Antes de adicionar alimentos em uma refeição, preencha seus dados!');
    }
  }

  void saveObjectOnShared(String objectiveSelected) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('objective', objectiveSelected);
  }
}
