import 'dart:async';

import 'package:giusseppe_flut/models/user/user_model.dart';
import 'package:giusseppe_flut/repository/user_repository.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'package:giusseppe_flut/storage/providers/id_provider.dart';
import 'package:giusseppe_flut/storage/providers/nickname_provider.dart';
import 'package:giusseppe_flut/storage/providers/password_provider.dart';

class AuthRepository {

  final UserRepository userRepository = UserRepository();

  late StreamSubscription<bool> connectionSubscription;

  NicknameProvider nicknameProvider = NicknameProvider();
  PasswordProvider passwordProvider = PasswordProvider();
  IdProvider idProvider = IdProvider();

  bool connectivity = ConnectivityManagerService().connectivity;
  
  AuthRepository() {
      connectionSubscription = ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
    });
  }

  Future<void> saveLocalInfo(UserModel user) async {
    try {
      await nicknameProvider.setNickname(user.email);
      await passwordProvider.setPassword(user.password);
      await idProvider.setId(user.id);
      await userRepository.createFileUser(user);
    } catch(e) {
      throw Exception(e);

    }
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      UserModel? user;
      if (!connectivity) {
        final uNameStorage = await nicknameProvider.getNickname();
        final passStorage = await passwordProvider.getPassword();
        final idStorage = await idProvider.getId();
        if (uNameStorage == email && passStorage == password) {
          user = await userRepository.getUserLocalFile(email, password,idStorage??'');
        }
      } else {
        user = await userRepository.validateUsernameAndPassword(email, password);
      }
      if (user != null) {
        saveLocalInfo(user);
        return user;
      } else {
        throw Exception("Login fallido");
      }
    } catch(e) {  
      throw Exception(e);
    }
  }

  Future<UserModel?> signUp(String email, String password, String fullname, int age, String phone, String genero, String city, String locality) async {
    try {
      if (!connectivity) {
        final user = await userRepository.createUser(email, password, fullname, age, phone, genero, city, locality);
        if (user != null) {
          saveLocalInfo(user);
          return user;
        } else {
          throw Exception("SignUp fallido");
        }
      } else {
        throw Exception("No hay conexión a internet");
      }
    } catch(e) {  
      throw Exception(e);
    }
  }

  Future<void> logOut() async {
    try {

      // TODO: Implementar logOut
      await Future.delayed(const Duration(seconds: 2));
      await idProvider.setId('');
    } catch(e) {
      throw Exception(e);
    }
  }

}