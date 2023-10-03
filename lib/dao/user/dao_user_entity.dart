
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/user/user_model_update.dart';

abstract class UserDao {

  Future<UserModelUpdate?> getUserById(int id);
  Future<List<UserModelUpdate>> getAllUsers();
  // Future<void> insertUser(UserModelUpdate user);
  // Future<void> updateUser(UserModelUpdate user);
  // Future<void> deleteUser(int id);
}

class UserDaoFireStore extends UserDao{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<List<UserModelUpdate>> getAllUsers() async {
    List<UserModelUpdate> users = [];
    try {
      final querySnapshot = await _firestore.collection("Users").get();
      for (var user in querySnapshot.docs) {
        users.add(UserModelUpdate.fromJson(user.data()));
      }
      return users;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching users: $error");
      }
      rethrow;
    }
  }

  @override
  Future<UserModelUpdate?> getUserById(int id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  //@override
  //Future<UserModelUpdate?> getUserById(int id) {

  //}
  
}