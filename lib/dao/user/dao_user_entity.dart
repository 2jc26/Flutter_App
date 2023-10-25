
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/user/query_likes_user.dart';
import 'package:firebase_storage/firebase_storage.dart';


import '../../models/user/user_model_update.dart';
final storageRef = FirebaseStorage.instance.ref();
abstract class UserDao {

  Future<UserModelUpdate?> getUserById(String id);
  Future<List<UserModelUpdate>> getAllUsers();
  Future<UserModelUpdate?> validateUsernameAndPassword(String username, String password);
  Future<UserModelUpdate?> createUser(String username, String password, String fullname, int age, String phone, String genero, String city, String locality);
  // Future<void> insertUser(UserModelUpdate user);
  // Future<void> updateUser(UserModelUpdate user);
  // Future<void> deleteUser(int id);
}

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
  Future<List<UserModelUpdate>> getAllUsers() async {
    List<UserModelUpdate> users = [];
    try {
      final querySnapshot = await _firestore.collection("NewUsersTest").get();//Users
      for (var user in querySnapshot.docs) {
        final userData = user.data();
        final userId = user.id;
        var userModel = UserModelUpdate.fromJson({...userData, 'id': userId});

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
      final querySnapshot = await _firestore.collection("NewUsersTest").doc(id).get();
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
  Future<List<UserModelUpdate>> getUsersByPreferences(UserPreferencesDTO userPreferences) async {
    List<UserModelUpdate> users = [];
    try {
      Query query= _firestore.collection("NewUsersTest");
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
      //if (userPreferences.petPreference != null) {
        //query = query.where("city", isEqualTo: userPreferences.petPreference);
      //}
      //if (userPreferences.petPreference != null) {
        //query = query.where("localizati", isEqualTo: userPreferences.petPreference);
      //}


      final querySnapshot = await query.get();

      for (var user in querySnapshot.docs) {
        final userData = user.data() as Map<String, dynamic>;
        final userId = user.id;
        users.add(UserModelUpdate.fromJson({...userData, 'id': userId}));
      }
      return users;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses by likings: $error");
      }
      rethrow;
    }
  }
  Future<List<UserModelUpdate>> getDocumentsWithinRadius(double latitude, double longitude) async {
    List<UserModelUpdate> users=[];

    const double radiusInDegrees = 20;

    final double minLat = latitude - radiusInDegrees;
    final double maxLat = latitude + radiusInDegrees;
    final double minLon = longitude - radiusInDegrees;
    final double maxLon = longitude + radiusInDegrees;

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('NewUsersTest')
        .where('lat', isGreaterThanOrEqualTo: minLat)
        .where('lat', isLessThanOrEqualTo: maxLat)
        .get();

    for (var user in snapshot.docs) {
      final userData = user.data() as Map<String, dynamic>;
      if (userData["long"]>=minLon 	&& userData["long"]<=maxLon){
        final userId = user.id;
        users.add(UserModelUpdate.fromJson({...userData, 'id': userId}));
      }

    }
    return users;

  }

  @override
  Future<UserModelUpdate?> validateUsernameAndPassword(
      String username, String password) async {
    try {
      // Check if a user with the given username exists in Firestore
      final querySnapshot = await _firestore
          .collection("NewUsersTest")
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

  @override
  Future<UserModelUpdate?> createUser(String username, String password, String fullname, int age, String phone, String genero, String city, String locality) async {
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
        'username': username, 
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

      // Check if a user with the given username exists in Firestore
      final querySnapshot = await _firestore
          .collection("NewUsersTest")
          .where("username", isEqualTo: username)
          .get();

      if (querySnapshot.docs.isEmpty) {
        final docRef = await _firestore.collection("NewUsersTest").add(toJson());
        final docSnapshot = await docRef.get();
        final userData = docSnapshot.data();
        final userId = docSnapshot.id;
        if (userData != null) {
          final userModel = UserModelUpdate.fromJson({...userData, 'id': userId});
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

  
}