import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giusseppe_flut/auth/auth_repository.dart';
import 'package:giusseppe_flut/auth/login/login_event.dart';
import 'package:giusseppe_flut/auth/login/login_state.dart';

import '../form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState());


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
        await authRepo.login(event.username, event.password);
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch(e) {
        yield state.copyWith(formStatus: SubmissionFailed(e as Exception, exception: e));
      }
    }
  }
}