import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_plain_no_gain/models/busca_alimento.dart';
import 'package:no_plain_no_gain/screens/common_screen/message_dialog.dart';
import 'package:no_plain_no_gain/screens/common_screen/portion_dialog.dart';
import 'package:no_plain_no_gain/screens/common_screen/success_dialog.dart';
import 'package:no_plain_no_gain/screens/common_screen/yes_no_dialog.dart';
import 'package:no_plain_no_gain/screens/home_screen/home_screen.dart';
import 'package:no_plain_no_gain/services/busca_alimento_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CreateListMeal extends StatefulWidget {
  final BuscaAlimento? meal;
  final int? itemMap;
  final Map<int, BuscaAlimento>? refeicao;
  final bool? createEmptyTile;
  final int? mealNumber;

  const CreateListMeal({
    Key? key,
    this.meal,
    this.itemMap,
    this.refeicao,
    this.createEmptyTile,
    this.mealNumber,
  }) : super(key: key);

  @override
  State<CreateListMeal> createState() => _CreateListMealState();
}

class _CreateListMealState extends State<CreateListMeal> {
  BuscaAlimentoService registerMeals = BuscaAlimentoService();
  List<BuscaAlimento> listRefeicao = [];
  List<BuscaAlimento> listRefeicao1 = [];
  List<BuscaAlimento> listRefeicao2 = [];
  List<BuscaAlimento> listRefeicao3 = [];
  List<BuscaAlimento> listRefeicao4 = [];
  List<BuscaAlimento> listRefeicao5 = [];
  List<BuscaAlimento> listRefeicao6 = [];
  bool yesNoExclude = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.createEmptyTile!) {
      if (widget.meal!.alimento != '') {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(7),
                flex: 2,
                onPressed: bringAlterFood,
                icon: Icons.change_circle_outlined,
                backgroundColor: Colors.amber,
                label: "Alterar",
              ),
            ],
          ),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(7),
                flex: 2,
                onPressed: bringMessage,
                icon: Icons.list_alt_rounded,
                backgroundColor: Colors.greenAccent,
                label: "Visualizar",
              ),
            ],
          ),
          child: ListTile(
              title: GestureDetector(
                onTap: () {
                  messageDialog(
                      context,
                      'Alimento: ${widget.meal!.alimento}\n'
                      'Porção: ${widget.meal!.porcao}\n'
                      'Calorias: ${widget.meal!.calorias} kcal\n'
                      'Proteinas: ${widget.meal!.proteinas} gr\n'
                      'Carboidratos: ${widget.meal!.carboidratos} gr\n'
                      'Gorduras: ${widget.meal!.gorduras} gr');
                },
                onLongPress: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  PortionDialog(context, 'message', widget.meal!)
                      .then((valueReturnDialog) async {
                    BuscaAlimento newFoodPortion = valueReturnDialog;
                    if (newFoodPortion.alimento != '') {
                      alterMeal(
                          refeicao: widget.refeicao!,
                          itemExcludeMap: widget.itemMap!,
                          alterAlimento: newFoodPortion);
                      await SuccessDialog(
                          context, 'Alimento alterado com sucesso!');
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(
                            selectedIndex: 1,
                          ),
                        ),
                      );
                    }
                  });
                },
                child: Text(
                  '${widget.meal!.alimento} - ${widget.meal!.porcao}',
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.highlight_remove_outlined),
                onPressed: () async {
                  await yesNoDialog(context, 'Deseja excluir esse alimento?')
                      .then((valueReturnDialog) {
                    yesNoExclude = valueReturnDialog;
                  });
                  if (yesNoExclude) {
                    excludeMeal(
                      refeicao: widget.refeicao!,
                      itemExcludeMap: widget.itemMap!,
                    );
                    await SuccessDialog(
                        context, 'Alimento removido com sucesso!');
                  }
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                        selectedIndex: 1,
                      ),
                    ),
                  );
                },
              )),
        );
      } else {
        return ListTile(
          title: Text(
            'Nenhum alimento nessa refeição',
            style: GoogleFonts.acme(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        );
      }
    } else {
      return ListTile(
        title: Text(
          'Nenhum alimento nessa refeição',
          style: GoogleFonts.acme(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      );
    }
  }

  void excludeMeal(
      {required Map<int, BuscaAlimento> refeicao,
      required int itemExcludeMap}) {
    setState(() {
      refeicao.remove(itemExcludeMap);
    });
    if (widget.mealNumber != null) {
      refeicao.forEach((key, value) {
        listRefeicao.add(value);
        registerMeals.registerSharedPreferences(
            listRefeicao, widget.mealNumber!);
      });
    }
    if (refeicao.isEmpty) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.remove('refeicao${widget.mealNumber}');
      });
    }
  }

  void alterMeal(
      {required Map<int, BuscaAlimento> refeicao,
      required int itemExcludeMap,
      required BuscaAlimento alterAlimento}) {
    if (widget.mealNumber != null) {
      refeicao.forEach((key, value) {
        if (value.alimento == alterAlimento.alimento ||
            value.porcao == alterAlimento.porcao) {
          listRefeicao.add(alterAlimento);
          registerMeals.registerSharedPreferences(
              listRefeicao, widget.mealNumber!);
        } else {
          listRefeicao.add(value);
          registerMeals.registerSharedPreferences(
              listRefeicao, widget.mealNumber!);
        }
      });
    }
    if (refeicao.isEmpty) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.remove('refeicao${widget.mealNumber}');
      });
    }
  }

  void bringMessage(BuildContext buildContext) {
    messageDialog(
        context,
        'Alimento: ${widget.meal!.alimento}\n'
        'Porção: ${widget.meal!.porcao}\n'
        'Calorias: ${widget.meal!.calorias} kcal\n'
        'Proteinas: ${widget.meal!.proteinas} gr\n'
        'Carboidratos: ${widget.meal!.carboidratos} gr\n'
        'Gorduras: ${widget.meal!.gorduras} gr');
  }

  void bringAlterFood(BuildContext buildContext) {
    FocusScope.of(context).requestFocus(FocusNode());
    PortionDialog(context, 'message', widget.meal!)
        .then((valueReturnDialog) async {
      BuscaAlimento newFoodPortion = valueReturnDialog;
      if (newFoodPortion.alimento != '') {
        alterMeal(
            refeicao: widget.refeicao!,
            itemExcludeMap: widget.itemMap!,
            alterAlimento: newFoodPortion);
        await SuccessDialog(context, 'Alimento alterado com sucesso!');
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(
              selectedIndex: 1,
            ),
          ),
        );
      }
    });
  }
}
