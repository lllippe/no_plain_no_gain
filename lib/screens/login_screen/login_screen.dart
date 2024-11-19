import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //final AuthService authService = AuthService();
  bool _passwordVsible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        margin: const EdgeInsets.all(16),
        //decoration:
        //BoxDecoration(border: Border.all(width: 8), color: Colors.white),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    child: Icon(
                      Icons.food_bank_rounded,
                      color: Colors.greenAccent,
                      size: 250,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      'No Plan, No Gain',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(fontSize: 30),
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("por FrPelissari",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.amber)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, right: 8, left: 8, bottom: 15),
                    child: Divider(
                      thickness: 2,
                      color: Colors.greenAccent,
                    ),
                  ),
                  //const Text("Entre"),
                  //TextFormField(
                  //  controller: _emailController,
                  //  decoration: const InputDecoration(
                  //    label: Text("Usuário"),
                  //  ),
                  //  keyboardType: TextInputType.text,
                  //),
                  //TextFormField(
                  //  controller: _passwordController,
                  //  decoration: InputDecoration(
                  //    label: const Text("Senha"),
                  //    suffixIcon: IconButton(
                  //      onPressed: () {
                  //        setState(() {
                  //         _passwordVsible = !_passwordVsible;
                  //       });
                  //     },
                  //     icon: Icon(
                  //       _passwordVsible
                  //           ? Icons.visibility
                  //           : Icons.visibility_off,
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),
                  // keyboardType: TextInputType.visiblePassword,
                  // maxLength: 16,
                  // obscureText: _passwordVsible
                  //     ? false
                  //     : true,
                  //),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.greenAccent),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      //tryLogin(context);
                      Navigator.pushReplacementNamed(context, 'home');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 9, top: 9, right: 50, left: 50),
                      child: Text(
                        'Entrar',
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(fontSize: 30),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeVisible(BuildContext context) {
    _passwordVsible = !_passwordVsible;
  }

//void tryLogin(BuildContext context) {
//  String email = _emailController.text;
//  String password = _passwordController.text;

//  authService.login(email, password).then((token) {
//    Navigator.pushReplacementNamed(context, 'transfer');
//  }).catchError((e) {
//    ErrorDialog(context, 'Usuário não cadastrado');
//  }, test: (e) => e is UserNotFoundException).catchError((e) {
//    showExceptionDialog(context,
//        content:
//        "O servidor demorou para responder, tente novamente mais tarde.");
//  }, test: (e) => e is TimeoutException);
// }
}
