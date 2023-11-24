import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/repository/review_repository.dart';
import 'package:giusseppe_flut/screens/review_list.dart';

class ReviewListPresenter {

  final ReviewRepository reviewRepository = ReviewRepository();
  List<ReviewModel> reviewsList = [];
  String _raiting = '0';

  late ReviewsListView _view = ReviewsListView();


  ReviewListPresenter(String houseId) {

    getAllReviews(houseId);

  }


  void getAllReviews(String houseId) async {
    try {
      final reviews = await reviewRepository.getAllReviews(houseId);
      if (reviews.isNotEmpty) {
        reviewsList = reviews;
        _view.refreshReviewListView(reviewsList);
      }
    } catch (error) {
      rethrow;
    }
  }

  void postReview(String houseId, String userId, String comment, double rating) async {
    try {
      await reviewRepository.insertReview(houseId, userId, comment, rating);
      getAllReviews(houseId);
      putReview(houseId);
    } catch (error) {
      rethrow;
    }
  }

  void putReview(String houseId) async {
    try {
      final responsRaiting = await reviewRepository.updateRaiting(houseId);
      if (responsRaiting != null) {
        _raiting = responsRaiting.toStringAsFixed(2);
        _view.refreshRaiting(_raiting);
      }
    } catch (error) {
      rethrow;
    }
  }

  set backView(ReviewsListView value) {
    _view = value;
    _view.refreshReviewListView(reviewsList);
    _view.refreshRaiting(_raiting);
  }

}