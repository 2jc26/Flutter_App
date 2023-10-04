import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';

abstract class HouseSearchingDao {
  // Future<List<HouseModelUpdate>> getAllHouses();
  Future<HouseSearchingModelUpdate?> getHouseSearchingById(String id);
  // Future<void> insertHouse(HouseModelUpdate house);
  Future<void> updateHouseSearchingById(
      String id, HouseSearchingModelUpdate searchFilters);
  Future<HouseSearchingModelUpdate?> getHouseFilters();
  Future<void> updateHouseFilters(HouseSearchingModelUpdate searchFilters);
  // Future<void> deleteHouse(int id);
}

// Search filters used by each user

class HouseSearchingDaoFireStore extends HouseSearchingDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<HouseSearchingModelUpdate?> getHouseSearchingById(String id) async {
    HouseSearchingModelUpdate searchFilters;
    try {
      final querySnapshot =
          await _firestore.collection("Searchs").doc(id).get();
      searchFilters = HouseSearchingModelUpdate.fromJson(querySnapshot.data()!);
      return searchFilters;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching house searching: $error");
      }
      rethrow;
    }
  }

  @override
  Future<void> updateHouseSearchingById(
      String id, HouseSearchingModelUpdate searchFilters) async {
    try {
      await _firestore
          .collection("Searchs")
          .doc(id)
          .update(searchFilters.toJson());
    } catch (error) {
      if (kDebugMode) {
        print("Error updating house searching: $error");
      }
      rethrow;
    }
  }

  // Count user filters

  @override
  Future<HouseSearchingModelUpdate?> getHouseFilters() async {
    HouseSearchingModelUpdate searchFilters;
    try {
      final querySnapshot =
          await _firestore.collection("Filters").doc("House").get();
      searchFilters = HouseSearchingModelUpdate.fromJson(querySnapshot.data()!);
      return searchFilters;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching house searching: $error");
      }
      rethrow;
    }
  }

  @override
  Future<void> updateHouseFilters(
      HouseSearchingModelUpdate searchFilters) async {
    try {
      
      DocumentSnapshot docSnapshot = await _firestore
          .collection("FiltersHouse")
          .doc('snF8sl1hqZpisoFQGXF7')
          .get();

      if (docSnapshot.exists) {
        Map<String, dynamic> currentFilters =
            docSnapshot.data() as Map<String, dynamic>;
            
        searchFilters.toJson().forEach((key, value) {
          if (value != false && value != 0 && value != '') {
            currentFilters[key] = (currentFilters[key] ?? 0) + 1;
          }
        });

        await _firestore
            .collection("FiltersHouse")
            .doc('snF8sl1hqZpisoFQGXF7')
            .update(currentFilters);
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error updating house searching: $error");
      }
      rethrow;
    }
  }
}
