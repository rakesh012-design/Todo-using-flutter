import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white
          ),
        ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize:const Size(100,50)
      ),
    );
  }
}
