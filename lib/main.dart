import 'dart:io';

import 'package:disfruta/productPage.dart';
import 'package:disfruta/splash_screen.dart';
import 'package:flutter/material.dart';
import 'http_override.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Antofagasta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFAAAAAA)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
