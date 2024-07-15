import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends ChangeNotifier {
  final BehaviorSubject<String> _usernameSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();
  final BehaviorSubject<bool> _loginSubject = BehaviorSubject<bool>();

  final StreamController<String> _usernameController =
      StreamController<String>();
  final StreamController<String> _passwordController =
      StreamController<String>();
  final StreamController<bool> _loginController = StreamController<bool>();

  Stream<String> get usernameStream => _usernameSubject.stream;
  Sink<String> get usernameSink => _usernameSubject.sink;

  Stream<String> get passwordStream => _passwordSubject.stream;
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get loginStream => _loginSubject.stream;
  Sink<bool> get loginSink => _loginSubject.sink;

  Future<dynamic> signin(dynamic data) async {
    try {
      print('Sending request with data: $data');
      http.Response response = await http
          .post(
            Uri.parse("http://localhost:5014/api/Auth/login"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 10));

      //  print('Received response: ${response.body}');

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        return responseData;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  LoginViewModel() {
    // Khi username hoặc password thay đổi, kiểm tra và cập nhật loginStream
    Stream<bool> loginStream = Rx.combineLatest2(usernameStream, passwordStream,
        (String username, String password) {
      return username?.isNotEmpty == true && password?.isNotEmpty == true;
    });
    loginStream.listen((enable) {
      loginSink.add(enable);
    });
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _loginController.close();
  }
}
