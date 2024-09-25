import 'package:flutter/cupertino.dart';
import 'package:backend_learning/Models/user.dart';

class UserProvider extends ChangeNotifier{

  User _user=User(
      id: '',
      email: '',
      password: '',
      name: '',
      token: '',
      userType: '',
      photoUrl: ''
    //activities: []
  );



  User get user=>_user;

  void setUser(String user){
    _user=User.fromJson(user);
    notifyListeners();
  }
  /*void setUser(Map<String,dynamic> user){
    _user=User.fromJson(user);
    notifyListeners();
  }*/

}