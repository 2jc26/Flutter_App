import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/models/user/user_model.dart';
import 'package:giusseppe_flut/repository/principal_repository.dart';
import 'package:giusseppe_flut/screens/principal.dart';

class PrincipalPresenter {
  final PrincipalRepository principalRepository = PrincipalRepository();
  List<HouseModelUpdate> housesList = [];
  List<UserModel> userList = [];
  List<ReviewModel> reviewList = [];
  late PrincipalViewAbs _backView = PrincipalViewAbs();
  int _number = 0;

  PrincipalPresenter(String? userId) {
    getAllHouses();
    getAllUser();
    getAllReview(userId??"");
  }

  void refreshData(String? userId) {
    getAllHouses();
    getAllUser();
    getAllReview(userId??"");
  }

  Future<void> getAllHouses() async {
    try {
      final houses = await principalRepository.getAllHouses();
      if (houses.isNotEmpty) {
        housesList = houses;
        _backView.refreshHousesPrincipalView(housesList);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getAllUser() async {
    try {
      final user = await principalRepository.getAllUser();
      if (user.isNotEmpty) {
        userList = user;
        _backView.refreshUsersPrincipalView(userList);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getAllReview(String userId, {int skip = 0, int limit = 5}) async {
    try {
      _number = await principalRepository.getLenght(userId);
      // haz que _number se divida en 5 y redondea hacia arriba
      _number = ((_number / 5) + 0.5).toInt();
      final review = await principalRepository.getAllReview(userId, skip: skip, limit: limit);
      if (review.isNotEmpty) {
        reviewList = review;
        _backView.refreshReviewsPrincipalView(reviewList);
        _backView.refreshNumber(_number);
      }
    } catch (error) {
      rethrow;
    }
  }

    void addVisitToHouse(String houseId) async {
    try {
      await principalRepository.addVisitToHouse(houseId);
    } catch (error) {
      rethrow;
    }
  }

  set backView(PrincipalViewAbs value) {
    _backView = value;
    _backView.refreshHousesPrincipalView(housesList);
    _backView.refreshUsersPrincipalView(userList);
    _backView.refreshReviewsPrincipalView(reviewList);
  }

}
