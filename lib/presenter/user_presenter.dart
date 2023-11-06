import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user/query_likes_user.dart';
import '../models/user/user_model.dart';
import '../repository/user_repository.dart';
import '../screens/user_list.dart';
import '../screens/base_mvp/views_abs.dart';
import '../storage/storage_adapters/Objectbox/ObjectBox.dart';

class UserListPresenter {
  final UserRepository userRepository = UserRepository();
  List<UserModel>? usersList = [];
  late UserListView _backView= UserListView();
  double average=0.0;

  UserListPresenter();

  void getAllUsers() async {
    try {
      List<UserModel> users = [];
      users = await userRepository.getAllUsersByPreferences();
      usersList = users;
      if (users.isNotEmpty) {
        average= userRepository.getAverage(users);
      } else {
        average=0.0;
      }
      _backView.refreshUserListView(usersList!, average);
    } catch (error) {
      rethrow;
    }
  }
  Stream<List<UserModel>> getUsersStreamByPreferences() {
    return ObjectBoxDao().getUsersStreamByPreferences();
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