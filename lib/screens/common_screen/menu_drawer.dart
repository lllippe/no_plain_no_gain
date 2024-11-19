import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/screens/login_screen/login_screen.dart';
import 'package:no_plain_no_gain/screens/video_player_screen/video_player_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String email = '';
String userGroup = '';

ListView menuDrawer(BuildContext context) {
  void returnHome() async {
    SharedPreferences.getInstance().then((prefs) {
      String? group = prefs.getString('group');
      String? user = prefs.getString('first_name');

      if (group != null && user != null) {
        //if (group == '1') { --> estava comentado
          //Navigator.pop(context);
          //Navigator.push(
            //context,
            //MaterialPageRoute(
              //builder: (context) =>
                  //HomeScreen(
                  //  selectedIndex: 0,
                  //  name: user,
                  //  userGroup: group,
                  //),
            //),
          //);
        //} else {
        //  Navigator.pushReplacementNamed(context, 'home');
        //}
      } else {
        Navigator.pushReplacementNamed(context, 'home');
      }
    });
  }
  refresh();

  return ListView(
    children: [
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Home'),
        onTap: () {
          returnHome();
          //Navigator.pushReplacementNamed(context, 'home');
        },
      ),
      ListTile(
        leading: const Icon(Icons.laptop_chromebook_rounded),
        title: const Text('Banco de conhecimento'),
        onTap: () {Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VideoApp(),
          ),
        );
          //Navigator.pushReplacementNamed(context, 'home');
        },
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text("Sair"),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
          //logout(context);
        },
      )
    ],
  );
}

void refresh() async {
  await SharedPreferences.getInstance().then(
    (prefs) {
      String? email_prefs = prefs.getString('first_name');
      String? group = prefs.getString('group');

      if (email_prefs != null) {
        email = email_prefs;
      }
      if (group != null) {
        userGroup = group;
      }
    },
  );
}


