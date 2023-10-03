import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giusseppe_flut/auth/auth_cubit.dart';
import 'package:giusseppe_flut/screens/login.dart';
import 'package:giusseppe_flut/screens/sign_up.dart';

class AuthNavigator extends StatelessWidget {
  
  @override
  Widget build (BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator (
      pages: [
        if (state == AuthState.login) const MaterialPage(child: Login()),

        if (state == AuthState.signUp) const MaterialPage(child: SignUp()),

      ],
      onPopPage: (route, result) => route.didPop(result),
    );
    });
    
  }
}