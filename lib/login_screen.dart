
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/my_text_field.dart';
import 'package:untitled/mybutton.dart';
import 'package:untitled/space.dart';
import 'package:untitled/square_tile.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
   LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text edit controller
  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  //sign in user method
   void signUserIn() async{
     //show a loading circle
     showDialog(context: context, builder: (context) {
       return const Center(
         child: CircularProgressIndicator(),
       );
     },);
     //try sign in
     try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: emailcontroller.text,
         password: passwordcontroller.text,
       );//pop the loading circle
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
                  size: 100,
                ),
                SpaceVH(height: 50,),
                //welcome, you've been missed
                Text("Welcome back you\'ve been missed!",
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
                SpaceVH(height: 15,),
                //forget password
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forget Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),),
                    ],
                  ),
                ),
                SpaceVH(height: 15,),
                //sign in button
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
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
                    Text("Not a member?",style: TextStyle(color: Colors.grey.shade700),
                    ),
                    SpaceVH(height: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Register Now",
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
