import 'package:flutter/material.dart';
import 'package:share_ride/view/starting_module/authentication/login/login_view.dart';
import 'package:share_ride/view/starting_module/authentication/otp_view/otp_view.dart';
import 'package:share_ride/view/starting_module/authentication/sign_up/sign_up_view.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
class Sign_Up_View extends StatefulWidget {
  const Sign_Up_View({super.key});

  @override
  State<Sign_Up_View> createState() => _Sign_Up_ViewState();
}

class _Sign_Up_ViewState extends State<Sign_Up_View> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 28.0,vertical: 20),
        child: Column(children: [
          SizedBox(height: 30,),
          Container(
              height: 60,

              child: Image(image: AssetImage("assets/images/logo.png"),)),
          Container(height: 20,),
          Text("Sign up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text("create  your account",),
          Container(height: 20,),
          Container(
            height: 50,
            child: textField(
              contentPadding: EdgeInsets.all(10),

              icon: Icon(Icons.person),hintText: "user name",),
          ),
          SizedBox(height: 20,),

          Container(
            height: 50,
            child: textField(
              contentPadding: EdgeInsets.all(10),

              icon: Icon(Icons.email),hintText: "enter your email",),
          ),
          SizedBox(height: 20,),

          Container(
            height: 50,
            child: textField(
              contentPadding: EdgeInsets.all(10),

              icon: Icon(Icons.lock),hintText: "enter your Password",),
          ),
          SizedBox(height: 20,),

          Container(
            height: 50,
            child: textField(
              contentPadding: EdgeInsets.all(10),

              icon: Icon(Icons.lock),hintText: "retype Password",),
          ),
          SizedBox(height: 20,),



          SizedBox(height: 50,),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Otp_Verification(),));
            },
            child:Reuseable_Button(text: "Create account",),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dont have an account?"),
              TextButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Login_View()));
              }, child: Text("login here"),),
            ],
          ),


        ],),
      ),
    ),);
  }
}
