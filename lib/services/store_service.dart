import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:no_plain_no_gain/models/store.dart';
import 'package:no_plain_no_gain/models/store_ramo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'web_client.dart';

class StoreService {
  http.Client client = WebClient().client;

  Future<List<Store>> getAll() async {
    String user = await getUser();
    String password = await getPassword();
    final bytes = utf8.encode('$user:$password');
    final base64Str = base64.encode(bytes);
    http.Response response = await client.get(
      Uri.parse("${WebClient.url}store"),
      headers: {
        'Content-type': 'application/json',
        //'Authorization': 'Basic $base64Str',
      },
    );

    if (response.statusCode != 200) {
      verifyException(json.decode(response.body));
    }

    List<Store> result = [];

    List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

    for (var jsonMap in jsonList) {
      result.add(Store.fromMap(jsonMap));
    }

    return result;
  }

  Future<List<StoreRamo>> getRamo() async {
    String user = await getUser();
    String password = await getPassword();
    final bytes = utf8.encode('$user:$password');
    final base64Str = base64.encode(bytes);
    http.Response response = await client.get(
      Uri.parse("${WebClient.url}store_ramo"),
      headers: {
        'Content-type': 'application/json',
        //'Authorization': 'Basic $base64Str',
      },
    );

    if (response.statusCode != 200) {
      verifyException(json.decode(response.body));
    }

    List<StoreRamo> result = [];

    List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

    for (var jsonMap in jsonList) {
      result.add(StoreRamo.fromMap(jsonMap));
    }

    return result;
  }

  Future<bool> edit(int id, Store store) async {
    String storeJSON = json.encode(store.toMap());

    http.Response response = await client.put(
      Uri.parse("${WebClient.url}store/$id/"),
      headers: {
        'Content-type': 'application/json',
        //'Authorization': 'Bearer $token',
      },
      body: storeJSON,
    );

    if (response.statusCode != 200) {
      verifyException(json.decode(response.body));
    }

    return true;
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