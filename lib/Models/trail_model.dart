


import 'package:json_annotation/json_annotation.dart';

part 'trail_model.g.dart';

@JsonSerializable()
class TrailModel {
  final String id;
  final String email;
  final String password;
  final String confirmPassword;

  final String name;
  final String token;
  final String userType;
  final String photoUrl;
  late List<dynamic> activities;

  TrailModel({
    required this.id,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.token, required this.userType,
    required this.photoUrl,
    required this.activities
  });
  factory TrailModel.fromJson(Map<String,dynamic> map)=> _$TrailModelFromJson(map);


  Map<String,dynamic> toJson()=>_$TrailModelToJson(this);


}

//

