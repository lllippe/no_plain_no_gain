import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class Warning extends StatefulWidget {
  final double width_screen;
  final double heigth_screen;

  const Warning(
      {super.key, required this.width_screen, required this.heigth_screen});

  @override
  State<Warning> createState() => WarningState();
}

class WarningState extends State<Warning> with TickerProviderStateMixin {
  int selectedPage = 0;
  bool _isloading = false;
  bool _userDataOnApp = false;
  int _index = 0;
  String cardString = '';

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    double width_screen = deviceData.size.width;
    return Scrollbar(
      thumbVisibility: true,
      thickness: 10,
      radius: const Radius.circular(5),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 18.0, bottom: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fitness_center_outlined,
                        size: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          'Seja bem vindo!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.food_bank_rounded,
                        size: 50,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width_screen - 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.greenAccent, width: 2),
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
                      child: const Text(
                        'Para adicionar uma nova dieta, você deve inserir '
                        'suas medidas na aba "Minhas dietas!"',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.looks_one,
                            color: Colors.greenAccent,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.south_outlined,
                        color: Colors.greenAccent,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.looks_two,
                            color: Colors.black,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: width_screen - 80,
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
                        child: const Text(
                          'Após a inclusão das suas medidas, escolha'
                          ' seu objetivo (Manutenção, hipertrofia ou emagrecimento)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.south_outlined,
                        color: Colors.black,
                        size: 35,
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
                        width: width_screen - 80,
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
                        child: const Text(
                          'Insira os alimentos que deseja em cada refeição'
                          ' e vá acompanhando a quantidade de calorias que precisa atingir'
                          ' no dia!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.looks_3,
                            color: Colors.greenAccent,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.south_outlined,
                        color: Colors.greenAccent,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.looks_4,
                            color: Colors.black,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: width_screen - 80,
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
                        child: const Text(
                          'Pronto, sua dieta está montada! Você pode verificar'
                          ' a divisão dos macros da sua dieta no gráfico, verificar o total de calorias'
                          ' e macros de cada refeição, clicando em cima da refeição e ver o total de calorias'
                          ' e macros de cada alimento clicando em cima de cada alimento dentro das refeições.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.south_outlined,
                        color: Colors.black,
                        size: 35,
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
                        width: width_screen - 80,
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
                        child: const Text(
                          'Se houver alguma dúvida, clique nos três traços do lado esquerdo '
                              'do título "No plan, no gain!" e clique em "Banco de conhecimento"'
                              ' para maior explicação de como usar o aplicativo!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.looks_5,
                            color: Colors.greenAccent,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.south_outlined,
                        color: Colors.greenAccent,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.tag_faces,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  void refresh() async {
    SharedPreferences.getInstance().then((prefs) {
      double? userPeso = prefs.getDouble('peso');
      double? userAltura = prefs.getDouble('altura');
      int? userIdade = prefs.getInt('idade');
      String? userActivity = prefs.getString('activity');
      double? userGordura = prefs.getDouble('gordura');
      String? userSex = prefs.getString('sexo');

      if (userPeso != null &&
          userAltura != null &&
          userIdade != null &&
          userActivity != null &&
          userSex != null) {
        _userDataOnApp = true;
        cardString = 'Peso: $userPeso\n'
            'Altura: $userAltura\n'
            'Idade: $userIdade\n'
            'Frequência atividade: $userActivity\n'
            '% Gordura: $userGordura\n'
            'Sexo: $userSex';
      }
    });
  }
}
