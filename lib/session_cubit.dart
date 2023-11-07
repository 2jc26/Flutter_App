import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giusseppe_flut/auth/auth_credentials.dart';
import 'package:giusseppe_flut/auth/auth_repository.dart';
import 'package:giusseppe_flut/repository/user_repository.dart';
import 'package:giusseppe_flut/session_state.dart';

class SessionCubit extends Cubit<SessionState> {

  final AuthRepository authRepo;

  SessionCubit({required this.authRepo}): super(Unauthenticated());

  final UserRepository dataRepo = UserRepository();

  void showAuth() => emit(Unauthenticated());
  
  void showSession(AuthCredentials credentials) {
    final userId = credentials.userId;
    if (userId != null) {
      emit(Authenticated(userid: userId));
      
    }
  }

  void signOut() {
    authRepo.logOut();
    emit(Unauthenticated());
  }
}