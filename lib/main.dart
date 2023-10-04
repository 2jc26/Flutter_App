import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:giusseppe_flut/app_navigator.dart';
import 'package:giusseppe_flut/auth/auth_repository.dart';
import 'package:giusseppe_flut/session_cubit.dart';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:giusseppe_flut/screens/appartment_filter.dart';
import 'package:giusseppe_flut/session_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: "root",
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
          tertiary: Color(0xFFEDF9B9)
        ),
      ),
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => SessionCubit(authRepo: context.read<AuthRepository>()),
          child: AppNavigator(),
        ),
      ),
    );
  }
}