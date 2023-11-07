// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      age: json['age'] as int,
      image: json['image'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      full_name: json['full_name'] as String,
      bring_people: json['bring_people'] as String,
      sleep: json['sleep'] as int,
      phone: json['phone'] as int,
      rol: json['rol'] as String,
      vape: json['vape'] as bool,
      personality: json['personality'] as String,
      likes_pets: json['likes_pets'] as bool,
      clean: json['clean'] as String,
      smoke: json['smoke'] as bool,
      gender: json['gender'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      stars: (json['stars'] as num).toDouble(),
      city: json['city'] as String,
      locality: json['locality'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'image': instance.image,
      'email': instance.email,
      'password': instance.password,
      'full_name': instance.full_name,
      'id': instance.id,
      'age': instance.age,
      'bring_people': instance.bring_people,
      'sleep': instance.sleep,
      'phone': instance.phone,
      'rol': instance.rol,
      'vape': instance.vape,
      'personality': instance.personality,
      'likes_pets': instance.likes_pets,
      'clean': instance.clean,
      'smoke': instance.smoke,
      'gender': instance.gender,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'stars': instance.stars,
      'city': instance.city,
      'locality': instance.locality,
    };
