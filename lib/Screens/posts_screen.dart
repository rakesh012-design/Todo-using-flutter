import 'dart:convert';

import 'package:backend_learning/Screens/comments_screen.dart';
import 'package:backend_learning/backend/authentication/Authorization/posts_backend.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart%20%20';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import  'package:dart_jwt_token/dart_jwt_token.dart' as jwt;
import 'package:http/http.dart' as http;

import '../Utils/utility.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

List<dynamic> posts=[];
String userName='';
String profilePic='';



class _PostsScreenState extends State<PostsScreen> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPosts();
    animationController=AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 300)
    );
    _opacityAnimation=Tween<double>(begin: 0,end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn)
    );

    _scaleAnimation=Tween<double>(begin: 80,end: 120).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn)
    );

  }
  void _animate(){
    animationController.reset();
    animationController.forward();
    
    Future.delayed(const Duration(milliseconds: 1000),(){
      animationController.reverse();
    });
  }

  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }




  Future<List<dynamic>> showPosts()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get('x-auth-token') as String;
    var decoded = jwt.JWT.verify(
        token, jwt.SecretKey('some-kind-of-secret-key-of-json-web-token'));
    print('this is from show posts');
    var info = decoded.payload;
    var id = decoded.payload['id'];
    print(id);
    http.Response response = await http.get(Uri.parse('$url/find-posts/$id'),
      headers: <String, String>{

        'Content-Type': 'application/json; charset=UTF-8',
      },);
    print('posts decoded');




   var decodedPosts= jsonDecode(response.body);
   print(decodedPosts);
   print(decodedPosts['post'][0]);
   print('this is a comment');
   print(decodedPosts['post'][1]['comments'][0]);
   var pbPosts=decodedPosts['post'];

    posts=pbPosts;

    print('these are posts');
    print(pbPosts[0]);


    return posts;


  }
  Future<String> showUserData()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get('x-auth-token') as String;
    var decoded = jwt.JWT.verify(
        token, jwt.SecretKey('some-kind-of-secret-key-of-json-web-token'));
    print('this is from show posts');
    var info = decoded.payload;
    var id = decoded.payload['id'];
    print(id);
    http.Response response = await http.get(Uri.parse('$url/find-posts/$id'),
      headers: <String, String>{

        'Content-Type': 'application/json; charset=UTF-8',
      },);
    print('this is user');
    userName=jsonDecode(response.body)['user']['name'];
    profilePic=jsonDecode(response.body)['user']['photoURL'];
    print(userName);
    print('this is profile pic'+profilePic);
    return userName;


  }

  PostsBackend backend=PostsBackend();




  @override
  Widget build(BuildContext context) {
    showUserData();
    showPosts();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home:  Scaffold(
        appBar: AppBar(
          leading: Container(
            height: 100,
            width: 100,
            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8o8Bri-SBt48OOxFCzPQ5Nnh_BBbuLXCPKg&s'),
          ),
          leadingWidth: 100,

          backgroundColor: Colors.blue,
          

        ),
          body: /*ListView.builder(itemCount:posts.length,itemBuilder: (context,index){
            List<dynamic> comments=posts[index]['comments'];
            return Card(
              



              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                         CircleAvatar(
                           backgroundColor: Colors.black12,
                           //backgroundColor: Colors.pinkAccent,
                           
                           radius:20,
                           child:ClipOval(
                             child: profilePic.isEmpty ? Icon(Icons.person)
                             : Image.network(profilePic,fit: BoxFit.cover,),
                           )
                           ,),
                      const SizedBox(width: 10,),
                      Text(userName,style: const TextStyle(color: Colors.white),),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      height: 300,
                      child: Image.network('${posts[index]['photoURL']}',fit: BoxFit.cover,),
                    ),
                    const SizedBox(height: 5,),
                   const Row(
                      children: [
                        Icon(Icons.favorite_border,size: 30,),
                         SizedBox(width: 10,),
                        Icon(Icons.comment_outlined,size: 30,),
                        SizedBox(width: 10,),
                        Icon(Icons.send)
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      child: Text('${posts[index]['likes']} likes'),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      child: comments.isEmpty ? Text('no comments to this post')
                      :Text('${posts[index]['comments'][0]}'),
                    ),
                    const SizedBox(height: 5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CommentsScreen(comments: posts[index]['comments'],userName: userName,);
                        }));
                      },
                      child: Container(
                        child: Text('view all ${posts[index]['comments'].length} comments'),
                      ),
                    ),

                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(text:userName,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                          ),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text('${posts[index]['caption']}')
                      ],
                    )
                  ],
                ),
              ),
            );
          })*/

        Center(
          child: Container(
            color: Colors.grey,
            child: CarouselSlider.builder(itemCount: posts.length,
                itemBuilder: (BuildContext context,int index,int viewindex){
                  List<dynamic> comments=posts[index]['comments'];
                  return Card(




                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black12,
                                //backgroundColor: Colors.pinkAccent,

                                radius:20,
                                child:ClipOval(
                                  child: profilePic.isEmpty ? Icon(Icons.person)
                                      : Image.network(profilePic,fit: BoxFit.cover,),
                                )
                                ,),
                              const SizedBox(width: 10,),
                              Text(userName,style: const TextStyle(color: Colors.white),),
                            ],
                          ),

                          Container(
                            width: double.infinity,
                            height: 300,
                            child: GestureDetector(
                                onTap: _animate,
                                child: Image.network('${posts[index]['photoURL']}',fit: BoxFit.cover,)),
                          ),
                          const SizedBox(height: 5,),
                           Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Icon(Icons.favorite_border,
                                  color: Colors.red,);


                                },
                                child:  Icon(
                                  Icons.favorite_border,
                                  size: 30,),

                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.comment_outlined,size: 30,),
                              SizedBox(width: 10,),
                              Icon(Icons.send)
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Container(
                            child: Text('${posts[index]['likes']} likes'),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            child: comments.isEmpty ? const Text('no comments to this post')
                                :Text('${posts[index]['comments'][0]}'),
                          ),
                          const SizedBox(height: 5,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CommentsScreen(comments: posts[index]['comments'],userName: userName,);
                              }));
                            },
                            child: Container(
                              child: Text('view all ${posts[index]['comments'].length} comments'),
                            ),
                          ),

                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(text:userName,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                                ),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Text('${posts[index]['caption']}')
                            ],
                          )
                        ],
                      ),
                    ),
                  );

                },
                options: CarouselOptions(height: 700)),
          ),
        )
      ),
    );





  }
}
