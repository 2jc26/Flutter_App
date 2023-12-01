
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/service/backend_service.dart';
import 'package:giusseppe_flut/service/firebase_storage_service.dart';

import '../../models/house/house_model_update.dart';

final storageRef = FirebaseStorageService();

abstract class HouseDao {

  Future<List<HouseModelUpdate>> getAllHouses();
  Future<List<HouseModelUpdate>> getHouseLikingByUserId(String userId);
  Future<List<HouseModelUpdate>> getHousesByFilters(HouseSearchingModelUpdate filters);
  // Future<HouseModelUpdate?> getHouseById(String id);
  // Future<void> insertHouse(HouseModelUpdate house);
  // Future<void> updateHouse(HouseModelUpdate house);
  // Future<void> deleteHouse(int id);
}

class HouseDaoFireStore extends HouseDao {

  @override
  Future<void> createHouse(HouseModelUpdate house) async {
    try {
      BackendService().post("houses", house);
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses: $error");
      }
      rethrow;
    }
  }

  @override
  Future<String?> uploadImage(String path, File image, String num) async {
    try {
      return await storageRef.uploadImage(image, path, num);
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses: $error");
      }
      rethrow;
    }
  }
  
  @override
  Future<List<HouseModelUpdate>> getAllHouses() async {
    List<HouseModelUpdate> houses = [];
    try {
      final querySnapshot = await BackendService().getAll("houses");
      if (querySnapshot.isEmpty) {
        return [];
      } else {
        houses = await compute(parseObjects,querySnapshot);
      }
      return houses;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses: $error");
      }
      rethrow;
    }
  }
  
  @override
  Future<List<HouseModelUpdate>> getHouseLikingByUserId(String userId) async {
    try {
      List<HouseModelUpdate> houses = [];

      final querySnapshot = await BackendService().getAll("users/$userId/houseliking");
      if (querySnapshot.isEmpty) {
        return [];
      } else {
        houses = await compute(parseObjects,querySnapshot);
      }
      return houses;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses by likings: $error");
      }
      rethrow;
    }
  }

  @override
  Future<List<HouseModelUpdate>> getHousesByFilters(HouseSearchingModelUpdate? filters) async {
    try {
      
      List<HouseModelUpdate> filteredHouses = [];

      if (filters == null) {
        return filteredHouses;
      }

      final querySnapshot = await BackendService().postAll("houses/filtered", filters);
      if (querySnapshot.isNotEmpty) {
        filteredHouses = await compute(parseObjects,querySnapshot);
      }

      return filteredHouses;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses by searching: $error");
      }
      rethrow;
    }
  }

  Future<void> addVisitToHouse(String houseId) async {
    try {
      await BackendService().putVisit(houseId);
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses: $error");
      }
      rethrow;
    }
  }

  Future<List<String>> getTopDescriptions() async {
    try {
      List<String> descriptions = [];

      final querySnapshot = await BackendService().getAll("houses/bestdescriptions");
      if (querySnapshot.isEmpty) {
        return [];
      } else {
        return descriptions;
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching descriptions: $error");
      }
      rethrow;
    }
  }
}

Future<List<HouseModelUpdate>> parseObjects(List<dynamic> querySnapshot) async {
  List<HouseModelUpdate> houses=[];
  for (var house in querySnapshot) {
    //final userData = user.data() as Map<String, dynamic>;
    HouseModelUpdate newHouse=HouseModelUpdate.fromJson({...house});
    houses.add(newHouse);
  }
  return houses;
}