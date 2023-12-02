
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/service/backend_service.dart';

abstract class ReviewServiceAdapter {
  Future<List<ReviewModel>> getAllReviews(String houseId);
  Future<List<ReviewModel>> getAllReviewsUser(String userId);
  Future<void> insertReview(String houseId, String userId, String comment, double rating);
  Future<void> updateRaiting(String houseId);
}

class ReviewServiceAdapterBackend implements ReviewServiceAdapter {

  @override
  Future<List<ReviewModel>> getAllReviews(String houseId, {int skip = 0, int limit = 5}) async {
    try {
      final dynamicReviews = await BackendService().getReviewsPaginated("reviews", houseId, skip, limit);
      if (dynamicReviews.isNotEmpty) {
        return await compute(parseObjects, dynamicReviews);
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<ReviewModel>> getAllReviewsUser(String userId, {int skip = 0, int limit = 5}) async {
    try {
      final dynamicReviews = await BackendService().getReviewsPaginated("reviews/user", userId, skip, limit);
      if (dynamicReviews.isNotEmpty) {
        return await compute(parseObjects, dynamicReviews);
      } else {
        return [];
      }
    } catch (error) {
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
      if (decodeMessage['message'] != 'Rating updated successfully' && decodeMessage['message'] != 'No reviews for this house') {
        throw decodeMessage['message'];
      }
      return decodeMessage['raiting'].toDouble();
    } catch (error) {
      if (kDebugMode) {
        print("Error updating house: $error");
      }
      rethrow;
    }
  }

  @override
  Future<int> getLenght(String houseId) async {
    try {
      final message = await BackendService().getNum("total/reviews", houseId);
      final decodeMessage = json.decode(message);
      if (decodeMessage['message'] != 'Total Reviews') {
        throw decodeMessage['message'];
      }
      return decodeMessage['count'];
    } catch (error) {
      if (kDebugMode) {
        print("Error searching for reviews: $error");
      }
      rethrow;
    }
  }

  Future<int> getLenghtUser(String userId) async {
    try {
      final message = await BackendService().getNum("total/reviews/user", userId);
      final decodeMessage = json.decode(message);
      if (decodeMessage['message'] != 'Total Reviews') {
        throw decodeMessage['message'];
      }
      return decodeMessage['count'];
    } catch (error) {
      if (kDebugMode) {
        print("Error searching for reviews: $error");
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