import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/service_adapter/reviews/service_adapter_review_entity.dart';

class ReviewRepository {
  final ReviewServiceAdapterBackend reviewApi= ReviewServiceAdapterBackend();

  Future<List<ReviewModel>> getAllReviews(String houseId) async {
    try {
      return await reviewApi.getAllReviews(houseId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> insertReview(String houseId, String userId, String comment, double rating) {
    try {
      return reviewApi.insertReview(houseId, userId, comment, rating);
    } catch (error) {
      rethrow;
    }
  }

  Future<double> updateRaiting(String houseId){
    try {
      return reviewApi.updateRaiting(houseId);
    } catch (error) {
      rethrow;
    }
  }
  
}
