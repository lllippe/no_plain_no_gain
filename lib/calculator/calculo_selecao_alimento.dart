import 'package:no_plain_no_gain/models/busca_alimento.dart';

BuscaAlimento calculaSelecaoAlimento(String porcao, BuscaAlimento meal){
  double porcaoNumber = double.parse(porcao);
  String trasitionPortion = meal.porcao;
  double porcaoNumberMeal = cleanPortionType(trasitionPortion);
  String alimentoText = meal.alimento;
  double proteinasNumber = double.parse((meal.proteinas.contains(','))
      ? meal.proteinas.replaceAll(',', '.')
      : meal.proteinas);
  double carboidratosNumber = double.parse((meal.carboidratos.contains(','))
      ? meal.carboidratos.replaceAll(',', '.')
      : meal.carboidratos);
  double gordurasNumber = double.parse((meal.gorduras.contains(','))
      ? meal.gorduras.replaceAll(',', '.')
      : meal.gorduras);
  double caloriasNumber = double.parse((meal.calorias.contains(','))
      ? meal.calorias.replaceAll(',', '.')
      : meal.calorias);
  double mealPortionRate = porcaoNumber/porcaoNumberMeal;
  double proteinasNew = proteinasNumber * mealPortionRate;
  double carboidratosNew = carboidratosNumber * mealPortionRate;
  double gordurasNew = gordurasNumber * mealPortionRate;
  double caloriasNew = caloriasNumber * mealPortionRate;

  BuscaAlimento alimento = BuscaAlimento(
      alimento: alimentoText,
      porcao: porcaoNumber.toStringAsFixed(2).contains('.')
          ? porcaoNumber.toStringAsFixed(2).replaceAll('.', ',')
          : porcaoNumber.toStringAsFixed(2),
      calorias: caloriasNew.toStringAsFixed(2).contains('.')
          ? caloriasNew.toStringAsFixed(2).replaceAll('.', ',')
          : caloriasNew.toStringAsFixed(2),
      gorduras: gordurasNew.toStringAsFixed(2).contains('.')
          ? gordurasNew.toStringAsFixed(2).replaceAll('.', ',')
          : gordurasNew.toStringAsFixed(2),
      carboidratos: carboidratosNew.toStringAsFixed(2).contains('.')
          ? carboidratosNew.toStringAsFixed(2).replaceAll('.', ',')
          : carboidratosNew.toStringAsFixed(2),
      proteinas: proteinasNew.toStringAsFixed(2).contains('.')
          ? proteinasNew.toStringAsFixed(2).replaceAll('.', ',')
          : proteinasNew.toStringAsFixed(2));

  return alimento;
}

double cleanPortionType(String trasitionPortion) {
  double cleanPortionMeal = 0;
  String treatPortion = trasitionPortion;
  String portionMeal = '';
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  for(String a in treatPortion.split('')){
    if (numericRegex.hasMatch(a) || a == ','){
      portionMeal += a;
    }
  }

  cleanPortionMeal = double.parse((portionMeal.contains(','))
      ? portionMeal.replaceAll(',', '.')
      : portionMeal);

  return cleanPortionMeal;
}