import 'package:backend_learning/Screens/posts_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class CommentsScreen extends StatefulWidget {
  final List<dynamic> comments;
  final String userName;
  const CommentsScreen({
    super.key,required this.comments,
    required this.userName
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Container(
          width: 300,
          color: Colors.grey,
          child: CarouselSlider.builder(
            options: CarouselOptions(height: 400),
            itemCount: widget.comments.length,
            itemBuilder: (BuildContext context,int index,int viewIndex){
              return Container(
                color: Colors.black,
                child: Row(
                  children: [
                    Center(child: RichText(
                      text: TextSpan(text:widget.userName,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                      ),
                      ),
                    ),),
                    const SizedBox(width: 30,),
                    Center(child: Text(widget.comments[index])),

                  ],
                ),
              );
            },
          ),

        ),
      )
      /*ListView.builder(itemCount: widget.comments.length,itemBuilder: (context,index){
        return Column(
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: RichText(
                  text: TextSpan(text:widget.userName,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                  ),
                  ),
                ),),
                const SizedBox(width: 10,),
                Center(child: Text(widget.comments[index])),
              ],
            ),

          ],
        );
      }
      )*/
    );
  }
}
