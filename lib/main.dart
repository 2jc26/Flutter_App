import 'dart:async';

import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/appartment_filter.dart';
import 'package:light_sensor/light_sensor.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<int> listen;
  int animationValue = 0;

  @override
  void initState() {
    listen = LightSensor.lightSensorStream.listen((lux) {
      setState(() {
        animationValue = lux;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    listen.cancel();
    super.dispose();
  }

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
      home: Center(child: 
      Text("Valor del sensor: $animationValue")),
    );
  }
}