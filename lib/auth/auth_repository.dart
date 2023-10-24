import 'package:giusseppe_flut/models/user/user_model_update.dart';
import 'package:giusseppe_flut/repository/user_repository_prueba.dart';

class AuthRepository {
    
  final UserRepository userRepository = UserRepository();

  Future<UserModelUpdate?> login(String username, String password) async {
    try {
      final user = await userRepository.validateUsernameAndPassword(username, password);
      if (user != null) {
        return user;
      } else {
        throw Exception("Login fallido");
      }
    } catch(e) {  
      throw Exception(e);
    }
  }

  Future<UserModelUpdate?> signUp(String username, String password, String fullname, int age, String phone, String genero, String city, String locality) async {
    try {
      final user = await userRepository.createUser(username, password, fullname, age, phone, genero, city, locality);
      if (user != null) {
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

      // TO DO: Implementar logOut
      await Future.delayed(const Duration(seconds: 2));
    } catch(e) {
      throw Exception(e);
    }
  }

}