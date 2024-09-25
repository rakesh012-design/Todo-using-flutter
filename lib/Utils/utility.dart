
import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


// to run using web
// flutter run -d chrome --web-browser-flag "--disable-web-security"
String url="http://10.0.2.2:3000";
//String url="http://0.0.0.0:3000";
//String url="http://localhost:3000";
//String url="http://192.168.0.102:3000";
String login=url+'/login';
String signup=url+'/signup';
String addActivity=url+'/add-activity';


void showSnackBar(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>>pickImage()async{
   List<File> images=[];
  try{

    var files=await FilePicker.platform.pickFiles(
      type: FileType.image,

    );
    print('in try block');
    if(files!=null && files.files.isNotEmpty){
      for(int i=0;i<files.files.length;i++){
        images.add(File(files.files[i].path!));
      }

    }

  }catch(e){
    print('in catch block');
    print(e);
  }
  return images;
}
