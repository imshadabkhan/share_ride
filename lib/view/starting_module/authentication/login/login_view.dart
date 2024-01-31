import 'package:flutter/material.dart';
import 'package:share_ride/utilities/colors/app_colors.dart';
import 'package:share_ride/view/starting_module/authentication/forgot_password_view/forgot_password.dart';
import 'package:share_ride/view/starting_module/authentication/sign_up/sign_up_view.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
class Login_View extends StatefulWidget {
  const Login_View({super.key});

  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
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
          Text("Welcome back",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20
          ),),
          Text("Login to your account",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
          SizedBox(height: 20,),
          Container(
            height: 50,
            child: textField(
              contentPadding: EdgeInsets.all(10),

              icon: Icon(Icons.email),hintText: "Email",),
          ),
          SizedBox(height: 20,),

          Container(
            height: 50,
            child: textField(
              contentPadding: EdgeInsets.all(10),

              icon: Icon(Icons.lock),hintText: "Password",),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=>Forgot_Password()));

              }, child: Text("Forgot Password",style: TextStyle(fontSize:12,color: Constant_Colors.secondarycolor),)),
            ],
          ),

          SizedBox(height: 40,),
          Reuseable_Button(text:"Login"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dont have an account?"),
              TextButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Sign_Up_View()));
              }, child: Text("Sign up here",style: TextStyle(color: Constant_Colors.secondarycolor ),),),
            ],
          )


        ],),
      ),
    ),);
  }
}
