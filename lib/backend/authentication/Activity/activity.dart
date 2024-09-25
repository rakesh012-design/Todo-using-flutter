

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart' as jwt;

import 'package:backend_learning/Models/activity_model.dart';
import 'package:backend_learning/Utils/utility.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:backend_learning/backend/authentication/Errorhandling/error_handling.dart';
import 'package:backend_learning/backend/authentication/provider/user_provider.dart';
import 'package:dart_jwt_token/dart_jwt_token.dart';
import 'package:flutter/cupertino.dart%20%20';
import 'package:http/http.dart'as http;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackendActivity{
  BackEndSignup backEndSignup=BackEndSignup();



  void addActivity({
    required BuildContext context,
    required String activity,
    required String startTime,
    required String endTime,
    required String userId,
  })async{
    try{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      var smt=preferences.get('x-auth-token');



      String tokenCpy=smt.toString();
      print('this is token cpy: ${tokenCpy}');
      ActivityModel activityModel= ActivityModel(id: 'id',activity: activity, startTime: startTime, endTime: endTime);
      http.Response res=await http.post(Uri.parse('$url/add-activity'),
        body: jsonEncode({
          'activity':activity,
          'startTime':startTime,
          'endTime':endTime,
          'userId':userId,
        }),
          headers: <String,String>{
        'Content-type':'application/json; charset=UTF-8',
          'authorization':'token ${tokenCpy}'
        }
        );
      var decoded=jwt.JWT.verify(tokenCpy, jwt.SecretKey("some-kind-of-secret-key-of-json-web-token"));
      print('this is decoded');
      print(decoded.payload['id']);





      print('res.headers in add activity');
      print(res.headers);
      httpErrorHandle(response: res, context: context, onSuccess: (){


        showSnackBar(context, 'Activity Added');
      });

    }catch(e){
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

}






