
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/houseLiking/house_liking_model_update.dart';

abstract class HouseLikingDao {

  // Future<List<HouseModelUpdate>> getAllHouses();
  Future<HouseLikingModelUpdate?> getHouseLikingById(String id);
  // Future<void> insertHouse(HouseModelUpdate house);
  // Future<void> updateHouse(HouseModelUpdate house);
  // Future<void> deleteHouse(int id);
}

class HouseLikingDaoFireStore extends HouseLikingDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<HouseLikingModelUpdate?> getHouseLikingById(String id) async {
    HouseLikingModelUpdate house;
    try {
      final querySnapshot = await _firestore.collection("HouseLiking").doc(id).get();
      house = HouseLikingModelUpdate.fromJson(querySnapshot.data()!);
      return house;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching house liking: $error");
      }
      rethrow;
    }
  }

}