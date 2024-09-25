

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';



part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel{

  final String id;
  //final String userId;
  final String activity;
  final String startTime;
  final String endTime;


  ActivityModel({
    required this.id,
    //required this.userId,
    required this.activity,
    required this.startTime,
    required this.endTime,
});
  factory ActivityModel.fromJson(Map<String,dynamic> map)=> _$ActivityModelFromJson(map);


  Map<String,dynamic> toJson() => _$ActivityModelToJson(this);

}