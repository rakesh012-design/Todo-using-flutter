import 'package:backend_learning/Custom%20Widgets/input_box.dart';
import 'package:backend_learning/Models/activity_model.dart';
import 'package:backend_learning/Screens/admin_screen.dart';
import 'package:backend_learning/Screens/forgot_password.dart';
import 'package:backend_learning/Screens/home.dart';
import 'package:backend_learning/Screens/login_screen.dart';
import 'package:backend_learning/Screens/posts_screen.dart';
import 'package:backend_learning/Screens/reset_password.dart';
import 'package:backend_learning/Screens/signup.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:backend_learning/backend/authentication/provider/activity_provider.dart';
import 'package:backend_learning/backend/authentication/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {


  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>UserProvider())
  ],child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BackEndSignup backEndSignup=BackEndSignup();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    backEndSignup.getUserData(context);

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {





    final user=Provider.of<UserProvider>(context).user;
    

    final TextEditingController textEditingController=TextEditingController();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light ,

       // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),

      ),

      home:Provider.of<UserProvider>(context).user.token.isNotEmpty && user.userType=='user'? const Home()
          : Provider.of<UserProvider>(context).user.token.isNotEmpty && user.userType=='admin' ? const AdminScreen()
          :const Login(),
      routes: {
        'login':(context)=>const Login(),
        'reset_password':(context)=>const ResetPassword(),
        'forgot_password':(context)=>const ForgotPassword(),
        'posts_screen':(context)=>const PostsScreen(),

      },

      //Home()
    );
  }
}

