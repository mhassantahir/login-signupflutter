import 'package:flutter/material.dart';
import 'package:untitled/login_screen.dart';
import 'package:untitled/registerpage.dart';

class loginorRegisterpage extends StatefulWidget {
  const loginorRegisterpage({super.key});

  @override
  State<loginorRegisterpage> createState() => _loginorRegisterpageState();
}

class _loginorRegisterpageState extends State<loginorRegisterpage> {
  //initially show login page
  bool showlogin_scrren  = true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showlogin_scrren = !showlogin_scrren;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showlogin_scrren){
      return LoginScreen(
        onTap: togglePages,
      );
    }else{
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
