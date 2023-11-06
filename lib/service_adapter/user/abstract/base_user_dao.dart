import '../../../models/user/user_model.dart';

abstract class UserDao {

  Future<UserModel?> getUserById(String id);
  Future<List<UserModel>> getAllUsers();
  Future<UserModel?> validateEmailAndPassword(String email, String password);
  Future<UserModel?> createUser(String email, String password, String fullname, int age, String phone, String genero, String city, String locality);
// Future<void> insertUser(UserModelUpdate user);
// Future<void> updateUser(UserModelUpdate user);
// Future<void> deleteUser(int id);
}