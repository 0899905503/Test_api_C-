import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PizzaViewModel extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }

  List<dynamic> _RelativeData = [];

  List<dynamic> get userData => _RelativeData;

  void setUserData(List<dynamic> data) {
    _RelativeData = data;
    notifyListeners();
  }
}
