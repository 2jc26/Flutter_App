
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/service/backend_service.dart';

abstract class ReviewServiceAdapter {
  Future<List<ReviewModel>> getAllReviews(String houseId);
}

class ReviewServiceAdapterBackend implements ReviewServiceAdapter {

  @override
  Future<List<ReviewModel>> getAllReviews(String houseId) async {
    try {
      final dynamicReviews = await BackendService().getOneAll("reviews", houseId);
      List<ReviewModel> reviews = dynamicReviews.map((review) {
        return ReviewModel.fromJson(review);
      }).toList();
      return reviews;
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching reviews: $error");
      }
      rethrow;
    }

  }

  Future<void> insertReview(ReviewModel review) async {
    try {
      final message = await BackendService().post("reviews", review);
      if (message != 'Review added successfully') {
        throw message;
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error inserting review: $error");
      }
      rethrow;
    }
  }

}