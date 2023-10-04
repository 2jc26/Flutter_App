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

  Future<UserModelUpdate?> validateUsernameAndPassword(String username, String password) async {
    try {
      return await userDao.validateUsernameAndPassword(username, password);
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
  Future<List<UserModelUpdate>> getAllUsersByPreferences(UserPreferencesDTO userPreferences) async {
    try {
      return await userDao.getHousesByLikings(userPreferences);
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