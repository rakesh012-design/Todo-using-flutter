import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

class Post{
  final String userId;
  final String photoURL;
  final String caption;

  Post({
    required this.userId,
    required this.photoURL,
    required this.caption,
  });

  Map<String,dynamic>toMap() {
    return {
      userId: 'userId', photoURL: 'photoURL', caption: 'caption'
    };
  }
  factory Post.fromMap(Map<String,dynamic> data){
    return Post(
        userId: data['userId'] ?? '' ,
        photoURL: data['photoURL'] ?? '',
        caption: data['caption'] ?? ''
    );
  }
  String toJson() => json.encode(toMap());
  factory Post.fromJson(String source)=> Post.fromMap(json.decode(source));



}