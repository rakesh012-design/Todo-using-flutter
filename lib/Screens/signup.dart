import 'package:backend_learning/Custom%20Widgets/custom_button.dart';
import 'package:backend_learning/Custom%20Widgets/input_box.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:flutter/material.dart';


class Signup extends StatefulWidget {
  static const String routeName='/signup';
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _email=TextEditingController();
    final TextEditingController _name=TextEditingController();
    final TextEditingController _password=TextEditingController();
    final TextEditingController _confirmPassword=TextEditingController();
    BackEndSignup backEndSignup=BackEndSignup();
    void createUser(){
      backEndSignup.signupUser(
          context: context,
          email: _email.text,
          name: _name.text,
          password:_password.text,
          confirmPassword: _confirmPassword.text);

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),

        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 200,),
              CustomBox(controller: _email, hintText: 'enter your email', textInputType: TextInputType.emailAddress,),
              SizedBox(height: 20,),
              CustomBox(controller: _name, hintText: 'enter your name', textInputType: TextInputType.text,),
              SizedBox(height: 20,),
              CustomBox(controller: _password, hintText: 'password', textInputType: TextInputType.text,isPass: true,),
              SizedBox(height: 20,),
              CustomBox(controller: _confirmPassword, hintText: 'Confirm password', textInputType: TextInputType.text,isPass: true,),
              SizedBox(height: 30,),
              CustomButton(text: 'Signup', onTap: (){
                createUser();
              }),

              const SizedBox(height: 50,),


            ],
          ),
        ),
      ),
    );
  }
}
