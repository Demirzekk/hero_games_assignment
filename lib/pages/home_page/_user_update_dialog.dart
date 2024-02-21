import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hero_games_assingment/init/extension/extensions.dart';
import 'package:hero_games_assingment/init/repository/user_repository.dart';
import 'package:hero_games_assingment/init/util/routes.dart';
import 'package:hero_games_assingment/init/util/toast_messenger.dart';

import '../../init/models/user_model.dart';

class UserUpdateDialog extends UserRepository {
  UserUpdateDialog(super.context);

  Future<UserModel?> userUpdateDialog({
    required BuildContext context,
    required UserModel? userModel,
  }) async {
    log("UserUpdateDialog ${userModel.toString()}");
    final TextEditingController nameController =
        TextEditingController(text: userModel?.name);
    final TextEditingController emailController =
        TextEditingController(text: userModel?.email);
    final TextEditingController birthdayController =
        TextEditingController(text: userModel?.birthDate);
    final TextEditingController bioController =
        TextEditingController(text: userModel?.bio);
    final TextEditingController hobbiesController = TextEditingController(
        text: userModel?.hobbies?.map((e) => e).join(", "));
    Future<UserModel?> updateUser() async {
      final UserModel userModel = UserModel(
        name: nameController.text,
        email: emailController.text,
        birthDate: birthdayController.text,
        bio: bioController.text,
        hobbies: hobbiesController.text.stringToList(),
      );

      await update(userModel)
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, PageRoutes.homepage, (route) => false))
          .catchError((e) {
        log("Update Error: $e");
        ToastMessenger.instance.showToastMessage("Update Error: $e");
        return null;
      });
      return userModel;
    }

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update your Profile info"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  TextFormField(
                    controller: birthdayController,
                    decoration: const InputDecoration(
                      labelText: "Birth Day",
                    ),
                  ),
                  TextFormField(
                    controller: bioController,
                    decoration: const InputDecoration(
                      labelText: "Biography",
                    ),
                  ),
                  TextFormField(
                    controller: hobbiesController,
                    decoration: const InputDecoration(
                      labelText: "Hobbies",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, userModel);
                  },
                  child: const Text("Close")),
              TextButton(onPressed: updateUser, child: const Text("Update"))
            ],
          );
        });
  }
}
