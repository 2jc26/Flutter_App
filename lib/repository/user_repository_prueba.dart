import 'dart:typed_data';

import 'package:giusseppe_flut/models/user/query_likes_user.dart';

import '../dao/user/dao_user_entity.dart';
import '../models/user/user_model_update.dart';

class UserRepository {

  final UserDaoFireStore userDao= UserDaoFireStore();

  Future<List<UserModelUpdate>> getAllUsers() async {
    try {
      return await userDao.getAllUsers();
    } catch (error) {
      rethrow;
    }
  }

  Future<Uint8List?> getImage(String image) async {
    return userDao.getImage(image);
  }

  Future<UserModelUpdate?> validateUsernameAndPassword(String email, String password) async {
    try {
      return await userDao.validateEmailAndPassword(email, password);
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModelUpdate?> createUser(String email, String password, String fullname, int age, String phone, String genero, String city, String locality) async {
    try {
      return await userDao.createUser(email, password, fullname, age, phone, genero, city, locality);
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModelUpdate?> getUserById(String id) async {
    try {
      return await userDao.getUserById(id);
    } catch (error) {
      rethrow;
    }
  }
  Future<List<UserModelUpdate>> getAllUsersByPreferences() async {
    try {
      return await userDao.getUsersByPreferences();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<UserModelUpdate>> getDocumentsWithinRadius(double latitude, double longitude) async {
    try {
      return await userDao.getDocumentsWithinRadius(latitude,longitude);
    } catch (error) {
      rethrow;
    }
  }

}