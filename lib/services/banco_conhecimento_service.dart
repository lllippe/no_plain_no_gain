import 'dart:convert';
import 'dart:io';
import 'package:no_plain_no_gain/models/banco_conhecimento.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'web_client.dart';

class BancoConhecimentoService {
  http.Client client = WebClient().client;

  Future<List<BancoConhecimento>> getAll() async {
    String user = await getUser();
    String password = await getPassword();
    final bytes = utf8.encode('$user:$password');
    final base64Str = base64.encode(bytes);
    http.Response response = await client.get(
      Uri.parse("${WebClient.url}banco_conhecimento"),
      headers: {
        'Content-type': 'application/json',
        //'Authorization': 'Basic $base64Str',
      },
    );

    if (response.statusCode != 200) {
      verifyException(json.decode(response.body));
    }

    List<BancoConhecimento> result = [];

    List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

    for (var jsonMap in jsonList) {
      result.add(BancoConhecimento.fromMap(jsonMap));
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