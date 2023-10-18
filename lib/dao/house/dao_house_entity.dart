
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/houseLiking/house_liking_model_update.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';

import '../../models/house/house_model_update.dart';

abstract class HouseDao {

  Future<List<HouseModelUpdate>> getAllHouses();
  Future<HouseModelUpdate?> getHouseById(String id);
  Future<List<HouseModelUpdate>> getHousesByLikings(HouseLikingModelUpdate likings);
  Future<List<HouseModelUpdate>> getHousesByFilters(HouseSearchingModelUpdate filters);
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
        final houseData = house.data();
        final houseId = house.id;
        final houseModel = HouseModelUpdate.fromJson({...houseData, 'id': houseId});
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
  Future<HouseModelUpdate> getHouseById(String id) async {
    try {
      final querySnapshot = await _firestore.collection("Houses").doc(id).get();
      final houseData = querySnapshot.data();
      final houseId = querySnapshot.id;

      if (houseData != null) {
        final houseModel = HouseModelUpdate.fromJson({...houseData, 'id': houseId});
        return houseModel;
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
  
  @override
  Future<List<HouseModelUpdate>> getHousesByLikings(HouseLikingModelUpdate likings) async {
    List<HouseModelUpdate> houses = [];
    try {
      final querySnapshot = await _firestore
          .collection("Houses")
          .where("city", isEqualTo: likings.city)
          .where("stratum", isEqualTo: likings.stratum)
          .where("roomsNumber", isEqualTo: likings.roomsNumber)
          .where("bathroomsNumber", isEqualTo: likings.bathroomsNumber)
          .where("laundryArea", isEqualTo: likings.laundryArea)
          .where("internet", isEqualTo: likings.internet)
          .where("tv", isEqualTo: likings.tv)
          .where("furnished", isEqualTo: likings.furnished)
          .where("elevator", isEqualTo: likings.elevator)
          .where("gymnasium", isEqualTo: likings.gymnasium)
          .where("reception", isEqualTo: likings.reception)
          .where("supermarkets", isEqualTo: likings.supermarkets)
          .limit(2)
          .get();
      for (var house in querySnapshot.docs) {
        final houseData = house.data();
        final houseId = house.id;
        final houseModel = HouseModelUpdate.fromJson({...houseData, 'id': houseId});
        houses.add(houseModel);
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
      List<HouseModelUpdate> allHouses = [];

      if (filters == null) {
        return allHouses;
      }

      final querySnapshot = await _firestore.collection("Houses").get();

      for (var house in querySnapshot.docs) {
        final houseData = house.data();
        final houseId = house.id;
        final houseModel = HouseModelUpdate.fromJson({...houseData, 'id': houseId});
        allHouses.add(houseModel);
      }

      List<HouseModelUpdate> filteredHouses = allHouses.where((house) {
        int matchingAttributes = 0;

        if (house.city == filters.city) matchingAttributes++;
        if (house.neighborhood == filters.neighborhood) matchingAttributes++;
        if (house.housingType == filters.housingType) matchingAttributes++;
        if (house.rentPrice == filters.rentPrice) matchingAttributes++;
        if (house.stratum == filters.stratum) matchingAttributes++;
        if (house.area == filters.area) matchingAttributes++;
        if (house.apartmentFloor == filters.apartmentFloor) matchingAttributes++;
        if (house.roomsNumber == filters.roomsNumber) matchingAttributes++;
        if (house.bathroomsNumber == filters.bathroomsNumber) matchingAttributes++;
        if (house.laundryArea == filters.laundryArea) matchingAttributes++;
        if (house.internet == filters.internet) matchingAttributes++;
        if (house.tv == filters.tv) matchingAttributes++;
        if (house.furnished == filters.furnished) matchingAttributes++;
        if (house.elevator == filters.elevator) matchingAttributes++;
        if (house.gymnasium == filters.gymnasium) matchingAttributes++;
        if (house.reception == filters.reception) matchingAttributes++;
        if (house.supermarkets == filters.supermarkets) matchingAttributes++;
        return matchingAttributes >= 14;
      }).toList();

      return filteredHouses;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching houses by searching: $error");
      }
      rethrow;
    }
  }
}