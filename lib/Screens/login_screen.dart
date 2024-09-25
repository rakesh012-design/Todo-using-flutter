import 'package:backend_learning/Screens/signup.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:flutter/cupertino.dart%20%20';
import 'package:flutter/material.dart';


import '../Custom Widgets/custom_button.dart';
import '../Custom Widgets/input_box.dart';

class Login extends StatefulWidget {
  static const String routeName='/login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    final TextEditingController _email=TextEditingController();
    final TextEditingController _password=TextEditingController();
    BackEndSignup backEndLogin=BackEndSignup();
    void loginUser(){
      backEndLogin.loginUser(
          context: context, email: _email.text, password: _password.text);

    }
    void routeToSignup(){

      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Signup()));

    }
    return Scaffold(
      body:Column(
        children: [
          Column(
            children: [
              SizedBox(height: 200,),
              CustomBox(controller: _email, hintText: 'enter your email', textInputType: TextInputType.emailAddress,),
              SizedBox(height: 20,),
              CustomBox(controller: _password, hintText: 'enter your password', textInputType: TextInputType.text,isPass: true,),
              SizedBox(height: 30,),

              CustomButton(text: 'Login', onTap: (){

                loginUser();
              }),

              const SizedBox(height: 100,),
              /*GestureDetector(onTap: (){
                Navigator.pushNamed(context, Signup.routeName);
              },
                child: Container(
                  height: 50,
                  child: Text('click here to signup'),
                ),
              )*/
              CustomButton(text: 'Signup', onTap: (){
                routeToSignup();



              }),
              const SizedBox(height: 30,),

              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'forgot_password');
                },

                child:Container(
                  height: 50,
                  child:  const Text('forgot password click here!'),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
