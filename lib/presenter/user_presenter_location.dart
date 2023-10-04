import '../models/user/query_likes_user.dart';
import '../models/user/user_model_update.dart';
import '../repository/user_repository_prueba.dart';
import '../screens/user_list.dart';
import '../screens/views_abs.dart';
import 'package:geolocator/geolocator.dart';

class UserListPresenterLocation {
  final UserRepository userRepository = UserRepository();
  List<UserModelUpdate>? usersList = [];
  late UserListView _backView= UserListView();

  UserListPresenterLocation() {
  }

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

  set backView(UserListView value) {
    _backView = value;
    _backView.refreshUserListView(usersList!);
  }


}