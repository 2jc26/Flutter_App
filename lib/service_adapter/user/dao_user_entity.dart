
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/user/query_filter_user.dart';
import 'package:giusseppe_flut/models/user/query_likes_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:giusseppe_flut/storage/storage_adapters/Objectbox/ObjectBox.dart';
import 'package:giusseppe_flut/service/backend_service.dart';


import '../../models/user/user_model.dart';
import 'abstract/base_user_dao.dart';
final storageRef = FirebaseStorage.instance.ref();


class UserDaoFireStore extends UserDao{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final storage = FirebaseStorage.instance;
  //final storageRef = FirebaseStorage.instance.ref();

  Future<Uint8List?> getImage(String image) async {
    final ref = storageRef.child(image);
    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await ref.getData(oneMegabyte);
      return data;
      // Data for "images/island.jpg" is returned, use this as needed.
    } on FirebaseException catch (e) {
      // Handle any errors.
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> users = [];
    try {
      final querySnapshot = await _firestore.collection("Users").get();//Users
      for (var user in querySnapshot.docs) {
        final userData = user.data();
        final userId = user.id;
        var userModel = UserModel.fromJson({...userData, 'id': userId});

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
  Future<UserModel> getUserById(String id) async {
    try {
      final querySnapshot = await _firestore.collection("Users").doc(id).get();
      final userData = querySnapshot.data();
      final userId = querySnapshot.id;

      if (userData != null) {
        final userModel = UserModel.fromJson({...userData, 'id': userId});
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
  Stream<List<UserModel>> getUsersByPreferencesStream() {
    final controller = StreamController<List<UserModel>>();

    try {
      Query query = _firestore.collection("Users");

      final stream = query.snapshots();
      stream.listen((querySnapshot) {
        List<UserModel> users = [];

        for (var user in querySnapshot.docs) {
          final userData = user.data() as Map<String, dynamic>;
          final userId = user.id;
          UserModel nuevoUsuario = UserModel.fromJson({...userData, 'id': userId});
          users.add(nuevoUsuario);
        }

        controller.add(users);
      });

    } catch (error) {
      if (kDebugMode) {
        print("Error fetching users by filter: $error");
      }
      controller.addError(error);
    }

    return controller.stream;
  }

  Future<List<UserModel>> getAllUsersByPreferences(UserPreferencesDTO userPreferences) {

    throw UnimplementedError();

  }

  @override
  Future<List<UserModel>> getUsersByPreferences() async {
    List<UserModel> users = [];

    try {
      updateUserPreferencesStats();
      Query query= _firestore.collection("Users");
      String? userFilter= UserFilter().getCity();
      String? cc = UserFilter().getNeighborhood();
      bool? pet_did=UserFilter().getPetPreference();

      String? intro=UserFilter().getIntrovertedPreference();

      String? cle=UserFilter().getCleaningFrequency();

      bool? vapee=UserFilter().getVapePreference();

      bool? smokee=UserFilter().getSmokePreference();

      bool? worrkk= UserFilter().getWorkFromHomePreference();

      int? sleeep=UserFilter().getSleepTime();

      if (UserFilter().getExternalPeopleFrequency() != null) {
        query = query.where("bring_people", isEqualTo: UserFilter().getExternalPeopleFrequency());
      }
      if (UserFilter().getSleepTime() != null) {
        query = query.where("sleep", isEqualTo: UserFilter().getSleepTime());
      }
      if (UserFilter().getSmokePreference() != null) {
        query = query.where("smoke", isEqualTo: UserFilter().getSmokePreference());
      }
      if (UserFilter().getVapePreference() != null) {
        query = query.where("vape", isEqualTo: UserFilter().getVapePreference());
      }
      if (UserFilter().getCleaningFrequency()!= null) {
        query = query.where("clean", isEqualTo: UserFilter().getCleaningFrequency());
      }
      if (UserFilter().getIntrovertedPreference()!= null) {
        query = query.where("personality", isEqualTo: UserFilter().getIntrovertedPreference());
      }
      if (UserFilter().getPetPreference() != null) {
        query = query.where("likes_pets", isEqualTo: UserFilter().getPetPreference());
      }
      if (UserFilter().getCity() != null) {
        query = query.where("city", isEqualTo: UserFilter().getCity());
      }
      if (UserFilter().getNeighborhood() != null) {
        query = query.where("locality", isEqualTo: UserFilter().getNeighborhood());
      }
      final querySnapshot = await query.get();

      for (var user in querySnapshot.docs) {
        final userData = user.data() as Map<String, dynamic>;
        final userId = user.id;
        UserModel nuevoUsuario=UserModel.fromJson({...userData, 'id': userId});
        users.add(nuevoUsuario);
      }
      return users;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching users by filter: $error");
      }
      rethrow;
    }
  }
  Future<List<UserModel>> getDocumentsWithinRadius(double latitude, double longitude) async {
    List<UserModel> users=[];

    const double radiusInDegrees = 20;

    final double minLat = latitude - radiusInDegrees;
    final double maxLat = latitude + radiusInDegrees;
    final double minLon = longitude - radiusInDegrees;
    final double maxLon = longitude + radiusInDegrees;

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('lat', isGreaterThanOrEqualTo: minLat)
        .where('lat', isLessThanOrEqualTo: maxLat)
        .get();

    for (var user in snapshot.docs) {
      final userData = user.data() as Map<String, dynamic>;
      if (userData["long"]>=minLon 	&& userData["long"]<=maxLon){
        final userId = user.id;
        users.add(UserModel.fromJson({...userData, 'id': userId}));
      }

    }
    return users;

  }

  @override
  Future<UserModel?> validateEmailAndPassword(
      String email, String password) async {
    try {
      // Check if a user with the given email exists in Firestore
      final querySnapshot = await _firestore
          .collection("Users")
          .where("email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User with the given email exists
        final userData = querySnapshot.docs.first.data();
        final userId = querySnapshot.docs.first.id;
        final storedPasswordHash = userData['password']; // Replace with the actual field name in Firestore

        if (password == storedPasswordHash) {
          if (userData != null) {
            final userModel = UserModel.fromJson({...userData, "id": userId});
            return userModel;
          }
        }
      }

      // User does not exist or password doesn't match
      return null;
    } catch (error) {
      if (kDebugMode) {
        print("Error validating email and password: $error");
      }
      rethrow;
    }
  }

  @override
  Future<UserModel?> createUser(String email, String password, String fullname, int age, String phone, String genero, String city, String locality) async {
    try {
      // To Do In base of city and locality get lat and long
      String bringPeople = '';
      int sleep = 0;
      int phoneFin = int.parse(phone);
      bool vape = false;
      String personality = '';
      bool likesPets = false;
      String clean = '';
      bool smoke = false;
      double lat = 4.601932494220323;
      double long = -74.0653645602065;
      int star = 5;     

      Map<String, dynamic> toJson() => {
        'email': email,
        'password': password, 
        'name': fullname, 
        'age': age, 
        'phone': phoneFin, 
        'gender': genero, 
        'bring_people': bringPeople, 
        'sleep': sleep, 
        'vape': vape, 
        'personality': personality, 
        'likes_pets': likesPets, 
        'clean': clean, 
        'smoke': smoke,
        'lat': lat, 
        'long': long, 
        'stars': star,
        'locality':locality,
        'city':city,
        'image':'images_profile/Male/7.jpg'
      };

      // Check if a user with the given email exists in Firestore
      final querySnapshot = await _firestore
          .collection("Users")
          .where("email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        final docRef = await _firestore.collection("Users").add(toJson());
        final docSnapshot = await docRef.get();
        final userData = docSnapshot.data();
        final userId = docSnapshot.id;
        if (userData != null) {
          final userModel = UserModel.fromJson({...userData, 'id': userId});
          return userModel;
        } else {
          throw Exception("User not created");
        }
      } else {
        throw Exception("User already exists");
      }
    } catch (error) {
      if (kDebugMode) {
        throw Exception("Error creating user: $error");
      }
      rethrow;
    }
  }

  Future<void> updateUserPreferencesStats() async {
    try {
      print(UserFilter().toJson());
      BackendService().putAll("stats/usersfilters", UserFilter());

    } catch (error) {
      if (kDebugMode) {
        print("Error updating preferences stats: $error");
      }
      rethrow;
    }
  }
  
}