import '../models/user/query_likes_user.dart';
import '../models/user/user_model_update.dart';
import '../repository/user_repository_prueba.dart';
import '../screens/user_list.dart';
import '../screens/views_abs.dart';
import 'package:geolocator/geolocator.dart';

class UserListPresenterLocation {
  final UserRepository userRepository = UserRepository();
  List<UserModelUpdate>? usersList = [];
  late UserListView _backView= UserListView();
  UserPreferencesDTO? userPreferences;
  double? longitud;
  double? latitud;
  UserListPresenterLocation({this.userPreferences}) {
    getCurrentLocation();
  }

  void getNearUsers() async {

    try {
      List<UserModelUpdate>? users = [];
      if (userPreferences != null){
        getCurrentLocation();
        users = await userRepository.getDocumentsWithinRadius(latitud!,longitud!);
        if (users != null) {
          usersList = users;
          _backView.refreshUserListView(usersList!);
        }
      }

    } catch (error) {
      rethrow;
    }
  }

  set backView(UserListView value) {
    _backView = value;
    _backView.refreshUserListView(usersList!);
  }

  void setUserPreferences(UserPreferencesDTO? preferences) {
    userPreferences = preferences;
    getNearUsers();
  }
  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission= await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission= await Geolocator.checkPermission();
      if(permission == LocationPermission.denied) {
        print("a");
      }
    }
    return await Geolocator.getCurrentPosition();
  }
  void getCurrentLocation() async {
    Position position = await determinePosition();
    longitud= position.longitude;
    latitud= position.latitude;
  }
}