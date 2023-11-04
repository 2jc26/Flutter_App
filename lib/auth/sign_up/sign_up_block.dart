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
    if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

    // PasswordChanged
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

    // SignUpSubmitted
    } else if (event is SignUpFullNameChanged) {
      yield state.copyWith(fullname: event.fullname);

    // SignUpSubmitted
    } else if (event is SignUpAgeChanged) {
      yield state.copyWith(age: event.age);

    // SignUpSubmitted
    } else if (event is SignUpPhoneChanged) {
      yield state.copyWith(phone: event.phone);

    // SignUpSubmitted
    } else if (event is SignUpGeneroChanged) {
      yield state.copyWith(genero: event.genero);

    // SignUpSubmitted
    } else if (event is SignUpCityChanged) {
      yield state.copyWith(city: event.city);

    // SignUpSubmitted
    } else if (event is SignUpLocalityChanged) {
      yield state.copyWith(locality: event.locality);

    // SignUpSubmitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final user = await authRepo.signUp(state.email, state.password, state.fullname, state.age, state.phone, state.genero, state.city, state.locality);
        yield state.copyWith(formStatus: FormSubmitting());
        if (user != null) {
          String id = user.id ?? "";
          authCubit.launchSession(AuthCredentials(email: user.email, userId: id));
        }
      } catch(e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception, exception: e));
      }
    } 
  }
}