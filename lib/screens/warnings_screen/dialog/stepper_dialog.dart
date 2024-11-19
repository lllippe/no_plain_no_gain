import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/screens/add_screen/add_user_mesure_screen.dart';

Future<dynamic> stepperDialog(BuildContext context, double width_screen, double heigth_screen,) {
  int _index = 0;
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog.fullscreen(
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _index,
          onStepCancel: () {
            if (_index > 0) {
                _index -= 1;
            }
          },
          onStepContinue: () {
              _index += 1;
          },
          steps: [
            Step(
              title: const Text('Primeiro passo'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [const Text('Preencher seus dados no aplicativo.'),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 13,
                        bottom: 13,
                      ),
                      child: InkWell(
                        child: const Text(
                          'Clique aqui para inserir seus dados',
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

