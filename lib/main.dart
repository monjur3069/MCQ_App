import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/routes/routes.dart';
import 'package:quiz_app/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.pages,
      initialRoute: Routes.quizPageRoute,
    );
  }
}
