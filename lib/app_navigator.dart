import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giusseppe_flut/auth/auth_cubit.dart';
import 'package:giusseppe_flut/auth/auth_navigator.dart';
import 'package:giusseppe_flut/screens/house_list.dart';
import 'package:giusseppe_flut/screens/principal.dart';
import 'package:giusseppe_flut/session_cubit.dart';
import 'package:giusseppe_flut/session_state.dart';

class AppNavigator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is UnkownSessionState) {
        return Material(
          child: BlocProvider(
            create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
            child: AuthNavigator(),
          ),
        );
      }
      if (state is Unauthenticated) {
        return Material(
          child: BlocProvider(
            create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
            child: AuthNavigator(),
          ),
        );
      }
      if (state is Authenticated) {
        return Material(
          child: BlocProvider(
            create: (context) => AuthCubit(sessionCubit: context.read<SessionCubit>()),
            child: PrincipalView(userId: state.userid),
          ),
        );
      }
      return Container();
    });
  }
}