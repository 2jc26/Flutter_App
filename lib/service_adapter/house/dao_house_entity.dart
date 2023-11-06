
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/service/backend_service.dart';

import '../../models/house/house_model_update.dart';
final storageRef = FirebaseStorage.instance.ref();
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
  Future<List<HouseModelUpdate>> getAllHouses() async {
    List<HouseModelUpdate> houses = [];
    try {
      final querySnapshot = await BackendService().getAll("houses");
      for (var house in querySnapshot) {
        final houseModel = HouseModelUpdate.fromJson(house);
        houses.add(houseModel);
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
      final querySnapshot = await BackendService().getAll("users/$userId/houseliking");
      if (querySnapshot.isEmpty) {
        return [];
      } else {
        List<HouseModelUpdate> houses = [];
        for (var house in querySnapshot) {
          print(house.toString());
          final houseModel = HouseModelUpdate.fromJson(house);
          houses.add(houseModel);
        }
        return houses;
      }
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
      for (var house in querySnapshot) {
        final houseModel = HouseModelUpdate.fromJson(house);
        filteredHouses.add(houseModel);
      }

      return filteredHouses;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses by searching: $error");
      }
      rethrow;
    }
  }
}