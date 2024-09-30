import 'package:flutter/material.dart';
import '../comp/my_button.dart';
import '../comp/my_loading_circle.dart';
import '../comp/my_text_field.dart';

import '../service/auth/auth_service.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({Key? key,required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //access auth service
  final _auth = AuthService();
  //text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  void register() async{
    // password math -> create user
    if(pwController.text == confirmPwController.text){
      //show loading cricle
      showLoadingCircle(context);

      //attempt to register new user
      try{
        await _auth.registerEmailPassword(emailController.text, pwController.text);

        //finished loading
        if(mounted) hideLoadingCircle(context);
      }
      catch(e){
        //finished loading
        if(mounted) hideLoadingCircle(context);

        if(mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }

      }
    }

    // password don't match -> show error
    else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password don't match"),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade300 ,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  // logo
                  Icon(Icons.lock_open_rounded,size: 72,color: Colors.grey.shade500,),
                  SizedBox(height: 50,),

                  //Create an account message

                  Text("Create an account for you",style: TextStyle(color: Colors.grey.shade500,fontSize: 16),),

                  SizedBox(height: 25,),
                  //email textfield

                  MyTextField(
                      controller: nameController,
                      hintText: "Enter your name",
                      obsecureText: false
                  ),
                  SizedBox(height: 10,),
                  MyTextField(
                      controller: emailController,
                      hintText: "Enter email",
                      obsecureText: false
                  ),
                  SizedBox(height: 10,),
                  MyTextField(
                    controller: pwController,
                    hintText: "Enter password",
                    obsecureText: true,
                  ),
                  SizedBox(height: 10,),
                  MyTextField(
                      controller: confirmPwController,
                      hintText: "Confirm password",
                      obsecureText: true
                  ),

                  SizedBox(height: 25,),

                  // Sign up button
                  MyButton(
                    text: "Register",
                    onTap: register,
                  ),
                  SizedBox(height: 30,),
                  // Already a member? Login now,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a member?" ,  style: TextStyle(color: Colors.grey.shade500,),),
                      SizedBox(width:5 ,),

                      GestureDetector(
                          onTap:widget.onTap,
                          child: Text("Login now",  style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold),)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
