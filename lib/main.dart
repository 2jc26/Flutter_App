import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/appartment_filter.dart';

//Sensors
import 'dart:async';
import 'package:light/light.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState  extends State<MyApp> {
  String _luxString = 'Unknown';
  Light? _light;
  StreamSubscription? _subscription;

  void onData(int luxValue) async {
    print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light?.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Light Example App'),
        ),
        body: Center(
          child: Text('Lux value: $_luxString\n'),
        ),
      ),
    );
  }
}