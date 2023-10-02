import '../models/user/user_model_update.dart';
import '../repository/user_repository.dart';

class UserListPresenter {
  final UserRepository userRepository = UserRepository();
  List<UserModelUpdate>? usersList;

  UserListPresenter() {
    _getAllUsers();
  }

  void _getAllUsers() async {
    try {
      final users = await userRepository.getAllUsers();
      if (users != null) {
        usersList = users;
      }
    } catch (error) {
      rethrow;
    }
  }

}