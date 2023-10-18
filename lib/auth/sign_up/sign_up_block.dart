import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giusseppe_flut/auth/auth_credentials.dart';
import 'package:giusseppe_flut/auth/auth_cubit.dart';
import 'package:giusseppe_flut/auth/auth_repository.dart';
import 'package:giusseppe_flut/auth/sign_up/sign_up_event.dart';
import 'package:giusseppe_flut/auth/sign_up/sign_up_state.dart';

import '../form_submission_status.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  final AuthRepository authRepo;
  final AuthCubit authCubit;
  SignUpBloc({required this.authRepo, required this.authCubit}) : super(SignUpState());


  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // UsernameChanged
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);

    // PasswordChanged
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

    // SignUpSubmitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final user = await authRepo.signUp(state.username, state.password);
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