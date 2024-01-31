import 'package:flutter/material.dart';
import 'package:share_ride/utilities/colors/app_colors.dart';
import 'package:share_ride/view/starting_module/authentication/forgot_password_view/forgot_password.dart';
import 'package:share_ride/view/starting_module/authentication/sign_up/sign_up_view.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 28.0,vertical: 20),
        child: Column(children: [
          Container(
              height: 60,
              child: Image(image: AssetImage("assets/images/logo.png"),)),
          Container(height: 20,),
          Text("Change Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20
          ),),
          Text("Create your new password",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
          SizedBox(height: 20,),
          Container(
            height: 50,
            child: textField(
              contentPadding: EdgeInsets.all(10),

              icon: Icon(Icons.lock),hintText: " new password",),
          ),
          SizedBox(height: 20,),

          Container(
            height: 50,
            child: textField(
              contentPadding: EdgeInsets.all(10),

              icon: Icon(Icons.lock),hintText: "retype password",),
          ),


          SizedBox(height: 40,),
          Reuseable_Button(text:"Change Password"),



        ],),
      ),
    ),);
  }
}
