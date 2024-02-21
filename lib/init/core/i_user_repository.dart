import 'package:flutter/material.dart';
import 'package:hero_games_assingment/init/models/user_model.dart';

import 'ibase_repository.dart';

abstract class IUserRepository<T> extends IBaseRepository<T> {
  IUserRepository(BuildContext context) : super(context);

  Future<void> getAll();
  Future<void> get();
  Stream<void> getStream(String docID);
  Future<void> add(item);
  Future<void> update(UserModel userModel);
  Future<void> delete(T item);
}
