import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:giusseppe_flut/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import '../../../models/user/query_filter_user.dart';
import '../../../models/user/user_model.dart';

class ObjectBoxDao {
  late final Store store;
  late final Box<UserModel> userBox;
  UserFilter userFilter = UserFilter();
  // Private constructor
  ObjectBoxDao._create(this.store) {
    userBox = Box<UserModel>(store);
  }

  // Singleton instance
  static ObjectBoxDao? _instance;

  // Factory constructor to get the singleton instance
  factory ObjectBoxDao() {
    if (_instance == null) {
      throw Exception("ObjectBox has not been initialized. Call ObjectBox.create() first.");
    }
    return _instance!;
  }

  // Create the ObjectBox singleton
  static Future<void> initialize() async {
    if (_instance == null) {
      final store = await openStore();
      _instance = ObjectBoxDao._create(store);
    }
  }

  int addUser(UserModel user) {
    return userBox.put(user);
  }

  bool verifyUserExist(String id){
    Query<UserModel> query = userBox.query(UserModel_.id.equals(id)).build();
    List<UserModel> model= query.find();
    query.close();
    if (model.isNotEmpty){
      return true;
    } else{
      return false;
    }
  }


  Stream<List<UserModel>> getUsers() {
    final builder = userBox.query();
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<UserModel>> getUsersStreamByPreferences() {
    final builder = userBox.query(
        userFilter.getSleepTime() != null ? UserModel_.sleep.equals(userFilter.getSleepTime()!) : UserModel_.id_int.notNull()
            .and(userFilter.getSmokePreference() != null ? UserModel_.smoke.equals(userFilter.getSmokePreference()!) : UserModel_.id_int.notNull())
            .and(userFilter.getVapePreference() != null ? UserModel_.vape.equals(userFilter.getVapePreference()!) : UserModel_.id_int.notNull())
            .and(userFilter.getCleaningFrequency() != null ? UserModel_.clean.equals(userFilter.getCleaningFrequency()!) : UserModel_.id_int.notNull())
            .and(userFilter.getIntrovertedPreference() != null ? UserModel_.personality.equals(userFilter.getIntrovertedPreference()!) : UserModel_.id_int.notNull())
            .and(userFilter.getPetPreference() != null ? UserModel_.likes_pets.equals(userFilter.getPetPreference()!) : UserModel_.id_int.notNull())
            .and(userFilter.getCity() != null ? UserModel_.city.equals(userFilter.getCity()!) : UserModel_.id_int.notNull())
            .and(userFilter.getNeighborhood() != null ? UserModel_.locality.equals(userFilter.getNeighborhood()!) : UserModel_.id_int.notNull())
    );
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  List<UserModel> getUsersByPreferences() {

    try {


      Query<UserModel> query = userBox.query(
          userFilter.getSleepTime() != null ? UserModel_.sleep.equals(userFilter.getSleepTime()!) : UserModel_.id_int.notNull()
              .and(userFilter.getSmokePreference() != null ? UserModel_.smoke.equals(userFilter.getSmokePreference()!) : UserModel_.id_int.notNull())
              .and(userFilter.getVapePreference() != null ? UserModel_.vape.equals(userFilter.getVapePreference()!) : UserModel_.id_int.notNull())
              .and(userFilter.getCleaningFrequency() != null ? UserModel_.clean.equals(userFilter.getCleaningFrequency()!) : UserModel_.id_int.notNull())
              .and(userFilter.getIntrovertedPreference() != null ? UserModel_.personality.equals(userFilter.getIntrovertedPreference()!) : UserModel_.id_int.notNull())
              .and(userFilter.getPetPreference() != null ? UserModel_.likes_pets.equals(userFilter.getPetPreference()!) : UserModel_.id_int.notNull())
              .and(userFilter.getCity() != null ? UserModel_.city.equals(userFilter.getCity()!) : UserModel_.id_int.notNull())
              .and(userFilter.getNeighborhood() != null ? UserModel_.locality.equals(userFilter.getNeighborhood()!) : UserModel_.id_int.notNull())
      ).build();
      List<UserModel> users = query.find();
      query.close();
      return users;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching users by filter: $error");
      }
      rethrow;
    }
  }

}
