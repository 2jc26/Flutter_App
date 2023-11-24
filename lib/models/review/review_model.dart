import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'review_model.g.dart';

// @Entity()
@JsonSerializable()
class ReviewModel {

  // @Id(assignable: true)
  // @JsonKey(includeFromJson: false, includeToJson: false)
  // int id_int =0;

  // @Index()
  // @Unique(onConflict: ConflictStrategy.replace)
  String id;

  String userId;

  String houseId;

  String comment;

  double rating;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.houseId,
    required this.comment,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

}