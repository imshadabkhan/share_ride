import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_ride/utils/toast_message.dart';
import 'package:share_ride/view/starting_module/authentication/login/view/login_view.dart';
import 'package:share_ride/view/starting_module/authentication/otp_view/otp_view.dart';
import 'package:share_ride/view/starting_module/authentication/sign_up/sign_up_view.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/view/starting_module/choose_account/choose_account.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sign_Up_View extends StatefulWidget {
  Sign_Up_View({super.key});
  @override
  State<Sign_Up_View> createState() => _Sign_Up_ViewState();
}

class _Sign_Up_ViewState extends State<Sign_Up_View> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formField = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();
  ToastMessage toastMessage = ToastMessage();
   bool _loading=false;

  void createUser() async {
    try {
      //Create/signUp user with email and password with unique id//
     final User? userFirebase =(
          await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString())).user;


      //Store User info in RealTime database//
      final databaseref = FirebaseDatabase.instance.ref().child("Users").child(userFirebase!.uid);
      await databaseref.set({
        "userName": _usernameController.text.toString(),
        "phoneNo": _phonenoController.text.toString(),
        "email": _emailController.text.toString(),
        "password":_passwordController.text.toString(),
      });

      //Navigate to other screen after these functions//
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Select_Account(),
          )).then((value) {
        toastMessage.Toaster("Account Created Successfully");
      }).onError((error, stackTrace) {
        setState(() {});
        toastMessage.Toaster(error.toString());
      });
    } catch (error) {
      toastMessage.Toaster(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 60,
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                    )),
                Container(
                  height: 20,
                ),
                Text(
                  "Sign up",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "create  your account",
                ),
                Container(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formField,
                  child: Column(
                    children: [
                      textField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter username";
                          } else {
                            return null;
                          }
                        },
                        controller: _usernameController,
                        contentPadding: EdgeInsets.all(10),
                        icon: Icon(Icons.person),
                        hintText: "user name",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your phone no";
                          } else {
                            return null;
                          }
                        },
                        controller: _phonenoController,
                        keyboardType: TextInputType.number,
                        contentPadding: EdgeInsets.all(10),
                        icon: Icon(Icons.phone),
                        hintText: "enter your phone number",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your email";
                          } else {
                            return null;
                          }
                        },
                        controller: _emailController,
                        contentPadding: EdgeInsets.all(10),
                        icon: Icon(Icons.email),
                        hintText: "enter your email",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your password";
                          } else {
                            return null;
                          }
                        },
                        controller: _passwordController,
                        contentPadding: EdgeInsets.all(10),
                        icon: Icon(Icons.lock),
                        hintText: "enter your Password",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password again";
                          } else {
                            return null;
                          }
                        },
                        controller: _confirmpasswordController,
                        contentPadding: EdgeInsets.all(10),
                        icon: Icon(Icons.lock),
                        hintText: "retype Password",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Otp_Verification(),
                        ));
                  },
                  child: GestureDetector(
                    onTap: () async {
                      if (_formField.currentState!.validate()) {
                        _loading=true;
                        createUser();
                        _loading=false;
                      } else
                        return null;
                    },
                    child: Reuseable_Button(
                      loading: _loading,
                      text: "Create account",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Login_View()),
                        );
                      },
                      child: Text("login here"),
                    ),
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
