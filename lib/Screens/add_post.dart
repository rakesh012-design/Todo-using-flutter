import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:backend_learning/Custom%20Widgets/custom_button.dart';
import 'package:backend_learning/backend/authentication/provider/user_provider.dart';
import 'package:http/http.dart' as http;

import 'package:backend_learning/Custom%20Widgets/input_box.dart';
import 'package:backend_learning/Utils/utility.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import  'package:dart_jwt_token/dart_jwt_token.dart' as jwt;

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _caption=TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _caption;

    }

    
    final cloudinary=CloudinaryPublic('dqnl6rmrn', 'lg8iw5cf');
    String id='';
    String photoURL='';

    List<File> images=[];
    Future <String> addImage() async{
      print('add Image clicked');
      var res=await pickImage();
      images=res;


      CloudinaryResponse cloudinaryResponse=await cloudinary.uploadFile(CloudinaryFile.fromFile(images[0].path));
      print(cloudinaryResponse.secureUrl);
      print('this is cloud');
      photoURL=cloudinaryResponse.secureUrl;
      print(photoURL);

      return photoURL;

    }

    void addPost(
        String userId,
        String photoURLPost,
        String captionPost,
        )async{


      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      var token=sharedPreferences.getString('x-auth-token');
      var decoded=jwt.JWT.verify(token!,jwt.SecretKey('some-kind-of-secret-key-of-json-web-token'));
      print('this is from profile');
       id=decoded.payload['id'];
      print(id);
      http.Response httpResponse=await http.post(Uri.parse('$url/add-post'),
        body: jsonEncode({
          'userId':userId,
          'photoURL':photoURL,
          'caption':captionPost
        }),
        headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
        }
      );
      print('this is from add post');
      print(httpResponse.body);
    }
    final user=Provider.of<UserProvider>(context).user;
    print('this is from provider');
    print(user.id);


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Container(
              color: Colors.grey,
              width: double.infinity,
              child: GestureDetector(onTap: (){
                addImage();
              },child: photoURL.isEmpty ? Icon(Icons.photo_album,size: 100,)
                  :Image.network(photoURL)
              )
              ,
            ),
            const SizedBox(height: 30,),
            CustomBox(controller: _caption, hintText: 'enter the caption', textInputType: TextInputType.text),
            const SizedBox(height: 30,),
            CustomButton(text: 'Add post', onTap: (){
              addPost(user.id, photoURL, _caption.text);
            })
          ],
        ),
      ),
    );
  }
}
