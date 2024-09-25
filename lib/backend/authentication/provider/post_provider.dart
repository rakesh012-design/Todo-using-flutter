


import 'package:backend_learning/Models/posts.dart';
import 'package:flutter/cupertino.dart%20%20';

class PostProvider extends ChangeNotifier{
  Post _post=Post(userId: '', photoURL: '', caption: '');

  Post get post=>_post;


  void setPost(String post){
    _post=Post.fromJson(post);
    notifyListeners();
  }
}