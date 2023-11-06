
import 'package:flutter/foundation.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/service/backend_service.dart';

abstract class ReviewServiceAdapter {
  Future<List<ReviewModel>> getAllReviews();
}

class ReviewServiceAdapterBackend implements ReviewServiceAdapter {

  @override
  Future<List<ReviewModel>> getAllReviews() async {
    try {
      final dynamicReviews = await BackendService().getAll("reviews");
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

}