
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/service/backend_service.dart';

abstract class ReviewServiceAdapter {
  Future<List<ReviewModel>> getAllReviews(String houseId);
  Future<void> insertReview(String houseId, String userId, String comment, double rating);
  Future<void> updateRaiting(String houseId);
}

class ReviewServiceAdapterBackend implements ReviewServiceAdapter {

  @override
  Future<List<ReviewModel>> getAllReviews(String houseId) async {
    try {

      List<ReviewModel> reviews = [];

      final dynamicReviews = await BackendService().getOneAll("reviews", houseId);
      
      if(dynamicReviews.isNotEmpty) {
        reviews = await compute(parseObjects, dynamicReviews);
        return reviews;
      } else {
        return reviews;
      }
      
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching reviews: $error");
      }
      rethrow;
    }
  }

  @override
  Future<void> insertReview(String houseId, String userId, String comment, double rating) async {
    try {
      final reviewSkeleton = {
        'houseId': houseId,
        'userId': userId,
        'comment': comment,
        'rating': rating,
      };
      await BackendService().post("reviews", reviewSkeleton);
    } catch (error) {
      if (kDebugMode) {
        print("Error inserting review: $error");
      }
      rethrow;
    }
  }

  @override
  Future<double> updateRaiting(String houseId) async {
    try {
      final message = await BackendService().put("houses", {}, houseId);
      final decodeMessage = json.decode(message);
      if (decodeMessage['message'] != 'Rating updated successfully') {
        throw decodeMessage['message'];
      }
      return decodeMessage['raiting'];
    } catch (error) {
      if (kDebugMode) {
        print("Error updating house: $error");
      }
      rethrow;
    }
  }

}

Future<List<ReviewModel>> parseObjects(List<dynamic> querySnapshot) async {
  List<ReviewModel> reviews=[];
  for (var review in querySnapshot) {
    ReviewModel nuevaReview=ReviewModel.fromJson({...review});
    reviews.add(nuevaReview);
  }
  return reviews;
}