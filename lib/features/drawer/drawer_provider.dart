import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DrawerProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<dynamic> _articleList = [];

  List<dynamic> get articleList => _articleList;

  set articlesList(List<dynamic> value) {
    _articleList = value;
    notifyListeners();
  }

}