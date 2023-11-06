import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user_model.g.dart';


@Entity()
@JsonSerializable()
class UserModel {

  @Id(assignable: true)
  @JsonKey(includeFromJson: false, includeToJson: false)
  int id_int = 0;

  String image;
  String email;

  //@Transient()
  String password='';
  String full_name;

  @Index()
  @Unique(onConflict: ConflictStrategy.replace)
  String id;
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
  double stars;
  String city;
  String locality;

  // Image
  UserModel({
    required this.id,
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

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}