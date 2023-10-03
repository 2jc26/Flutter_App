import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giusseppe_flut/auth/auth_credentials.dart';
import 'package:giusseppe_flut/auth/auth_cubit.dart';
import 'package:giusseppe_flut/auth/auth_repository.dart';
import 'package:giusseppe_flut/auth/login/login_event.dart';
import 'package:giusseppe_flut/auth/login/login_state.dart';

import '../form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository authRepo;
  final AuthCubit authCubit;
  LoginBloc({required this.authRepo, required this.authCubit}) : super(LoginState());


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // UsernameChanged
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

    // PasswordChanged
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

    // LoginSubmitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final user = await authRepo.login(state.username, state.password);
        yield state.copyWith(formStatus: SubmissionSuccess());
        if (user != null) {
          authCubit.launchSession(AuthCredentials(username: user.username, userId: user.id));
        }
      } catch(e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception, exception: e));
      }
    } else if (event is LogOut) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        unawaited(authRepo.logOut());
      } catch(e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception, exception: e));
      }
    } 
  }

  @override
  Future<void> close() {
    return super.close();
  }
}