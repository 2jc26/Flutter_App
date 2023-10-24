import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../dao/user/dao_user_entity.dart';
import '../models/user/query_likes_user.dart';
import '../models/user/user_model_update.dart';
import '../repository/user_repository_prueba.dart';
import '../screens/user_list.dart';
import '../screens/views_abs.dart';

class UserListPresenter {
  final UserRepository userRepository = UserRepository();
  List<UserModelUpdate>? usersList = [];
  late UserListView _backView= UserListView();
  UserPreferencesDTO? userPreferences;

  UserListPresenter({this.userPreferences});

  void getAllUsers() async {
    try {
      List<UserModelUpdate>? users = [];
      if (userPreferences != null){
        users = await userRepository.getAllUsersByPreferences(userPreferences!);
      }
      else{
        users = await userRepository.getAllUsers();
      }
      if (users != null) {
        usersList = users;
        _backView.refreshUserListView(usersList!);
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
    _backView.refreshUserListView(usersList!);
  }

  void setUserPreferences(UserPreferencesDTO? preferences) {
    userPreferences = preferences;
    getAllUsers();
  }
}