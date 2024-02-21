import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_games_assingment/init/repository/user_repository.dart';
import 'package:hero_games_assingment/pages/home_page/_user_update_dialog.dart';
import 'package:hero_games_assingment/init/util/toast_messenger.dart';

import '../../init/models/user_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: const _Body());
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text("Home Page"),
      actions: [
        IconButton(
          onPressed: () {
            FirebaseAuth.instance
                .signOut()
                .then((value) => Navigator.pushNamed(context, "/login"))
                .catchError((e) {
              log("SignOut Error: $e");
              ToastMessenger().showToastMessage("SignOut Error: $e");
              return null;
            });
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    Future userDataFuture = UserRepository(context).get();
    UserModel? userDataModel;

    return Column(
      children: [
        FutureBuilder(
          future: userDataFuture,
          builder: (context, AsyncSnapshot snapshot) {
            return LoadingWidget(
              snapshot: snapshot,
              builder: (UserModel? userModel) {
                userDataModel = userModel;
                return Column(
                  children: [
                    UserInfoWidget(
                        decoration: decoration, userModel: userModel),
                    UserBiographyWidget(
                        decoration: decoration, userModel: userModel),
                    UserHobbiesWidget(
                        decoration: decoration, userModel: userModel),
                  ],
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 12,
        ),
        ElevatedButton(
          onPressed: () async => UserUpdateDialog(context)
              .userUpdateDialog(context: context, userModel: userDataModel)
              .then((value) => value = userDataModel),
          child: const Text("Update your Profile info"),
        ),
      ],
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.decoration,
    this.userModel,
  });

  final BoxDecoration decoration;
  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      width: double.maxFinite,
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name:"),
                  Text("Email:"),
                  Text("Birthday:"),
                ],
              )),
          Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${userModel?.name}"),
                  Text("${userModel?.email}"),
                  Text("${userModel?.birthDate}"),
                ],
              )),
        ],
      ),
    );
  }
}

class UserBiographyWidget extends StatelessWidget {
  const UserBiographyWidget({
    super.key,
    required this.decoration,
    this.userModel,
  });

  final BoxDecoration decoration;
  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: double.maxFinite,
      decoration: decoration,
      child: Text("Your Biography\n${userModel?.bio}"),
    );
  }
}

class UserHobbiesWidget extends StatelessWidget {
  const UserHobbiesWidget({
    super.key,
    required this.decoration,
    this.userModel,
  });

  final BoxDecoration decoration;
  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: double.maxFinite,
      decoration: decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your Hobbies\n"),
          Wrap(
            runSpacing: 4,
            spacing: 4,
            children: [
              ...userModel?.hobbies
                      ?.map((e) => Chip(
                          padding: const EdgeInsets.all(0),
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.teal[300] ?? Colors.blue,
                                width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.teal[200],
                          label: Text(e,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))))
                      .toList() ??
                  [],
            ],
          ),
          if (userModel?.hobbies == []) const Text("You have no hobbies yet"),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.snapshot,
    required this.builder,
  });
  final AsyncSnapshot snapshot;
  final Widget Function(UserModel? model) builder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (snapshot.hasError) {
      return Center(
        child: Text("Error: ${snapshot.error}"),
      );
    }
    if (snapshot.data == null) {
      return const Center(
        child: Text("No Data"),
      );
    }

    return builder(UserModel.fromJson(snapshot.data));
  }
}

final decoration = BoxDecoration(
  color: Colors.grey[100],
  borderRadius: BorderRadius.circular(10),
  border: Border.all(color: const Color.fromARGB(255, 201, 199, 199)),
);
