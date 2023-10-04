
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/houseLiking/house_liking_model_update.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';

import '../../models/house/house_model_update.dart';

abstract class HouseDao {

  Future<List<HouseModelUpdate>> getAllHouses();
  Future<HouseModelUpdate?> getHouseById(String id);
  Future<List<HouseModelUpdate>> getHousesByLikings(HouseLikingModelUpdate likings);
  Future<List<HouseModelUpdate>> getHousesBySearchs(HouseSearchingModelUpdate searchs);
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
<<<<<<< HEAD

        houses.add(HouseModelUpdate.fromJson(house.data()));
=======
        final houseData = house.data();
        final houseId = house.id;
        final houseModel = HouseModelUpdate.fromJson({...houseData, 'id': houseId});
        houses.add(houseModel);
>>>>>>> 0a1d85f1ffc58e308ef9cb829274ee000796e821
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
  Future<List<HouseModelUpdate>> getHousesBySearchs(HouseSearchingModelUpdate searchs) async {
    List<HouseModelUpdate> houses = [];
    try {
      final querySnapshot = await _firestore
          .collection("Houses")
          .where("city", isEqualTo: searchs.city)
          .where("neighborhood", isEqualTo: searchs.neighborhood)
          .where("housingType", isEqualTo: searchs.housingType)
          .where("rentPrice", isEqualTo: searchs.rentPrice)
          .where("stratum", isEqualTo: searchs.stratum)
          .where("area", isEqualTo: searchs.area)
          .where("apartmentFloor", isEqualTo: searchs.apartmentFloor)
          .where("roomsNumber", isEqualTo: searchs.roomsNumber)
          .where("bathroomsNumber", isEqualTo: searchs.bathroomsNumber)
          .where("laundryArea", isEqualTo: searchs.laundryArea)
          .where("internet", isEqualTo: searchs.internet)
          .where("tv", isEqualTo: searchs.tv)
          .where("furnished", isEqualTo: searchs.furnished)
          .where("elevator", isEqualTo: searchs.elevator)
          .where("gymnasium", isEqualTo: searchs.gymnasium)
          .where("reception", isEqualTo: searchs.reception)
          .where("supermarkets", isEqualTo: searchs.supermarkets)
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
        print("Error fetching houses by searching: $error");
      }
      rethrow;
    }
  }
}