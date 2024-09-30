import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  const MyTextField({Key? key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller,
      obscureText: obsecureText,
      decoration:  InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor:  Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500,)
      ),
    );
  }
}
/*

surface : Colors.grey.shade300,
primary : Colors.grey.shade500,
secondary : Colors.grey.shade200,
tertiary : Colors.white,
inversePrimary : Colos.grey.shade900,

 */