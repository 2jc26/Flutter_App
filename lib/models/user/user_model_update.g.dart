// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelUpdate _$UserModelUpdateFromJson(Map<String, dynamic> json) =>
    UserModelUpdate(
      locality: json['locality'] as String,
      city: json['city'] as String,
      image: json['image'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      id: json['id'] as String,
      age: json['age'] as int,
      bring_people: json['bring_people'] as String,
      sleep: json['sleep'] as int,
      phone: json['phone'] as int,
      vape: json['vape'] as bool,
      personality: json['personality'] as String,
      likes_pets: json['likes_pets'] as bool,
      clean: json['clean'] as String,
      smoke: json['smoke'] as bool,
      gender: json['gender'] as String,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
      stars: json['stars'] as int,
    );

Map<String, dynamic> _$UserModelUpdateToJson(UserModelUpdate instance) =>
    <String, dynamic>{
      'image': instance.image,
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'id': instance.id,
      'age': instance.age,
      'bring_people': instance.bring_people,
      'sleep': instance.sleep,
      'phone': instance.phone,
      'vape': instance.vape,
      'personality': instance.personality,
      'likes_pets': instance.likes_pets,
      'clean': instance.clean,
      'smoke': instance.smoke,
      'gender': instance.gender,
      'lat': instance.lat,
      'long': instance.long,
      'stars': instance.stars,
      'city': instance.city,
      'locality': instance.locality,
    };
