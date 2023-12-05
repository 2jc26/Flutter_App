import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/storage/storage_adapters/file_manager.dart';
import '../models/user/user_model.dart';
import '../service/connectivity_manager_service.dart';
import '../service_adapter/user/dao_user_entity.dart';
import '../storage/storage_adapters/Objectbox/ObjectBox.dart';

class UserRepository {

  final UserDaoFireStore userDao= UserDaoFireStore();
  ObjectBoxDao instancia= ObjectBoxDao();
  FileManager fileManager = FileManager();

  late StreamSubscription<bool> connectionSubscription;
  bool connectivity = ConnectivityManagerService().connectivity;

  UserRepository() {
    FileManager.initialFile();
    initializeConnectivity();

  }
  Future<void> initializeConnectivity() async{
    connectionSubscription = ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
    });
  }


  Future<List<UserModel>> getAllUsers() async {
    try {
      List<UserModel> lista= await userDao.getAllUsers();
      for (var usuario in lista){
        bool condicion =instancia.verifyUserExist(usuario.id);
        if (!condicion){
          instancia.addUser(usuario);
        }
      }
      return lista;
    } catch (error) {
      rethrow;
    }
  }
  Future<List<UserModel>> getAllUsersByPreferences({int skip=0, int limit=5}) async {
    try {
      if (connectivity){
        userDao.updateUserPreferencesStats();
        List<UserModel> lista= await userDao.getUsersByPreferences(skip: skip, limit: limit);
        for (var usuario in lista){
          bool condicion =instancia.verifyUserExist(usuario.id);
          if (!condicion){
            instancia.addUser(usuario);
          }
        }
        return lista;
      }else{
        return instancia.getUsersByPreferences();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<UserModel>> getAllUsersByPreferencesPagination(int skip, int limit) async {
    try {
      if (connectivity) {
        userDao.updateUserPreferencesStats();
        List<UserModel> lista = await userDao.getUsersByPreferences();
        for (var usuario in lista) {
          bool condicion = instancia.verifyUserExist(usuario.id);
          if (!condicion) {
            instancia.addUser(usuario);
          }
        }
        return lista;
      } else {
        return instancia.getUsersByPreferencesPagination(skip, limit);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<int> getLenght(){
    try {
      if(connectivity) {
        return userDao.getLenght();
      } else {
        return Future.value(0);
      }
    } catch (error) {
      rethrow;
    }
  }
  Future<Uint8List?> getImage(String image) async {
    return userDao.getImage(image);
  }

  Future<UserModel?> validateUsernameAndPassword(String email, String password) async {
    try {
      return await userDao.validateEmailAndPassword(email, password);
    } catch (error) {
      rethrow;
    }
  }


  Future<UserModel?> createUser(String email, String password, String fullname, int age, String phone, String genero, String city, String locality) async {
    try {
      return await userDao.createUser(email, password, fullname, age, phone, genero, city, locality);
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel?> getUserLocalFile(String username, String password, String id) async {
    try {
      final user = await fileManager.read(File('${FileManager.directory.path}/user.json'));
      if (user != null) {
        return await compute(_parseUserModel, user);
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel?> getUserLocalFileLessArgs() async {
    try {
      final user = await fileManager.read(File('${FileManager.directory.path}/user.json'));
      if (user != null) {
        return await compute(_parseUserModel, user);
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }



  Future<void> createFileUser(UserModel user) async {
    try {
      await fileManager.write(File('${FileManager.directory.path}/user.json'), json.encode(user.toJson()));
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel?> getUserById(String id) async {
    try {
      return await userDao.getUserById(id);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<UserModel>> getTopUsers() async {
    try {
      if(connectivity) {
        return await userDao.getTopUsers();
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  double getAverage(List<UserModel> list){
    double suma = 0;
    for (var element in list){
      suma+=element.stars;
    }
    return suma/list.length;
  }



  Future<List<UserModel>> getDocumentsWithinRadius(double latitude, double longitude) async {
    try {
      return await userDao.getDocumentsWithinRadius(latitude,longitude);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<UserModel>> getDocumentsWithinRadiusPagination(double latitude, double longitude, int skip, int limit) async {
    try {
      return await userDao.getDocumentsWithinRadiusPagination(latitude,longitude, skip, limit);
    } catch (error) {
      rethrow;
    }
  }



}
UserModel _parseUserModel(dynamic user) {
  return UserModel.fromJson({...user});
}