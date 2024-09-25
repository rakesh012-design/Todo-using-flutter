import 'dart:convert';

import 'package:backend_learning/Custom%20Widgets/custom_button.dart';
import 'package:backend_learning/Custom%20Widgets/input_box.dart';
import 'package:backend_learning/Models/user.dart';
import 'package:backend_learning/Screens/post_manager.dart';
import 'package:backend_learning/Screens/reset_password.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:backend_learning/backend/authentication/Errorhandling/error_handling.dart';
import 'package:backend_learning/backend/authentication/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import  'package:dart_jwt_token/dart_jwt_token.dart' as jwt;

import '../Utils/utility.dart';


class Profile extends StatefulWidget {
  static const String routeName='/profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final cloudinary=CloudinaryPublic('dqnl6rmrn', 'lg8iw5cf');
  List<File> images=[];
  String imageURL='';
  String id='';


  void selectImages()async{
    var res= await pickImage();
    setState(() {
      images=res;
    });
    CloudinaryResponse response=await cloudinary.uploadFile(CloudinaryFile.fromFile(images[0].path));
    imageURL=response.secureUrl;
    print('this is response of cloudinary');
    print('image URL');
    print(imageURL);

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var token=sharedPreferences.getString('x-auth-token');
    var decoded=jwt.JWT.verify(token!,jwt.SecretKey('some-kind-of-secret-key-of-json-web-token'));
    print('this is from profile');
    var id=decoded.payload['id'];
    print(id);
    http.Response httpResponse=await http.post(Uri.parse('$url/upload-image/$id'),
        body: jsonEncode({
          'userId':id,
          'photoURL':imageURL
        }),
        headers: <String,String>{

      'Content-Type':'application/json; charset=UTF-8'
    }
    );
    print(jsonDecode(httpResponse.body));


  }
  void check(/*String id,String photoURL*/)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var token=sharedPreferences.getString('x-auth-token');
    print('this is token from check');
    print(token);
    var decoded=jwt.JWT.verify(token!, jwt.SecretKey('some-kind-of-secret-key-of-json-web-token'));
    print('this is decode');
    print(decoded.payload);


  }





  void updateUser() async{
    try {
      SharedPreferences preferences=await SharedPreferences.getInstance();
      var share=preferences.get('x-auth-token');
      var token=share.toString();
      var decoded=jwt.JWT.verify(token, jwt.SecretKey('some-kind-of-secret-key-of-json-web-token'));



      String userId=decoded.payload['id'];




      http.Response res = await http.patch(
          Uri.parse('$url/update-user/$userId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization':'token ${token}'
          },
          body: jsonEncode({
            'setName': _newName.text,
          })
      );


      httpErrorHandle(response: res, context: context, onSuccess: () {
        showSnackBar(context, 'name changed restart app to check');

      });
    }catch(e){

      showSnackBar(context, e.toString());
    }
  }


  final TextEditingController _newName=TextEditingController();
  BackEndSignup backEndSignup=BackEndSignup();

  @override
  Widget build(BuildContext context) {
    check();

    final user=Provider.of<UserProvider>(context).user;
    print('this is user photo');
    print(user.photoUrl);

    return Scaffold(
      body: Column(
        children: [
            Container(
            child:
            Text('Name: ${user.name}',style: const TextStyle(color: Colors.black,fontSize: 40),),

          ),
          const SizedBox(height: 30,),
          /*CircleAvatar(

            radius: 60,

            child: GestureDetector(
              onTap: (){
                selectImages();
                
              },

              child: user.photoUrl.isEmpty?Icon(
                size: 100,
                  Icons.person):Image.network('${user.photoUrl}',height: 100,width: 100,),
              ),
            ),*/
          GestureDetector(
            onTap: selectImages,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: user.photoUrl.isEmpty?Icon(
                    size: 100,
                    Icons.person):Image.network('${user.photoUrl}',height: 100,width: 100,fit: BoxFit.cover,),
              ),
              radius: 60,
              /*child:  user.photoUrl.isEmpty?Icon(
                  size: 100,
                  Icons.person):Image.network('${user.photoUrl}',height: 100,width: 100,fit: BoxFit.fill,),*/
            ),
          ),

          const SizedBox(height: 50,),

          CustomBox(controller: _newName, hintText: 'Enter the new name', textInputType: TextInputType.text),
          const SizedBox(height: 20,),

          CustomButton(text: 'Change user name', onTap: (){
            updateUser();

          }),
          const SizedBox(height: 30,),




          const SizedBox(height: 20,),
          Text('Name: ${user.name}',style: const TextStyle(color: Colors.black,fontSize: 40),),

          Text('Email: ${user.email}',style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 30,),
          CustomButton(text: 'Posts', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostManager()));
          })









        ],
      ),
    );
  }
}
