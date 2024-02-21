import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../init/models/user_model.dart';
 

abstract class IBaseRepository<T> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  late final String currentUserID;

  IBaseRepository() {
    user = FirebaseAuth.instance.currentUser;
    currentUserID = user?.uid ?? "";
    log("Current User ID: $currentUserID");
  }
  Future<void> getAll();
  Future<void> get();
  Stream<void> getStream(String docID);
  Future<void> add(T item);
  Future<void> update(UserModel item);
  Future<void> delete(T item);
}
