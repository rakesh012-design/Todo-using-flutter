import 'dart:convert';

import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart%20%20';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:info_popup/info_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

import '../Utils/utility.dart';
import '../backend/authentication/Errorhandling/error_handling.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});


  @override
  State<AdminScreen> createState() => _AdminScreenState();
}




class _AdminScreenState extends State<AdminScreen> {
  String actId='';
  List<dynamic> userActs=[];

  String deleteActId='';
  List<dynamic> allUsers=[];
  Future<List<dynamic>> getAllUsers() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String token=preferences.get('x-auth-token') as String;
    http.Response response=await http.get(Uri.parse('$url/find-all-users'),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token':token,
      },
    );

    var users=jsonDecode(response.body)['users'];

    setState(() {
      allUsers=users;
    });


    return users;

  }
  Future<Position> getLocation() async{
    LocationPermission locationPermission=await Geolocator.requestPermission();
    print('working');
    Position position=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.reduced,timeLimit: Duration(seconds: 60)
    );


    print('this is position');
    print(position.toString());
    return position;

  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission=await Geolocator.requestPermission();


    // Test if location services are enabled.
    print('checking service');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print(serviceEnabled);
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    print('this is position');
    Position position=await Geolocator.getCurrentPosition();
    print(position);
    return position;
  }
  void getWeatherData() async{
    String lat='37.42';
    String lon='-122.08';
    String api='0691b8e0cf62006093abe2c33cfee6df';
   http.Response response=await  http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat={$lat}&lon={$lon}&appid=0691b8e0cf62006093abe2c33cfee6df'));
   //http.Response response=await  http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=b50bb6dfbdd3177997d5c725059ba815'));
   print(response.body.toString());
  }
  void deleteUser() async{
    try {
      http.Response res = await http.delete(
          Uri.parse('$url/delete-user/$deleteActId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(response: res, context: context, onSuccess: () {
        showSnackBar(context, 'User deleted check database or refresh the app to confirm');
      });
    }catch(e){
      showSnackBar(context, e.toString());
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();

  }

  @override
  Widget build(BuildContext context) {
    BackEndSignup backEndSignup=BackEndSignup();

    return  Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(child: GestureDetector(onTap: (){
              backEndSignup.logout(context);

            },child: const Text('logout')))
          ])
        ],
        title: const Text('Admin panel'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(itemCount:allUsers.length,itemBuilder: (context,index){
        return Padding(

          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(onTap:(){
                      Future<List<dynamic>> showData() async {
                        try {
                          http.Response res = await http.get(
                            Uri.parse('$url/find-activities/${allUsers[index]['_id']}'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                          );
                          int actLength=jsonDecode(res.body)['data']['activities'].length-1;
                          AlertDialog alert=AlertDialog(
                            content:Text('${jsonDecode(res.body)['data']['activities']}'),
                            title: const Text('User Name'),
                          );
                          showDialog(context: context, builder: (context){
                            return alert;
                          });

                         setState(() {

                            userActs = jsonDecode(res.body)['data']['activities'];
                          });
                         
                        }catch(e){

                          showSnackBar(context, e.toString());
                        }
                        return userActs;
                      }
                      showData();



                      //print(userActs);
                    },
                      child: const Icon(Icons.arrow_upward_rounded),),
                    const SizedBox(width: 50,),

                    Text('Name: ${allUsers[index]['name']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    const SizedBox(width: 100,),
                    GestureDetector(onTap: (){
                      setState(() {
                        deleteActId=allUsers[index]['_id'] ;
                        deleteUser();
                      });

                      },child: const Icon(Icons.delete)),
                  ],
                ),
                Text('Email: ${allUsers[index]['email']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text('Type: ${allUsers[index]['userType']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text('ID: ${allUsers[index]['_id']}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                const SizedBox(height: 30,),
                ElevatedButton(
                    onPressed: (){
                     getWeatherData();
                    },
                    child: Text('get location'))

              ],
            ),
          ),
        );
      })
    );
  }
}
