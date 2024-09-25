

import 'package:backend_learning/Models/activity_model.dart';
import 'package:flutter/cupertino.dart%20%20';

class ActivityProvider extends ChangeNotifier{
  ActivityModel _activityModel=ActivityModel
    (id: '', activity: '', startTime: '', endTime: '');

  ActivityModel get activity=>_activityModel;

  void smt(){
    ChangeNotifier();
  }

  void setActivity(Map<String,dynamic> activity){
    _activityModel=ActivityModel.fromJson(activity);
    ChangeNotifier();
  }

}