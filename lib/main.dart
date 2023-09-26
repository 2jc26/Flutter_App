import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/Register.dart';
import 'package:giusseppe_flut/screens/aaaa.dart';
import 'package:giusseppe_flut/screens/roomie_detail.dart';
import 'package:giusseppe_flut/screens/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          primary: Color(0xFF2e5eaa),
          secondary: Colors.white,
          surface: Color(0xFFdae3e5),
          background: Color(0xFFdae3e5),
          error: Color(0xFFB00020),
          onPrimary: Color(0xFF2c595b),
          onSecondary: Color(0xFF2c595b),
          onSurface: Color(0xFF2c595b),
          onBackground: Color(0xFF2c595b),
          onError: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      home: Register(),
    );
  }
}