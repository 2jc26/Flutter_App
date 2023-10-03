
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/user/query_likes_user.dart';

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

  Future<List<UserModelUpdate>> getAllUsersByPreferences(UserPreferencesDTO userPreferences) {

    throw UnimplementedError();

  }

  @override
  Future<List<UserModelUpdate>> getHousesByLikings(UserPreferencesDTO userPreferences) async {
    List<UserModelUpdate> users = [];
    try {
      Query query= _firestore.collection("Users");
      if (userPreferences.externalPeopleFrequency != null) {
        query = query.where("bring_people", isEqualTo: userPreferences.externalPeopleFrequency);
      }
      if (userPreferences.sleepTime != null) {
        query = query.where("sleep", isEqualTo: userPreferences.sleepTime);
      }
      if (userPreferences.smokePreference != null) {
        query = query.where("smoke", isEqualTo: userPreferences.smokePreference);
      }
      if (userPreferences.vapePreference != null) {
        query = query.where("vape", isEqualTo: userPreferences.vapePreference);
      }
      if (userPreferences.cleaningFrequency != null) {
        query = query.where("clean", isEqualTo: userPreferences.cleaningFrequency);
      }
      if (userPreferences.introvertedPreference != null) {
        query = query.where("personality", isEqualTo: userPreferences.introvertedPreference);
      }
      if (userPreferences.petPreference != null) {
        query = query.where("likes_pets", isEqualTo: userPreferences.petPreference);
      }

      final querySnapshot = await query.get();

      for (var user in querySnapshot.docs) {
        final userData = user.data() as Map<String, dynamic>;
        users.add(UserModelUpdate.fromJson(userData));
      }
      return users;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses by likings: $error");
      }
      rethrow;
    }
  }

}