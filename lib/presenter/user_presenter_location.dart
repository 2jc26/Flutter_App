
import '../models/user/user_model_update.dart';
import '../repository/user_repository_prueba.dart';
import '../screens/base_mvp/base_mvp_location.dart';
import '../screens/base_mvp/views_abs.dart';

class UserListPresenterLocation {
  final UserRepository userRepository = UserRepository();
  List<UserModelUpdate>? usersList = [];
  late UserListViewLocation _backView= UserListViewLocation();

  UserListPresenterLocation();

  void getNearUsers(double latitud, double longitud) async {

    try {
      List<UserModelUpdate>? users = [];
      users = await userRepository.getDocumentsWithinRadius(latitud!,longitud!);
      if (users != null) {
        usersList = users;
        _backView.refreshUserListView(usersList!);
      }
    } catch (error) {
      rethrow;
    }
  }

  set backView(UserListViewLocation value) {
    _backView = value;
    _backView.refreshUserListView(usersList!);
  }


}
