import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../dao/user/dao_user_entity.dart';
import '../models/user/query_likes_user.dart';
import '../models/user/user_model_update.dart';
import '../repository/user_repository_prueba.dart';
import '../screens/user_list.dart';
import '../screens/base_mvp/views_abs.dart';

class UserListPresenter {
  final UserRepository userRepository = UserRepository();
  List<UserModelUpdate>? usersList = [];
  late UserListView _backView= UserListView();
  double average=0.0;

  UserListPresenter();

  void getAllUsers() async {
    try {
      List<UserModelUpdate>? users = [];
      users = await userRepository.getAllUsersByPreferences();
      average= userRepository.getAverage(users);
      if (users != null) {
        usersList = users;
        _backView.refreshUserListView(usersList!, average);
      }

    } catch (error) {
      rethrow;
    }
  }
  Future<Uint8List?> getImage(String image) async {
    return userRepository.getImage(image);
  }

  set backView(UserListView value) {
    _backView = value;
    _backView.refreshUserListView(usersList!,average);
  }

  void setUserPreferences() {
    getAllUsers();
  }
}