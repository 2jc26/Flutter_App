import 'dart:convert';
import 'dart:io';

import 'package:giusseppe_flut/models/user/user_model_update.dart';
import 'package:giusseppe_flut/repository/user_repository_prueba.dart';
import 'package:giusseppe_flut/storage/providers/id_provider.dart';
import 'package:giusseppe_flut/storage/providers/nickname_provider.dart';
import 'package:giusseppe_flut/storage/providers/password_provider.dart';
import 'package:giusseppe_flut/storage/storage_adapters/file_manager.dart';

class AuthRepository {
    
  final UserRepository userRepository = UserRepository();

  NicknameProvider nicknameProvider = NicknameProvider();
  PasswordProvider passwordProvider = PasswordProvider();
  IdProvider idProvider = IdProvider();

  FileManager fileManager = FileManager();

  Future<void> saveLocalInfo(String email, String password, UserModelUpdate user) async {
    try {
      await nicknameProvider.setNickname(email);
      await passwordProvider.setPassword(password);
      await idProvider.setId(user.id??'');
      await fileManager.write(File('${FileManager.directory.path}/user.json'), json.encode(user.toJson()));
    } catch(e) {
      throw Exception(e);

    }
  }

  Future<UserModelUpdate?> login(String email, String password) async {
    try {
      UserModelUpdate? user;
      // if (eventualconectivy) {
        // final uNameStorage = await nicknameProvider.getNickname();
        // final passStorage = await passwordProvider.getPassword();
        // final idStorage = await idProvider.getId();
        // if (uNameStorage == email && passStorage == password) {
          // TODO: Retreibve user from local storage File
          // user = await userRepository.getUserLocalFile(email, password,idStorage??'', fileManager);
        // }
      // } else {
        user = await userRepository.validateUsernameAndPassword(email, password);
      // }
      if (user != null) {
        saveLocalInfo(user.email, user.password, user);
        return user;
      } else {
        throw Exception("Login fallido");
      }
    } catch(e) {  
      throw Exception(e);
    }
  }

  Future<UserModelUpdate?> signUp(String email, String password, String fullname, int age, String phone, String genero, String city, String locality) async {
    try {
      final user = await userRepository.createUser(email, password, fullname, age, phone, genero, city, locality);
      if (user != null) {
        saveLocalInfo(user.email, user.password, user);
        return user;
      } else {
        throw Exception("SignUp fallido");
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