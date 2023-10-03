
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/user/query_likes_user.dart';

import '../../models/user/user_model_update.dart';

abstract class UserDao {

  Future<UserModelUpdate?> getUserById(String id);
  Future<List<UserModelUpdate>> getAllUsers();
  Future<UserModelUpdate?> validateUsernameAndPassword(String username, String password);
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
        final userData = user.data();
        final userId = user.id;
        final userModel = UserModelUpdate.fromJson({...userData, 'id': userId});
        users.add(userModel);
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
  Future<UserModelUpdate> getUserById(String id) async {
    try {
      final querySnapshot = await _firestore.collection("Users").doc(id).get();
      final userData = querySnapshot.data();
      final userId = querySnapshot.id;

      if (userData != null) {
        final userModel = UserModelUpdate.fromJson({...userData, 'id': userId});
        return userModel;
      } else {
        throw Exception("No data found for ID: $id");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching users: $error");
      }
      rethrow;
    }
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

  @override
  Future<UserModelUpdate?> validateUsernameAndPassword(
      String username, String password) async {
    try {
      // Check if a user with the given username exists in Firestore
      final querySnapshot = await _firestore
          .collection("Users")
          .where("username", isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User with the given username exists
        final userData = querySnapshot.docs.first.data();
        final userId = querySnapshot.docs.first.id;
        final storedPasswordHash = userData['password']; // Replace with the actual field name in Firestore

        if (password == storedPasswordHash) {
          if (userData != null) {
            final userModel = UserModelUpdate.fromJson({...userData, "id": userId});
            return userModel;
          }
        }
      }

      // User does not exist or password doesn't match
      return null;
    } catch (error) {
      if (kDebugMode) {
        print("Error validating username and password: $error");
      }
      rethrow;
    }
  }
  
}