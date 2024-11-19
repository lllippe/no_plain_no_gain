import 'package:flutter/material.dart';
import 'package:no_plain_no_gain/screens/home_screen/home_screen.dart';
import 'package:no_plain_no_gain/screens/login_screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No plan No gain',
      home: const HomeScreen(selectedIndex: 0,),
      initialRoute: "login",
      routes: {
        "login": (context) => const LoginScreen(),
        "home": (context) => const HomeScreen(
          selectedIndex: 0,
        ),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light,
      //home: const MyHomePage(title: 'Busca Alimento'),
    );
  }
}

