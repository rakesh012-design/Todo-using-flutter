import 'package:backend_learning/Custom%20Widgets/custom_button.dart';
import 'package:backend_learning/Custom%20Widgets/input_box.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  BackEndSignup backEndSignup=BackEndSignup();
  @override
  Widget build(BuildContext context) {
    final TextEditingController _email=TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 180,),
          CustomBox(controller: _email, hintText: 'Enter your email', textInputType: TextInputType.emailAddress),
          const SizedBox(height: 30,),
          CustomButton(text: 'Next', onTap: (){
            backEndSignup.forgotPassword(context, _email.text);
            Navigator.pushNamed(context, 'reset_password');

          })
        ],
      ),
    );
  }
}
