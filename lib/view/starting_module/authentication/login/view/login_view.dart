import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_ride/constants/constant_color.dart';
import 'package:share_ride/view/starting_module/authentication/forgot_password_view/forgot_password.dart';
import 'package:share_ride/view/starting_module/authentication/login/controller/login_controller.dart';
import 'package:share_ride/view/starting_module/authentication/sign_up/view/sign_up_view.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/view/starting_module/choose_account/choose_account.dart';
import 'package:share_ride/widgets/reuseable_button.dart';

import '../../../choose_account/controller/chooseaccount_controller.dart';

class Login_View extends StatefulWidget {
  Login_View({super.key});
  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formField = GlobalKey<FormState>();
  LoginController loginController = LoginController();
  //ChooseAccountController chooseAccountController=Get.find<ChooseAccountController>(ChooseAccountController());
  ChooseAccountController chooseAccountController=Get.put(ChooseAccountController());

  @override
  Widget build(BuildContext context) {
    return

      // WillPopScope(
      // onWillPop: () async {
      //   SystemNavigator.pop();
      //   return true;
      // },
      // child:

    Scaffold(
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
                    "Welcome! ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(
                    chooseAccountController.status1.value==false ? "Login to your Passenger Account or Signup":"Login to your Driver Account or Signup",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formField,
                    child: Column(
                      children: [
                        textField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter email ";
                            }
                          },
                          controller: _emailController,
                          contentPadding: EdgeInsets.all(10),
                          icon: Icon(Icons.email),
                          hintText: "Email",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        textField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                          },
                          controller: _passwordController,
                          contentPadding: EdgeInsets.all(10),
                          icon: Icon(Icons.lock),
                          hintText: "Password",
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext) =>
                                        Forgot_Password()));
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontSize: 12,
                                color: Constant_Colors.secondarycolor),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formField.currentState!.validate()) {
                        loginController.Login(
                            _emailController, _passwordController);
                      }
                    },
                    child: Obx(() => Reuseable_Button(
                          loading: loginController.loading.value,
                          text: "Login",
                        )),
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
                                  builder: (BuildContext context) =>
                                      Sign_Up_View()));
                        },
                        child: Text(
                          "Sign up here",
                          style:
                              TextStyle(color: Constant_Colors.secondarycolor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    // );
  }
}
