import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:giusseppe_flut/storage/storage_adapters/file_manager.dart';
import '../models/user/user_model.dart';
import '../service_adapter/user/dao_user_entity.dart';
import '../storage/storage_adapters/Objectbox/ObjectBox.dart';

class UserRepository {

  final UserDaoFireStore userDao= UserDaoFireStore();
  ObjectBoxDao instancia= ObjectBoxDao();
  FileManager fileManager = FileManager();

  UserRepository() {
    FileManager.initialFile();
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
        return UserModel.fromJson({...user, 'id': id, 'username': username, 'password': password});
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
  Future<List<UserModel>> getAllUsersByPreferences() async {
    try {
      List<UserModel> lista= await userDao.getUsersByPreferences();
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



}