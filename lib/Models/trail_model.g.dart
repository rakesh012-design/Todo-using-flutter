// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrailModel _$TrailModelFromJson(Map<String, dynamic> json) => TrailModel(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
      userType: json['userType'] as String,
      photoUrl: json['photoUrl'] as String,
      activities: json['activities'] as List<dynamic>,
    );

Map<String, dynamic> _$TrailModelToJson(TrailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'name': instance.name,
      'token': instance.token,
      'userType': instance.userType,
      'photoUrl': instance.photoUrl,
      'activities': instance.activities,
    };
