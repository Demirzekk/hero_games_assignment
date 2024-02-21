import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

abstract class IBaseRepository<T> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final User? user;
  late final String currentUserID;
  late final BuildContext context;
  UserModel userModel = UserModel();

  IBaseRepository(ctx) {
    context = ctx;
    user = auth.currentUser;
    currentUserID = user?.uid ?? "null";
    log("Current User ID: $currentUserID");
  }
}
