// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String? ?? '',
      name: json['name'] as String,
      token: json['token'] as String,
      userType: json['userType'] as String? ?? 'user',
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'name': instance.name,
      'token': instance.token,
      'userType': instance.userType,
      'photoUrl': instance.photoUrl,
    };
