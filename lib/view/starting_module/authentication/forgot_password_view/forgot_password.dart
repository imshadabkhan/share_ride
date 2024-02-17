import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_ride/view/starting_module/authentication/login/view/login_view.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/widgets/reuseable_button.dart';

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});
  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  TextEditingController _emailController = TextEditingController();

  final _formField = GlobalKey<FormState>();
  bool _loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 60,
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                    )),
                Container(
                  height: 20,
                ),
                Text(
                  "Change Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "we will sent you link on your email to recover your  password,please write your email",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.start,
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
                            return "Enter your email";
                          } else {
                            return null;
                          }
                        },
                        controller: _emailController,
                        contentPadding: EdgeInsets.all(10),
                        icon: Icon(Icons.lock),
                        hintText: " email",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    onTap: () {
                      _loading = true;
                      if (_formField.currentState!.validate()) {
                        _auth.sendPasswordResetEmail(
                            email: _emailController.text.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Login_View()));
                        _loading = false;
                      } else {
                        return null;
                      }
                    },
                    child: Reuseable_Button(
                        loading: _loading, text: "Recover Password")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
