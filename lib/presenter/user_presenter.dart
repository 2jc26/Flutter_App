import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/user/query_filter_user.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';

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
  int _number = 0;

  UserListPresenter();

  void getAllUsers({int skip=0, int limit=5}) async {
    try {
      List<UserModel> users = [];
      _number = await userRepository.getLenght();
      _number = (_number/5).ceil();
      users = await userRepository.getAllUsersByPreferences(skip: skip, limit: limit);
      usersList = users;
      if (users.isNotEmpty) {
        average= await compute(getAverage, users);
      } else {
        average=0.0;
      }

      _backView.refreshUserListView(usersList!, average);
      _backView.refreshNumber(_number);
      _backView.acutalized(false);
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

  void setUserPreferences({int skip=0, int limit=5}) {
    getAllUsers(skip: skip, limit: limit);
  }
}

double getAverage(List<UserModel>list){
  double suma = 0;
  for (var element in list){
    suma+=element.stars;
  }
  return suma/list.length;
}
