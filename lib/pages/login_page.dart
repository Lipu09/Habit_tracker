import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../comp/my_button.dart';
import '../comp/my_loading_circle.dart';
import '../comp/my_text_field.dart';
import '../service/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth =AuthService();

  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  void login() async{
    //show loading circle
    showLoadingCircle(context);
    try{
      await _auth.loginEmailPassword(emailController.text, pwController.text);

      // finished loading
      if(mounted) hideLoadingCircle(context);
    }
    catch(e){
      // finished loading
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

                  // welcome back message

                  Text("Welcome back , you\'ve  been missed!",style: TextStyle(color: Colors.grey.shade500,fontSize: 16),),

                  SizedBox(height: 25,),
                  //email textfield
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
                  SizedBox(height:10 ,),

                  //forgot password
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text("Forgot Password?" , style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold),)),

                  SizedBox(height: 25,),

                  // Sign in button
                  MyButton(
                    text: "Login",
                    onTap: login,
                  ),
                  SizedBox(height: 30,),
                  // not a member ? register here,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?" ,  style: TextStyle(color: Colors.grey.shade500,),),
                      SizedBox(width:5 ,),

                      GestureDetector(
                          onTap: widget.onTap,
                          child: Text("Register now",  style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold),)),
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

/*

surface : Colors.grey.shade300,
primary : Colors.grey.shade500,
secondary : Colors.grey.shade200,
tertiary : Colors.white,
inversePrimary : Colors.grey.shade900,

 */