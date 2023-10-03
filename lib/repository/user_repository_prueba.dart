import 'package:giusseppe_flut/models/user/query_likes_user.dart';

import '../dao/user/dao_user_entity.dart';
import '../models/user/user_model_update.dart';
import '../screens/back_test.dart';

class UserRepository {

  final UserDaoFireStore userDao= UserDaoFireStore();

  Future<List<UserModelUpdate>> getAllUsers() async {
    try {
      return await userDao.getAllUsers();
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

}