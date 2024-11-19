import 'dart:convert';
import 'dart:io';
import 'package:no_plain_no_gain/models/busca_alimento.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'web_client.dart';

class BuscaAlimentoService {
  http.Client client = WebClient().client;

  Future<List<BuscaAlimento>> getAlimento(String alimento) async {
    String user = await getUser();
    String password = await getPassword();
    final bytes = utf8.encode('$user:$password');
    final base64Str = base64.encode(bytes);
    http.Response response = await client.get(
      Uri.parse("${WebClient.url}busca_alimento/$alimento"),
      headers: {
        'Content-type': 'application/json',
        //'Authorization': 'Basic $base64Str',
      },
    );

    if (response.statusCode != 200) {
      verifyException(json.decode(response.body));
    }

    List<BuscaAlimento> result = [];

    List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

    for (var jsonMap in jsonList) {
      result.add(BuscaAlimento.fromMap(jsonMap));
    }

    return result;
  }

  Future<bool> registerSharedPreferences(List<BuscaAlimento> listMeal, int mealNumber) async {
    String mealJSON = '';
    for (BuscaAlimento meal in listMeal){
      mealJSON += json.encode(meal.toMap());
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refeicao$mealNumber', mealJSON);
    return true;
  }

  Future<List<BuscaAlimento>> getMealSharedPreferences(String meal) async {
    List<BuscaAlimento> result = [];

    List<dynamic> jsonList = json.decode(meal);

    for (var jsonMap in jsonList) {
      result.add(BuscaAlimento.fromMap(jsonMap));
    }

    return result;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    if (token != null) {
      return token;
    }
    return '';
  }

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('id');
    if (user != null) {
      return user;
    }
    return '';
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = prefs.getString('password');
    if (password != null) {
      return password;
    }
    return '';
  }

  verifyException(String error) {
    switch (error) {
      case 'jwt expired':
        throw TokenExpiredException();
      case 'Nao Cadastrado':
        throw NaoCadastradoException();
    }

    throw HttpException(error);
  }
}

class TokenExpiredException implements Exception {}

class NaoCadastradoException implements Exception {}