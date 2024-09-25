
import 'dart:convert';

import 'package:flutter/cupertino.dart%20%20';
import 'package:shared_preferences/shared_preferences.dart';
import  'package:dart_jwt_token/dart_jwt_token.dart' as jwt;
import 'package:http/http.dart' as http;

import '../../../Utils/utility.dart';

class PostsBackend{
  
  void showPosts(BuildContext context)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var token=sharedPreferences.get('x-auth-token') as String;
    var decoded=jwt.JWT.verify(token,jwt.SecretKey('some-kind-of-secret-key-of-json-web-token'));
    print('this is from show posts');
    var info=decoded.payload;
    var id=decoded.payload['id'];
    print(id);
    http.Response response= await http.get(Uri.parse('$url/find-posts/$id'),
      headers: <String,String>{

      'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(jsonDecode(response.body));



  }
}