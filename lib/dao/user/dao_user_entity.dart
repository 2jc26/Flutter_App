
import '../../models/user_model.dart';

abstract class UserDao {

  Future<UserModelUpdate?> getUserById(int id);
  Future<List<UserModelUpdate>> getAllUsers();
  // Future<void> insertUser(UserModelUpdate user);
  // Future<void> updateUser(UserModelUpdate user);
  //Future<void> deleteUser(int id);
}

class UserDaoFireStore extends UserDao{
  @override
  Future<List<UserModelUpdate>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<UserModelUpdate?> getUserById(int id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }
  
}