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

}