
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/my_text_field.dart';
import 'package:untitled/mybutton.dart';
import 'package:untitled/space.dart';
import 'package:untitled/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text edit controller
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final Confirmpasswordcontroller = TextEditingController();

  //sign user up method
  void signUserUp() async{
    //show a loading circle
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
    //try creating the user
    try{
      if(passwordcontroller.text == Confirmpasswordcontroller.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      }else {
        //show error message
        ShowErrorMssage("Passowd don't match!");
      }
      
      //pop the loading circle
      Navigator.pop(context);

    } on FirebaseAuthException catch (e){
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      ShowErrorMssage(e.code);
    }

  }
  //wrong email popup
  void ShowErrorMssage(String message) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpaceVH(height: 50,),
                //logo
                Icon(Icons.lock,
                  size: 50,
                ),
                SpaceVH(height: 25,),
                //welcome, you've been missed
                Text("Let\'s create an account",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),),
                SpaceVH(height: 25,),
                //username
                MyTextField(
                  controler: emailcontroller,
                  hintText: 'E-mail',
                  obsecureText: false,
                ),
                SpaceVH(height: 10,),
                //password
                MyTextField(
                  controler: passwordcontroller,
                  hintText: 'Password',
                  obsecureText: true,
                ),
                SpaceVH(height: 10,),
                //password
                MyTextField(
                  controler: Confirmpasswordcontroller,
                  hintText: 'Confirm Password',
                  obsecureText: true,
                ),
                SpaceVH(height: 25,),
                //forget password
               /* Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forget Password",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),),
                    ],
                  ),
                ),*/
                //sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                SpaceVH(height: 50,),
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or continue with"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,

                        ),
                      ),
                    ],
                  ),
                ),
                SpaceVH(height: 50,),
                //google or apple sigin in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'assets/images/google.png'),
                    SpaceVH(width: 25,),
                    SquareTile(imagePath: 'assets/images/apple.png')
                  ],
                ),
                SpaceVH(height: 40,),
                // not a member,register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(color: Colors.grey.shade700),
                    ),
                    SpaceVH(height: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Login Now",
                        style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),



              ],
            ),
          ),
        ),
      ),

    );
  }
}
