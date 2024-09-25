import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool isPass;
  final TextInputType textInputType;
  const CustomBox({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines=1,
    this.isPass=false,
    required this.textInputType,

  });



  @override
  Widget build(BuildContext context) {



    return TextFormField(





      controller: controller,

      decoration: InputDecoration(

          hintText: hintText,

          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black38,
              )
          )
      ),
      validator: (val){
        if(val == null || val.isEmpty){
          return 'Enter your $hintText';
        }
        return null;

      },
      maxLines: maxLines,
      obscureText: isPass,


    );
  }
}
