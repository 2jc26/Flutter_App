import '../models/user/user_model_update.dart';
import '../repository/user_repository_prueba.dart';
import '../screens/back_test.dart';

class UserListPresenter {
  final UserRepository userRepository = UserRepository();
  List<UserModelUpdate>? usersList = [];
  late UserListView _backView= UserListView();
  UserListPresenter() {
    getAllUsers();
  }

  void getAllUsers() async {
    try {
      final users = await userRepository.getAllUsers();
      if (users != null) {
        usersList = users;
        _backView.refreshUserListView(usersList!);
      }
    } catch (error) {
      rethrow;
    }
  }

  set backView(UserListView value) {
    _backView = value;
    _backView.refreshUserListView(usersList!);
  }

}