import 'dart:async';

import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'package:giusseppe_flut/service_adapter/reviews/service_adapter_review_entity.dart';

class ReviewRepository {
  final ReviewServiceAdapterBackend reviewApi= ReviewServiceAdapterBackend();

  bool connectivity = ConnectivityManagerService().connectivity;
  late StreamSubscription<bool> connectionSubscription;

  ReviewRepository() {
    connectionSubscription = ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
    });
  }

  Future<List<ReviewModel>> getAllReviews(String houseId, {int skip = 0, int limit = 5}) async {
    try {
      if (connectivity) {
        return await reviewApi.getAllReviews(houseId, skip: skip, limit: limit);
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

<<<<<<< HEAD
  Future<void> insertReview(String houseId, String userId, String comment, double rating) {
=======
  Future<List<ReviewModel>> getAllReviewsUser(String userId, {int skip = 0, int limit = 5}) async {
>>>>>>> origin/develop
    try {
      if (connectivity) {
        return await reviewApi.getAllReviewsUser(userId, skip: skip, limit: limit);
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

<<<<<<< HEAD
  Future<double> updateRaiting(String houseId){
=======
  Future<void> insertReview(String houseId, String userId, String comment, double rating) {
>>>>>>> origin/develop
    try {
      if(connectivity) {
        return reviewApi.insertReview(houseId, userId, comment, rating);
      } else {
        return Future.value();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<double> updateRaiting(String houseId){
    try {
      if(connectivity) {
        return reviewApi.updateRaiting(houseId);
      } else {
        return Future.value(0.0);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<int> getLenght(String houseId){
    try {
      if(connectivity) {
        return reviewApi.getLenght(houseId);
      } else {
        return Future.value(0);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<int> getLenghtUser(String houseId){
    try {
      if(connectivity) {
        return reviewApi.getLenghtUser(houseId);
      } else {
        return Future.value(0);
      }
    } catch (error) {
      rethrow;
    }
  }
  
}
