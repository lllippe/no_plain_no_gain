import 'package:flutter/material.dart';

Future<dynamic> messageDialog(BuildContext context, String messageToShow) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 25,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 10,
          radius: const Radius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(messageToShow),
          ),
        ),
      );
    },
  );
}

