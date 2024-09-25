import 'package:backend_learning/Custom%20Widgets/custom_button.dart';
import 'package:backend_learning/Custom%20Widgets/input_box.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {

  static const String routeName='/resetPassword';
  const ResetPassword({super.key,});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _token;
    _password;
  }
  BackEndSignup backEndSignup=BackEndSignup();
  TextEditingController _token=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _confirmPassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200,),
            CustomBox(controller: _token, hintText: 'paste your token', textInputType: TextInputType.text),
            const SizedBox(height: 30,),
            CustomBox(controller: _password, hintText: 'enter the password', textInputType: TextInputType.text,isPass: true,),
            const SizedBox(height: 30,),
            CustomBox(controller: _confirmPassword, hintText: 'confirm the password', textInputType: TextInputType.text,isPass: true,),
            CustomButton(text: 'reset password', onTap: (){
              backEndSignup.resetPassword(
                  context, _token.text, _password.text, _confirmPassword.text);

              setState(() {


              });

            })


          ],

        ),
      )
    );
  }
}
