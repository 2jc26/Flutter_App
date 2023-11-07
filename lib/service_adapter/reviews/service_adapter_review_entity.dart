
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
      final dynamicReviews = await BackendService().getOneAll("reviews", houseId);

      if (dynamicReviews != null && dynamicReviews is List) {
        List<ReviewModel> reviews = dynamicReviews.map((review) {
          return ReviewModel.fromJson(review);
        }).toList();
        return reviews;
      } else {
        print("Invalid or null dynamicReviews data");
        return [];
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching reviews: $error");
      }
      rethrow;
    }
  }

  @override
  Future<ReviewModel> insertReview(String houseId, String userId, String comment, double rating) async {
    try {
      final reviewSkeleton = {
        'houseId': houseId,
        'userId': userId,
        'comment': comment,
        'rating': rating,
      };
      ReviewModel review = ReviewModel.fromJson(reviewSkeleton);
      final message = await BackendService().post("reviews", review);
      final decodeMessage = json.decode(message);
      if (decodeMessage['message'] != 'Review added successfully') {
        throw decodeMessage['message'];
      }
      return review;
    } catch (error) {
      if (kDebugMode) {
        print("Error inserting review: $error");
      }
      rethrow;
    }
  }

  @override
  Future<String> updateRaiting(String houseId) async {
    try {
      final message = await BackendService().put("houses", {}, houseId);
      // final decodeMessage = json.decode(message);
      // if (decodeMessage['message'] != 'Rating updated successfully') {
      //   throw decodeMessage['message'];
      // }
      // return decodeMessage['raiting'];
      return message;
    } catch (error) {
      if (kDebugMode) {
        print("Error updating house: $error");
      }
      rethrow;
    }
  }

}