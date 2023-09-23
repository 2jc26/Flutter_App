import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/login.dart';
import 'package:giusseppe_flut/screens/sign_up.dart';
import 'widgets/drawer.dart';
import 'screens/roomie_detail.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SignUp( title: 'Search Roommate'),
    );
  }
}
