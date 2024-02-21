import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessenger {
  static ToastMessenger? _instance;

  ToastMessenger._();

  factory ToastMessenger() => _instance ??= ToastMessenger._();
  //Lazy Singleton
  static ToastMessenger get instance => _instance ??= ToastMessenger._();

  showToastMessage(
    String msg, {
    Color color = Colors.black87,
    bool isError = false,
  }) async {
    await Fluttertoast.cancel();

    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: isError == true ? Colors.red : color);
  }
}
