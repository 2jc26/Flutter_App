import 'package:json_annotation/json_annotation.dart';

part 'user_model_update.g.dart';

@JsonSerializable()
class UserModelUpdate {
  String image;
  String email;
  String password;
  String full_name;
  String? id;
  int age;
  String bring_people;
  int sleep;
  int phone;
  String rol;
  bool vape;
  String personality;
  bool likes_pets;
  String clean;
  //String week;
  bool smoke;
  String gender;
  double latitude;
  double longitude;
  int stars;
  String city;
  String locality;

  // Image
  UserModelUpdate({
    this.id,
    required this.age,
    required this.image,
    required this.email,
    required this.password,
    required this.full_name,
    required this.bring_people,
    required this.sleep,
    required this.phone,
    required this.rol,
    required this.vape,
    required this.personality,
    required this.likes_pets,
    required this.clean,
    required this.smoke,
    required this.gender,
    required this.latitude,
    required this.longitude,
    required this.stars,
    required this.city,
    required this.locality,

  });

  factory UserModelUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserModelUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelUpdateToJson(this);
}