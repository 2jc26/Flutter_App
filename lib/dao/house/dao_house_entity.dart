
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/house/house_model_update.dart';

abstract class HouseDao {

  Future<List<HouseModelUpdate>> getAllHouses();
  Future<HouseModelUpdate?> getHouseById(String id);
  // Future<void> insertHouse(HouseModelUpdate house);
  // Future<void> updateHouse(HouseModelUpdate house);
  // Future<void> deleteHouse(int id);
}

class HouseDaoFireStore extends HouseDao {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<HouseModelUpdate>> getAllHouses() async {
    List<HouseModelUpdate> houses = [];
    try {
      final querySnapshot = await _firestore.collection("Houses").get();
      for (var house in querySnapshot.docs) {
        houses.add(HouseModelUpdate.fromJson(house.data()));
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
  Future<HouseModelUpdate> getHouseById(String id) async {
    try {
      final querySnapshot = await _firestore.collection("Houses").doc(id).get();
      final data = querySnapshot.data();

      if (data != null) {
        return HouseModelUpdate.fromJson(data);
      } else {
        throw Exception("No data found for ID: $id");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses: $error");
      }
      rethrow;
    }
  }
  
}