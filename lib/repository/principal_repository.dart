import 'dart:async';

import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/models/user/user_model.dart';
import 'package:giusseppe_flut/repository/house_repository.dart';
import 'package:giusseppe_flut/repository/review_repository.dart';
import 'package:giusseppe_flut/repository/user_repository.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'package:giusseppe_flut/storage/storage_adapters/Objectbox/ObjectBox.dart';
import 'package:giusseppe_flut/storage/storage_adapters/file_manager.dart';

class PrincipalRepository {

  final UserRepository userRepository = UserRepository();
  final HouseRepository houseRepository = HouseRepository();
  final ReviewRepository reviewRepository = ReviewRepository();
  final ObjectBoxDao objectBoxDao = ObjectBoxDao();

  bool connectivity = ConnectivityManagerService().connectivity;
  late StreamSubscription<bool> connectionSubscription;

  PrincipalRepository() {
    FileManager.initialFile();
    connectionSubscription = ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
    });
  }

  Future<List<HouseModelUpdate>> getAllHouses() async {
    try {
      if(connectivity) {
        return await houseRepository.getTopHouses();
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<UserModel>> getAllUser() async {
    try {
      if(connectivity) {
        return await userRepository.getTopUsers();
      } else {
        return await objectBoxDao.getTop5();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ReviewModel>> getAllReview(String userId, {int skip = 0, int limit = 5}) async {
    try {
      if(connectivity) {
        return await reviewRepository.getAllReviewsUser(userId, skip: skip, limit: limit);
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

    Future<void> addVisitToHouse(String houseId) async {
    try {
      houseRepository.addVisitToHouse(houseId);
    } catch (error) {
      rethrow;
    }
  }

  Future<int> getLenght(String userId) async {
    try {
        return await reviewRepository.getLenghtUser(userId);
    } catch (error) {
      rethrow;
    }
  }
}