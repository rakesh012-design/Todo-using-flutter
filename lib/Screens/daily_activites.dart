import 'dart:async';
import 'dart:convert';

import 'package:backend_learning/Custom%20Widgets/add_activity.dart';
import 'package:backend_learning/Models/activity_model.dart';
import 'package:backend_learning/Models/trail_model.dart';
import 'package:backend_learning/Screens/unknown.dart';
import 'package:backend_learning/backend/authentication/Activity/activity.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:backend_learning/backend/authentication/Authorization/posts_backend.dart';
import 'package:backend_learning/backend/authentication/Errorhandling/error_handling.dart';
import 'package:backend_learning/backend/authentication/provider/activity_provider.dart';
import 'package:backend_learning/backend/authentication/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart%20%20';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import  'package:dart_jwt_token/dart_jwt_token.dart' as jwt;
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/utility.dart';

class DailyActivities extends StatefulWidget {
  const DailyActivities({super.key});

  @override
  State<DailyActivities> createState() => _DailyActivitiesState();
}

class _DailyActivitiesState extends State<DailyActivities> {
  String id='';
  String deleteActId='';


  BackendActivity backendActivity=BackendActivity();
  BackEndSignup backEndSignup=BackEndSignup();
  int? num;
  int? activitiesLength;
  List<dynamic> activities=[];





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user=Provider.of<UserProvider>(context,listen: false).user;
    print(user.token);
    setState(() {
      id=user.id;
    });
    showData();
  }


  Future<List<dynamic>> showData() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    var smt=preferences.get('x-auth-token');
    String tokenCpy=smt.toString();
    http.Response res = await http.get(Uri.parse('$url/find-activities/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':'token ${tokenCpy}'
      },
    );


    var data=jsonDecode(res.body)['data']['activities'];
    List<dynamic> acts= await data.map((data)=>ActivityModel.fromJson(data)).toList();
    print('these are acts');
    print(acts[1].id);
    var decoded=jwt.JWT.verify(tokenCpy, jwt.SecretKey("some-kind-of-secret-key-of-json-web-token"));
    print('this is from jwt token');
    print(decoded.payload);


    setState(() {
      activities = jsonDecode(res.body)['data']['activities'];
      
    });
    print('these are trail model activiteis');

    return activities;
  }

   void delete() async{
     SharedPreferences preferences=await SharedPreferences.getInstance();
     var share=preferences.get('x-auth-token');
     var token=share.toString();
     var decoded=jwt.JWT.verify(token, jwt.SecretKey('some-kind-of-secret-key-of-json-web-token'));
    http.Response res=await http.delete(Uri.parse('$url/delete-activity/$deleteActId'),
      headers: <String,String>{
      'Content-Type':'application/json; charset=UTF-8',
        'authorization':'token ${token}'
      }
    );
    httpErrorHandle(response: res, context: context, onSuccess: (){

      showSnackBar(context, 'Activity deleted check database');
    });

  }

  @override
  Widget build(BuildContext context) {
    PostsBackend backend=PostsBackend();



    return Scaffold(
      
      body:  ListView.builder(itemCount: activities.length,itemBuilder: (context,index){


        return Slidable(
          startActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(onPressed: (BuildContext context){
               AlertDialog al= new AlertDialog(
                 title: Text('Testing'),
                 content: Text('testing this'),
               );
               al.build(context);



              },
                backgroundColor: Colors.black,
                foregroundColor: Colors.blue,
                icon: Icons.add,
                label: 'Add Activity',
              )
            ],
          ),

          endActionPane: ActionPane(
            motion:  ScrollMotion(),
            children: [
              SlidableAction(
                backgroundColor: Colors.black,
                foregroundColor: Colors.red,
                label: 'Delete Activity',
                icon: Icons.delete,
                onPressed: (BuildContext context){
                  print(activities[index]['_id']);
                  setState(() {
                    deleteActId=activities[index]['_id'];
                    delete();


                  });
                },
              )
            ],
          ),
          child: Card(
            child: ListTile(
              leading: Icon(Icons.task),
              title: Text('${activities[index]["activity"]}'),
              subtitle: Text('${activities[index]["startTime"]}'),
             // trailing: Icon(Icons.delete_outline,),
            ),

          ),
        );

        //return Text('${activities[index]}',style: TextStyle(color: Colors.black),);
      })
    );
  }
}
