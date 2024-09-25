import 'package:backend_learning/Custom%20Widgets/add_activity.dart';
import 'package:backend_learning/Screens/daily_activites.dart';
import 'package:backend_learning/Screens/profile.dart';
import 'package:backend_learning/Screens/unknown.dart';
import 'package:backend_learning/backend/authentication/Authorization/backend_signup.dart';
import 'package:backend_learning/backend/authentication/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart  ';


class Home extends StatefulWidget {

  static const String routeName='/home';
  const Home({super.key,});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BackEndSignup backEndSignup=BackEndSignup();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    backEndSignup.getUserData(context);
  }
void updatePage(int page){
  setState(() {
    _page=page;

  });
}
List<Widget> pages=[
   const DailyActivities(),

  const AddActivity(),
  const Profile(),



];
int _page=0;
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context).user;


    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(itemBuilder: (context)=>[
            PopupMenuItem(child: GestureDetector(
              onTap:(){
                backEndSignup.logout(context);
              },child: const Text('logout'),))
          ])
        ],



        title: Row(
          children: [
            Text(user.name,style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(width: 100,),

          ],
        ),
      backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: CupertinoColors.activeBlue,
        iconSize: 28,
        mouseCursor: SystemMouseCursors.contextMenu,


        items: [
          BottomNavigationBarItem(icon: Container(
            width: 30,
            decoration:  BoxDecoration(
              border:Border(top: BorderSide(
                color: _page==0 ? Colors.black : Colors.white,
                width: 5
              ))
            ),
            child:  Icon(Icons.star_border_outlined,
            color: _page==0? Colors.black : Colors.white,
            ),
          ),
            label: 'Daily Activities'
          ),
          BottomNavigationBarItem(icon: Container(
            width: 30,
            decoration:  BoxDecoration(
                border:Border(top: BorderSide(
                  color: _page==1 ? Colors.black :Colors.white,
                    width: 5
                ))
            ),
            child:  Icon(Icons.person_outline,
              color: _page==1 ? Colors.black :Colors.white,

            ),
          ),
            label: 'Add Activity'
          ),
          BottomNavigationBarItem(icon: Container(
            width: 30,
            decoration:  BoxDecoration(
                border:Border(top: BorderSide(
                    color: _page==2 ? Colors.black :Colors.white,
                    width: 5
                ))
            ),
            child:  Icon(Icons.view_week_outlined,
              color: _page==2 ? Colors.black :Colors.white,

            ),
          ),
              label: 'Profile'
          ),




        ],

      ),
      body: pages[_page]
    );
  }
}
