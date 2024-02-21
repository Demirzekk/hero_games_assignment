import 'package:flutter/material.dart';

import 'init/util/routes.dart';

class HeroAssignment extends StatelessWidget {
  const HeroAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hero Games Assignment",
      routes: PageRoutes.routes,
      initialRoute: PageRoutes.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
