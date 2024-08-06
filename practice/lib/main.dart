import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice/view/loading.dart';
import 'package:practice/view/loginpage.dart';
import 'package:practice/view/questionspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Loading()),
        GetPage(name: '/login_page', page: () => const Loginpage()),
        GetPage(name: '/questions_page', page: () => Questionspage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Jannah Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 183, 66)),
        useMaterial3: true,
      ),
    );
  }
}