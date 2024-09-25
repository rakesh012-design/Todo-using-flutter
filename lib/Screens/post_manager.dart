import 'package:backend_learning/Screens/add_post.dart';
import 'package:backend_learning/Screens/posts_screen.dart';
import 'package:flutter/cupertino.dart%20%20';
import 'package:flutter/material.dart';

class PostManager extends StatefulWidget {
  const PostManager({super.key});

  @override
  State<PostManager> createState() => _PostManagerState();
}

class _PostManagerState extends State<PostManager> {
  List<Widget> pages=[
    const PostsScreen(),
    const AddPost(),
  ];
  int _page=0;
  void updatePage(int page){
    setState(() {
     _page=page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            decoration: BoxDecoration(
              border: Border(top: BorderSide(
                color: _page==0 ? Colors.black : Colors.white,
                width: 5
              ))
            ),
            child:  Icon(Icons.home_outlined,
              color: _page==0 ? Colors.black : Colors.white,

            ),
          ),
            label: 'Home'
          ),
          BottomNavigationBarItem(icon: Container(
            width: 30,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(
                    color: _page==1 ? Colors.black : Colors.white,
                    width: 5
                ))
            ),
            child:  Icon(Icons.add,
              color: _page==1 ? Colors.black : Colors.white,


            ),
          ),
              label: 'Add post'
          )
        ],

      ),
      body: pages[_page],
    );
  }
}
