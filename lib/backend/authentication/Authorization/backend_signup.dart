



import 'dart:convert';


import 'package:backend_learning/Custom%20Widgets/add_activity.dart';
import 'package:backend_learning/Models/user.dart';
import 'package:backend_learning/Screens/home.dart';
import 'package:backend_learning/Screens/login_screen.dart';
import 'package:backend_learning/Screens/reset_password.dart';
import 'package:backend_learning/Screens/unknown.dart';
import 'package:backend_learning/Utils/utility.dart';
import 'package:backend_learning/backend/authentication/Errorhandling/error_handling.dart';
import 'package:backend_learning/backend/authentication/provider/user_provider.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import  'package:dart_jwt_token/dart_jwt_token.dart' as jwt;

import '../../../Models/activity_model.dart';
import '../provider/activity_provider.dart';

class BackEndSignup{


  void signupUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
    required String confirmPassword,

})
async{
    try{
      User user=User(
          token: '',
          id: 'id',
          email: email,
          password: password,
          name: name,
          confirmPassword: confirmPassword,
          photoUrl: ''
          //activities: []
          );
      http.Response res=await http.post(Uri.parse('$url/signup'),
      body: user.toJson(),
      headers:<String,String>{
        'Content-Type':'application/json; charset=UTF-8'

      }
      );
      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, 'Account created');
      });


    }catch(e){
      showSnackBar(context, e.toString());
    }

}
void loginUser({
    required BuildContext context,
    required String email,
    required String password,
})async{
    try{

      //token trails

      http.Response res=await http.post(Uri.parse('$url/api/login'),
        body: jsonEncode({
          'email':email,
          'password':password
        }),
        headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8'
      }

      );



      httpErrorHandle(response:res, context: context, onSuccess: () async{




        SharedPreferences prefs=await SharedPreferences.getInstance();


        Provider.of<UserProvider>(context,listen: false).setUser(res.body);
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        print('res.body from login success');
        print(res.headers);
        print(res.body);

        showSnackBar(context, 'logging in ');
        Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);

      });


    }catch(e){
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
  void getUserData( BuildContext context)

  async{
    try{

      SharedPreferences preferences=await SharedPreferences.getInstance();
      String? token=preferences.getString('x-auth-token');
      if(token==null) {
        preferences.setString('x-auth-token', '');
      }

      var tokenRes=await http.post(
        Uri.parse('$url/verify-token'),
          headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8',
           'x-auth-token': token!
          },
      );
      print('this is token res.body from get user data');
      print(tokenRes.body);

      var response=jsonDecode(tokenRes.body)['status'];

      if(response=='success') {
        http.Response userRes = await http.get(
          Uri.parse('$url/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
        print('this is userRes body');
        print(userRes.body);
      }
    }catch(e){
      showSnackBar(context, e.toString());
    }

}
void checkActivity(BuildContext context){
  ActivityModel activityModel=ActivityModel(id: 'afaf', activity: 'afaf', startTime: 'afaf', endTime: 'afafa');
  final activity_rp=Provider.of<ActivityProvider>(context,listen: false).activity;


}
void logout(BuildContext context) async{
    try{
      SharedPreferences preferences=await SharedPreferences.getInstance();
      await preferences.setString('x-auth-token', '');
      



      Navigator.pushNamed(context, 'login',);

      showSnackBar(context, 'logged out');


    }catch(e){
      showSnackBar(context, e.toString());
    }
    
  }
  void forgotPassword( BuildContext context,String email)async{
    try{
      print('clicked on forgot password');
      /*SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      var tokenFP=sharedPreferences.getString('x-auth-token');
      var decoded=jwt.JWT.verify(tokenFP!, jwt.SecretKey("some-kind-of-secret-key-of-json-web-token"));*/


      http.Response response=await http.post(Uri.parse('$url/forgot-password'),
        body: jsonEncode({
          'email':email,

        }),
        headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
        },
      );
      var body=jsonDecode(response.body);
      print(body);
      httpErrorHandle(response: response, context: context, onSuccess: (){
        showSnackBar(context, 'Successful');
      });
    }
        catch(e){
      print(e);
      showSnackBar(context, e.toString());
    }
  }
  void resetPassword(
      BuildContext context,
      String token,
      String password,
      String confirmPassword,
      ) async{
    try{
      http.Response response=await http.patch(Uri.parse('$url/reset-password/$token'),
        body: jsonEncode({
          'token':token,
          'password':password,
          'confirmPassword':confirmPassword,

        }),
        headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
        },

      );
      var body=jsonDecode(response.body);
      print('this is body');
      print(body);
      showSnackBar(context, 'password changed successfully');



    }catch(e){
      print('in catch block');
      print(e);
      showSnackBar(context, e.toString());
    }
  }



}