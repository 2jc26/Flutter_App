// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      houseId: json['houseId'] as String,
      comment: json['comment'] as String,
      rating: json['rating'] as int,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'houseId': instance.houseId,
      'comment': instance.comment,
      'rating': instance.rating,
    };
