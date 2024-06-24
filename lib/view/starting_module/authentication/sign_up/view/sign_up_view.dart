import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_ride/utils/toast_message.dart';
import 'package:share_ride/view/starting_module/authentication/login/view/login_view.dart';
import 'package:share_ride/view/starting_module/authentication/otp_view/otp_view.dart';
import 'package:share_ride/view/starting_module/authentication/sign_up/controller/signup_controller.dart';
import 'package:share_ride/view/starting_module/authentication/sign_up/view/sign_up_view.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/view/starting_module/choose_account/choose_account.dart';
import 'package:share_ride/view/starting_module/choose_account/controller/chooseaccount_controller.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Sign_Up_View extends StatefulWidget {
  Sign_Up_View({super.key});
  @override
  State<Sign_Up_View> createState() => _Sign_Up_ViewState();
}

class _Sign_Up_ViewState extends State<Sign_Up_View> {
  final _formField = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();
  Signup_Controller signup_controller = Signup_Controller();
  ChooseAccountController chooseAccountController=Get.put(ChooseAccountController());
  final TextEditingController _carNumberController=TextEditingController();
  final TextEditingController _nicNumberController=TextEditingController();
  final TextEditingController _carRegistrationController=TextEditingController();
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
                Container(
                  height: 10,
                ),
                Text(
                 chooseAccountController.status2.value? "Create Your Passenger Account":"Create Your Driver Account",
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
                      //status1.value is true is for driver
                      chooseAccountController.status1.value==true ?
                      Column(
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
                          // textField(
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return "Enter password again";
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          //   controller: _confirmpasswordController,
                          //   contentPadding: EdgeInsets.all(10),
                          //   icon: Icon(Icons.lock),
                          //   hintText: "retype Password",
                          // ),

                          textField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Car number";
                              } else {
                                return null;
                              }
                            },
                            controller: _carNumberController,
                            contentPadding: EdgeInsets.all(10),
                            icon: Icon(Icons.lock),
                            hintText: "Car number",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          textField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Nic number";
                              } else {
                                return null;
                              }
                            },
                            controller: _nicNumberController,
                            contentPadding: EdgeInsets.all(10),
                            icon: Icon(Icons.lock),
                            hintText: "nic number without dashes",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          textField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Car Registration Number";
                              } else {
                                return null;
                              }
                            },
                            controller: _carRegistrationController,
                            contentPadding: EdgeInsets.all(10),
                            icon: Icon(Icons.lock),
                            hintText: "Car registration number",
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
                        ],
                      ):Column(
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
                          // textField(
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return "Enter password again";
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          //   controller: _confirmpasswordController,
                          //   contentPadding: EdgeInsets.all(10),
                          //   icon: Icon(Icons.lock),
                          //   hintText: "retype Password",
                          // ),
                          SizedBox(
                            height: 20,
                          ),


                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => Otp_Verification());
                  },
                  child: GestureDetector(
                    onTap: () async {
                      if (_formField.currentState!.validate()) {
                        setState(() {
                          chooseAccountController.status1==false?
                          signup_controller.createUser(
                              _emailController,
                              _passwordController,
                              _usernameController,
                              _phonenoController):signup_controller.createDriver(_emailController, _passwordController, _usernameController, _phonenoController, _carNumberController, _nicNumberController, _carRegistrationController);
                        });
                      } else
                        return null;
                    },
                    child: Obx(
                      () => Reuseable_Button(
                        loading: signup_controller.loading.value,
                        text: "Create account",
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.to(() => Login_View());
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
