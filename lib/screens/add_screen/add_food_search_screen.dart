import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/models/busca_alimento.dart';
import 'package:no_plain_no_gain/screens/common_screen/error_dialog.dart';
import 'package:no_plain_no_gain/screens/common_screen/message_dialog.dart';
import 'package:no_plain_no_gain/screens/common_screen/portion_dialog.dart';
import 'package:no_plain_no_gain/screens/common_screen/success_dialog.dart';
import 'package:no_plain_no_gain/screens/home_screen/home_screen.dart';
import 'package:no_plain_no_gain/services/busca_alimento_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FoodSearchScreen extends StatefulWidget {
  Map<int, BuscaAlimento> refeicao;
  int mealNumber;

  FoodSearchScreen({super.key, required this.refeicao, required this.mealNumber});

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();

}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  TextEditingController buscaController = TextEditingController();
  final BuscaAlimentoService _buscaAlimentoService = BuscaAlimentoService();
  Map<int, BuscaAlimento> databaseBuscaAlimento = {};
  List<GestureDetector> list = [];
  List<BuscaAlimento> listRefeicao1 = [];
  List<BuscaAlimento> listRefeicao2 = [];
  List<BuscaAlimento> listRefeicao3 = [];
  List<BuscaAlimento> listRefeicao4 = [];
  List<BuscaAlimento> listRefeicao5 = [];
  List<BuscaAlimento> listRefeicao6 = [];
  String email = '';
  BuscaAlimentoService registerMeals = BuscaAlimentoService();
  final ScrollController _controller = ScrollController();

  @override void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.greenAccent,
          title: const Text('Busca alimento', style: TextStyle(color: Colors.greenAccent),),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.greenAccent),
            onPressed: (){
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const HomeScreen(selectedIndex: 1,)),
              );
            },
          ),
        ),
        body: Scrollbar(
          thumbVisibility: true,
          thickness: 10,
          radius: const Radius.circular(15),
          controller: _controller,
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const Text(
                      'Digite o alimento:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextField(
                              controller: buscaController,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(fontSize: 22),
                              expands: true,
                              minLines: null,
                              maxLines: null,
                            ),
                          ),
                        )),
                  ],
                ),
                (list.isNotEmpty)
                    ? Column(
                  children: list,
                )
                    : Container(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            search(buscaController.text);
          },
          tooltip: 'Buscar',
          child: const Icon(Icons.search_outlined),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }

    void search(String buscaController) {
      int i = 0;
      String alimentoBusca = buscaController;
      _buscaAlimentoService
          .getAlimento(alimentoBusca)
          .then((List<BuscaAlimento> listBuscaALimento) {
        setState(() {
          databaseBuscaAlimento = {};
          list = [];
          for (BuscaAlimento alimento in listBuscaALimento) {
            i++;
            databaseBuscaAlimento[i] = alimento;
          }
          createCard();
        });
      });
    }

    void createCard() {
      databaseBuscaAlimento.forEach((key, value) {
        list.add(GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
            messageDialog(context, 'Alimento: ${value.alimento}\n'
                'Porção: ${value.porcao}\n'
                'Calorias: ${value.calorias} kcal\n'
                'Proteinas: ${value.proteinas} gr\n'
                'Carboidratos: ${value.carboidratos} gr\n'
                'Gorduras: ${value.gorduras} gr');
          },
          onLongPress: (){
            FocusScope.of(context).requestFocus(FocusNode());
            PortionDialog(context, 'message', value).then((valueReturnDialog) {
              BuscaAlimento newFoodPortion = valueReturnDialog;
              if (newFoodPortion.alimento != ''){
                bool returnSave = SaveFoodInMeal(newFoodPortion);
                if (!returnSave) {
                  SuccessDialog(context, 'Alimento salvo com sucesso!');
                }
              }
            });
          },
          child: Card(
            child: Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    autoClose: true,
                    borderRadius: BorderRadius.circular(7),
                    flex: 2,
                    onPressed: (BuildContext context) {
                      messageDialog(context, 'Alimento: ${value.alimento}\n'
                          'Porção: ${value.porcao}\n'
                          'Calorias: ${value.calorias} kcal\n'
                          'Proteinas: ${value.proteinas} gr\n'
                          'Carboidratos: ${value.carboidratos} gr\n'
                          'Gorduras: ${value.gorduras} gr');
                    },
                    icon: Icons.change_circle_outlined,
                    backgroundColor: Colors.greenAccent,
                    label: "Visualizar",
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    autoClose: true,
                    borderRadius: BorderRadius.circular(7),
                    flex: 2,
                    onPressed: (BuildContext buildContext) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      PortionDialog(context, 'message', value).then((valueReturnDialog) {
                        BuscaAlimento newFoodPortion = valueReturnDialog;
                        if (newFoodPortion.alimento != ''){
                          bool returnSave = SaveFoodInMeal(newFoodPortion);
                          if (!returnSave) {
                            SuccessDialog(context, 'Alimento salvo com sucesso!');
                          }
                        }
                      });
                    },
                    icon: Icons.change_circle_outlined,
                    backgroundColor: Colors.amber,
                    label: "Incluir",
                  ),
                ],
              ),
              child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListTile(
                      title: Column(
                        children: [
                          Text('$key - Alimento: ${value.alimento} | Clique para ver mais...',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
      });
    }

    bool SaveFoodInMeal(BuscaAlimento value) {
      bool validationMeal = false;
      widget.refeicao.forEach((key, valueRefeicao) {
        if (value.alimento.trim() == valueRefeicao.alimento.trim()) {
          validationMeal = true;
        }
      });
      if (validationMeal) {
        ErrorDialog(context, 'O alimento selecionado já está na refeição, volte '
            'na Refeição e altere a quantidade.');
        return true;
      } else {
        BuscaAlimento alimento = BuscaAlimento(alimento: value.alimento,
            porcao: value.porcao,
            calorias: value.calorias,
            gorduras: value.gorduras,
            carboidratos: value.carboidratos,
            proteinas: value.proteinas);
        int food = widget.refeicao.length + 1;
        widget.refeicao[food] = alimento;
        registerMealSharedPreferences(alimento);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const HomeScreen(selectedIndex: 1,)),
        );
      }
      return false;
    }

    void registerMealSharedPreferences(BuscaAlimento alimento) {
      if(widget.mealNumber == 1){
        listRefeicao1.add(alimento);
        registerMeals.registerSharedPreferences(listRefeicao1, 1);
        SuccessDialog(context, 'O alimento ${alimento.alimento} foi adicionado a refeição 1 com sucesso!');
      } else if(widget.mealNumber == 2){
        listRefeicao2.add(alimento);
        registerMeals.registerSharedPreferences(listRefeicao2, 2);
        SuccessDialog(context, 'O alimento ${alimento.alimento} foi adicionado a refeição 2 com sucesso!');
      } else if(widget.mealNumber == 3){
        listRefeicao3.add(alimento);
        registerMeals.registerSharedPreferences(listRefeicao3, 3);
        SuccessDialog(context, 'O alimento ${alimento.alimento} foi adicionado a refeição 3 com sucesso!');
      } else if(widget.mealNumber == 4){
        listRefeicao4.add(alimento);
        registerMeals.registerSharedPreferences(listRefeicao4, 4);
        SuccessDialog(context, 'O alimento ${alimento.alimento} foi adicionado a refeição 4 com sucesso!');
      } else if(widget.mealNumber == 5){
        listRefeicao5.add(alimento);
        registerMeals.registerSharedPreferences(listRefeicao5, 5);
        SuccessDialog(context, 'O alimento ${alimento.alimento} foi adicionado a refeição 5 com sucesso!');
      } else if(widget.mealNumber == 6){
        listRefeicao6.add(alimento);
        registerMeals.registerSharedPreferences(listRefeicao6, 6);
        SuccessDialog(context, 'O alimento ${alimento.alimento} foi adicionado a refeição 6 com sucesso!');
      }
    }

    void refresh() async{
      SharedPreferences.getInstance().then((prefs) {
        String? firstName = prefs.getString('first_name');
        String? lastName = prefs.getString('last_name');
        String? refeicao1 = prefs.getString('refeicao1');
        String? refeicao2 = prefs.getString('refeicao2');
        String? refeicao3 = prefs.getString('refeicao3');
        String? refeicao4 = prefs.getString('refeicao4');
        String? refeicao5 = prefs.getString('refeicao5');
        String? refeicao6 = prefs.getString('refeicao6');
        List<BuscaAlimento> listMeal = [];

        if (refeicao1 != null){
          String meal = '';
          for(String a in refeicao1.split('')){
            if(a != '}'){
              meal += a;
            } else if (a == '}') {
              meal += a;
              BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
              listRefeicao1.add(alimento);
              meal = '';
            }
          }
        }
        if (refeicao2 != null){
          String meal = '';
          for(String a in refeicao2.split('')){
            if(a != '}'){
              meal += a;
            } else if (a == '}') {
              meal += a;
              BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
              listRefeicao2.add(alimento);
              meal = '';
            }
          }
        }
        if (refeicao3 != null){
          String meal = '';
          for(String a in refeicao3.split('')){
            if(a != '}'){
              meal += a;
            } else if (a == '}') {
              meal += a;
              BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
              listRefeicao3.add(alimento);
              meal = '';
            }
          }
        }
        if (refeicao4 != null){
          String meal = '';
          for(String a in refeicao4.split('')){
            if(a != '}'){
              meal += a;
            } else if (a == '}') {
              meal += a;
              BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
              listRefeicao4.add(alimento);
              meal = '';
            }
          }
        }
        if (refeicao5 != null){
          String meal = '';
          for(String a in refeicao5.split('')){
            if(a != '}'){
              meal += a;
            } else if (a == '}') {
              meal += a;
              BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
              listRefeicao5.add(alimento);
              meal = '';
            }
          }
        }
        if (refeicao6 != null){
          String meal = '';
          for(String a in refeicao6.split('')){
            if(a != '}'){
              meal += a;
            } else if (a == '}') {
              meal += a;
              BuscaAlimento alimento = BuscaAlimento.fromMap(json.decode(meal));
              listRefeicao6.add(alimento);
              meal = '';
            }
          }
        }

        //if (firstName != null && lastName != null) {
        //  email = firstName;
        //} else {
        //  Navigator.pushReplacementNamed(context, 'login');
        //}
      });}

  }

