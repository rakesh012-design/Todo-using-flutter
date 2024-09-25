import 'package:backend_learning/Custom%20Widgets/custom_button.dart';
import 'package:backend_learning/Custom%20Widgets/input_box.dart';
import 'package:backend_learning/backend/authentication/Activity/activity.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:backend_learning/backend/authentication/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddActivity extends StatefulWidget {
  static const String routeName='/addActivity';
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  final TextEditingController _activity=TextEditingController();
  final TextEditingController _startTime=TextEditingController();
  final TextEditingController _endTime=TextEditingController();
  final TextEditingController _password=TextEditingController();
  BackendActivity backendActivity=BackendActivity();
  BackEndSignup backEndSignup=BackEndSignup();
  @override



  @override
  Widget build(BuildContext context) {

    final user=Provider.of<UserProvider>(context).user;
    void addActivity(){
      backendActivity.addActivity(context: context,
          activity: _activity.text,
          startTime: _startTime.text,
          endTime: _endTime.text,
         userId: user.id,



      );

    }

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100,),
          CustomBox(controller: _activity, hintText: 'Enter your activity', textInputType: TextInputType.text),
          const SizedBox(height: 30,),
          CustomBox(controller: _startTime, hintText: 'Start Time', textInputType: TextInputType.text),
          const SizedBox(height: 30,),
          CustomBox(controller: _endTime, hintText: 'end time', textInputType: TextInputType.text),
          const SizedBox(height: 30,),

          CustomButton(text: 'Add', onTap: (){
            addActivity();
          })
        ],
      ),
    );
  }
}
