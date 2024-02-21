import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hero_games_assingment/init/core/i_user_repository.dart';
import 'package:hero_games_assingment/init/models/user_model.dart';

class UserRepository extends IUserRepository {
  static const String _collectionName = "users";

  UserRepository(super.context);

  @override
  Future add(item) async {
    await firestore
        .collection(_collectionName)
        .doc(user?.uid)
        .set(item.toJson())
        .catchError((e) {
      e.logger();
    });
  }

  @override
  Future delete(item) async {
    await firestore.collection(_collectionName).doc(currentUserID).delete();
  }

  @override
  Future get() async {
    final DocumentSnapshot documentSnapshot =
        await firestore.collection(_collectionName).doc(currentUserID).get();

    //  UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

    return documentSnapshot.data();
  }

  @override
  Future getAll() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection(_collectionName).get();
    for (var doc in querySnapshot.docs) {
      log(doc.data().toString());
    }
  }

  @override
  Future<void> update(UserModel userModel) async {
    await firestore
        .collection(_collectionName)
        .doc(currentUserID)
        .set(userModel.toJson());
  }

  @override
  Stream getStream(String docID) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> documentSnapshot =
        firestore.collection(_collectionName).doc(currentUserID).get();
    return documentSnapshot.asStream();
  }
}
