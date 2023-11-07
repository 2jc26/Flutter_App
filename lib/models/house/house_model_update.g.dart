// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_model_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseModelUpdate _$HouseModelUpdateFromJson(Map<String, dynamic> json) =>
    HouseModelUpdate(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      neighborhood: json['neighborhood'] as String,
      address: json['address'] as String,
      housingType: json['housingType'] as String,
      rentPrice: (json['rentPrice'] as num).toDouble(),
      stratum: json['stratum'] as int,
      area: (json['area'] as num).toDouble(),
      apartmentFloor: json['apartmentFloor'] as int,
      roomsNumber: json['roomsNumber'] as int,
      roomArea: (json['roomArea'] as num).toDouble(),
      bathroomsNumber: json['bathroomsNumber'] as int,
      laundryArea: json['laundryArea'] as bool,
      internet: json['internet'] as bool,
      tv: json['tv'] as bool,
      furnished: json['furnished'] as bool,
      elevator: json['elevator'] as bool,
      gymnasium: json['gymnasium'] as bool,
      reception: json['reception'] as bool,
      supermarkets: json['supermarkets'] as bool,
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HouseModelUpdateToJson(HouseModelUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'address': instance.address,
      'housingType': instance.housingType,
      'rentPrice': instance.rentPrice,
      'stratum': instance.stratum,
      'area': instance.area,
      'apartmentFloor': instance.apartmentFloor,
      'roomsNumber': instance.roomsNumber,
      'roomArea': instance.roomArea,
      'bathroomsNumber': instance.bathroomsNumber,
      'laundryArea': instance.laundryArea,
      'internet': instance.internet,
      'tv': instance.tv,
      'furnished': instance.furnished,
      'elevator': instance.elevator,
      'gymnasium': instance.gymnasium,
      'reception': instance.reception,
      'supermarkets': instance.supermarkets,
      'description': instance.description,
      'rating': instance.rating,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'images': instance.images,
    };
