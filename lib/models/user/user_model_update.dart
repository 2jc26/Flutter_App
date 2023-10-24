import 'package:json_annotation/json_annotation.dart';

part 'user_model_update.g.dart';

@JsonSerializable()
class UserModelUpdate {
  String image;
  String username;
  String password;
  String name;
  String id;
  int age;
  String bring_people;
  int sleep;
  int phone;
  //String role;
  bool vape;
  String personality;
  bool likes_pets;
  String clean;
  //String week;
  bool smoke;
  String gender;
  double lat;
  double long;
  int stars;
  String city;
  String locality;

  // Image
  UserModelUpdate({
    required this.locality,
    required this.city,
    required this.image,
    required this.username,
    required this.password,
    required this.name,
    required this.id,
    required this.age,
    required this.bring_people,
    required this.sleep,
    required this.phone,
    //required this.role,
    required this.vape,
    required this.personality,
    required this.likes_pets,
    required this.clean,
    //required this.week,
    required this.smoke,
    required this.gender,
    required this.lat,
    required this.long,
    required this.stars
  });

  factory UserModelUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserModelUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelUpdateToJson(this);
}