import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';


part 'user.g.dart';
@JsonSerializable()
class User{
  final String id;
  final String email;
  final String password;
  final String confirmPassword;

  final String name;
  final String token;
  final String userType;
  final String photoUrl;

  //final List<dynamic> activities;








  User({
    required this.id,
    required this.email,
    required this.password,
    this.confirmPassword='',
    required this.name,
    required this.token,
    this.userType='user',
    required this.photoUrl,
    //required this.activities,





  });

  //factory User.fromJson(Map<String,dynamic> map)=> _$UserFromJson(map);

  //Map<String,dynamic> toMap()=> _$UserToJson(this);
  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'email':email,
      'name':name,
      'password':password,
      'confirmPassword':confirmPassword,
      'token':token,
      'userType':userType,
      'photoUrl':photoUrl
      //'activities':activities,


    };
  }
  

  //




  //
  factory User.fromMap(Map<String,dynamic> map){
    return User(
      id:map['_id'] ?? '',
      email: map['email'] ??'',
      name:map['name'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirmPassword'] ?? '',
      token: map['token'] ?? '',
      photoUrl: map['photoURL'] ?? '',
      userType:map['userType'] ?? '',
      //activities: List<Map<String,dynamic>>.from(map['activities']?.map((x)=>Map<String,dynamic>.from(x), ),)


    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source)=> User.fromMap(json.decode(source));



}