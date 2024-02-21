import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hero_games_assingment/init/core/iaccount_service_repository.dart';
import 'package:hero_games_assingment/init/repository/user_repository.dart';
import 'package:hero_games_assingment/init/util/routes.dart';

import '../models/reqister_model.dart';
import '../util/toast_messenger.dart';

class AccountService extends IAccountServiceRepository<RegisterModel> {
  AccountService(super.context);

  @override
  Future passwordReset(String email) async {
    await auth.sendPasswordResetEmail(email: email).then((value) {
      ToastMessenger.instance.showToastMessage(
          "Şifrenizi sıfırlamanız için kurtarma maili başarıyla gönderildi!");
      Navigator.pop(context);
    }).catchError((e) {
      ToastMessenger.instance
          .showToastMessage(e.message.toString(), isError: true);
    });
  }

  @override
  Future register(RegisterModel model) async {
    await auth
        .createUserWithEmailAndPassword(
      email: model.email,
      password: model.password,
    )
        .then((value) async {
      await UserRepository(context)
          .add(model)
          .then((value) => Navigator.pop(context));
    }).catchError((e) {
      log("Register Errors: ${e.message}");
      ToastMessenger.instance
          .showToastMessage(e.message.toString(), isError: true);
      return e.message;
    });
  }

  @override
  Future<String?> signInwithEmail(String email, String pass) async {
    await auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      Navigator.pushReplacementNamed(context, "/homepage");
    }).catchError((e) {
      log("Sign in Error: ${e.message}");
      ToastMessenger.instance
          .showToastMessage(e.message.toString(), isError: true);
    });
    return null;
  }

  @override
  Future signOut() {
    return auth.signOut().then((value) {
      Navigator.pushReplacementNamed(context, PageRoutes.login);
    }).catchError((e) {
      log("Sign out Error: ${e.message}");
      ToastMessenger.instance
          .showToastMessage(e.message.toString(), isError: true);
    });
  }
}
