import 'package:shared_preferences/shared_preferences.dart';

String calculoMetabolismo(double pesoController,
                        double alturaController,
                        int idadeController,
                        String activitySelected,
                        double pGorduraController,
                        String sexSelected) {
  double height = alturaController;
  int age = idadeController;
  double weight = pesoController;
  String sex = sexSelected;
  double percentualGordura = pGorduraController;
  double weeklyActivity = 0.0;
  double katchMcardle = 0.0;
  double cunningham = 0.0;
  double tinsley = 0.0;
  double harrisBenedict = 0.0;
  double mifflinStJeor = 0.0;
  List<int> tmb = [];
  List<int> gcd = [];
  String usedFormula = '';
  String returnResult = '';

  if (activitySelected == 'Sedentário') {
    weeklyActivity = 1.2;
  } else if (activitySelected == 'Leve(1-2x na semana)') {
    weeklyActivity = 1.375;
  } else if (activitySelected == 'Moderado(3-5x na semana)') {
    weeklyActivity = 1.55;
  } else if (activitySelected == 'Pesado(6-7x na semana)') {
    weeklyActivity = 1.725;
  } else if (activitySelected == 'Atleta(2x por dia)') {
    weeklyActivity = 1.9;
  }

  if (sex == 'Masculino') {
    if (percentualGordura > 0) {
      cunningham = ((22 * (weight * (100 - percentualGordura) / 100)) + 500);
      tinsley = ((25.9 * (weight * (100 - percentualGordura) / 100)) + 284);
      katchMcardle = 370  + (21.6 * (weight * (100 - percentualGordura) / 100));
      tmb.add(cunningham.round());
      tmb.add(tinsley.round());
      tmb.add(katchMcardle.round());
      gcd.add((cunningham * weeklyActivity).round());
      gcd.add((tinsley * weeklyActivity).round());
      gcd.add((katchMcardle * weeklyActivity).round());
      tmb.sort();
      gcd.sort();
      if(tmb[1] == cunningham.round()) {
        usedFormula = 'Método utilizado: Cunningham';
      } else if (tmb[1] == tinsley.round()) {
        usedFormula = 'Método utilizado: Tinsley';
      } else if (tmb[1] == katchMcardle.round()) {
        usedFormula = 'Método utilizado: Katch-Mcardle';
      }
      saveUserMesures(tmb[1], gcd[1], usedFormula);
    } else {
      katchMcardle = 370  + (21.6 * ((0.407 * weight) + (0.267 * height) - 19.2));
      harrisBenedict = (66.5 + (13.75 * weight) + (5.003 * height) - (6.775 * age));
      mifflinStJeor = ((10 * weight) + (6.25 * height) - (5 * age) + 5);
      tmb.add(harrisBenedict.round());
      tmb.add(mifflinStJeor.round());
      tmb.add(katchMcardle.round());
      gcd.add((harrisBenedict * weeklyActivity).round());
      gcd.add((mifflinStJeor * weeklyActivity).round());
      gcd.add((katchMcardle * weeklyActivity).round());
      tmb.sort();
      gcd.sort();
      if(tmb[1] == harrisBenedict.round()) {
        usedFormula = 'Método utilizado: Harris-Benedict';
      } else if (tmb[1] == mifflinStJeor.round()) {
        usedFormula = 'Método utilizado: Mifflin-St. Jeor';
      } else if (tmb[1] == katchMcardle.round()) {
        usedFormula = 'Método utilizado: Katch-Mcardle';
      }
      saveUserMesures(tmb[1], gcd[1], usedFormula);
    }
  } else {
    if (percentualGordura > 0) {
      cunningham = ((22 * (weight * (100 - percentualGordura) / 100)) + 500);
      tinsley = ((25.9 * (weight * (100 - percentualGordura) / 100)) + 284);
      katchMcardle = 370  + (21.6 * (weight * (100 - percentualGordura) / 100));
      tmb.add(cunningham.round());
      tmb.add(tinsley.round());
      tmb.add(katchMcardle.round());
      gcd.add((cunningham * weeklyActivity).round());
      gcd.add((tinsley * weeklyActivity).round());
      gcd.add((katchMcardle * weeklyActivity).round());
      tmb.sort();
      gcd.sort();
      if(tmb[1] == cunningham.round()) {
        usedFormula = 'Método utilizado: Cunningham';
      } else if (tmb[1] == tinsley.round()) {
        usedFormula = 'Método utilizado: Tinsley';
      } else if (tmb[1] == katchMcardle.round()) {
        usedFormula = 'Método utilizado: Katch-Mcardle';
      }
      saveUserMesures(tmb[1], gcd[1], usedFormula);
    } else {
      harrisBenedict = (655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age));
      katchMcardle = 370 + (21.6 * ((0.252 * weight) + (0.473 * height) - 48.3));
      mifflinStJeor = ((10 * weight) + (6.25 * height) - (5 * age) - 161);
      tmb.add(harrisBenedict.round());
      tmb.add(mifflinStJeor.round());
      tmb.add(katchMcardle.round());
      gcd.add((harrisBenedict * weeklyActivity).round());
      gcd.add((mifflinStJeor * weeklyActivity).round());
      gcd.add((katchMcardle * weeklyActivity).round());
      tmb.sort();
      gcd.sort();
      if(tmb[1] == harrisBenedict.round()) {
        usedFormula = 'Método utilizado: Harris-Benedict';
      } else if (tmb[1] == mifflinStJeor.round()) {
        usedFormula = 'Método utilizado: Mifflin-St. Jeor';
      } else if (tmb[1] == katchMcardle.round()) {
        usedFormula = 'Método utilizado: Katch-Mcardle';
      }
      saveUserMesures(tmb[1], gcd[1], usedFormula);
    }
  }

  returnResult = 'Taxa metabólica basal:\n'
      '${katchMcardle.round() == 0 ? '' : 'Katch-Mcardle: ${katchMcardle.round()} Kcal\n'}'
      '${harrisBenedict.round() == 0 ? '' : 'Harris-Benedict: ${harrisBenedict.round()} Kcal\n'}'
      '${cunningham.round() == 0 ? '' : 'Cunningham: ${cunningham.round()} Kcal\n'}'
      '${tinsley.round() == 0 ? '' : 'Tinsley: ${tinsley.round()} Kcal\n'}'
      '${mifflinStJeor.round() == 0 ? '' : 'Mifflin St Jeor: ${mifflinStJeor.round()} Kcal\n'}'
      'Gasto Calórico total:\n'
      '${katchMcardle.round() == 0 ? '' : 'Katch-Mcardle - $activitySelected: ${(katchMcardle * weeklyActivity).round()} Kcal\n'}'
      '${harrisBenedict.round() == 0 ? '' : 'Harris-Benedict - $activitySelected: ${(harrisBenedict * weeklyActivity).round()} Kcal\n'}'
      '${cunningham.round() == 0 ? '' : 'Cunningham - $activitySelected: ${(cunningham * weeklyActivity).round()} Kcal\n'}'
      '${tinsley.round() == 0 ? '' : 'Tinsley - $activitySelected: ${(tinsley * weeklyActivity).round()} Kcal\n'}'
      '${mifflinStJeor.round() == 0 ? '' : 'Mifflin St Jeor - $activitySelected: ${(mifflinStJeor * weeklyActivity).round()} Kcal\n'}';

  return returnResult;
}

void saveUserMesures(int tmb, int gcd, String formula) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('tmb', tmb);
  prefs.setInt('gcd', gcd);
  prefs.setString('formula', formula);
}