import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giusseppe_flut/auth/auth_credentials.dart';
import 'package:giusseppe_flut/session_cubit.dart';

enum AuthState { login, signUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  AuthCredentials? credential;

  void showLogin() => emit(AuthState.login);
  
  void showSignUp() => emit(AuthState.signUp);

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
