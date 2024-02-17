import 'package:flutter/material.dart';
import 'package:share_ride/view/starting_module/authentication/otp_view/enter_otp_code.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/view/starting_module/choose_account/choose_account.dart';
import 'package:share_ride/widgets/reuseable_button.dart';

class Otp_Verification extends StatefulWidget {
  const Otp_Verification({super.key});

  @override
  State<Otp_Verification> createState() => _Otp_VerificationState();
}

class _Otp_VerificationState extends State<Otp_Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150),
              Container(
                  height: 150,
                  child: Image(
                      image: AssetImage("assets/images/otp_verification.png"))),
              SizedBox(height: 30),
              Text(
                "OTP Verifications",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 5),
              Text("We will send OTP to your email"),
              SizedBox(height: 20),
              Container(
                  height: 50,
                  child: textField(
                    contentPadding: EdgeInsets.all(10),
                    icon: Icon(Icons.email),
                    hintText: "email",
                  )),
              SizedBox(height: 30),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (Context) => Enter_Otp_Code(),
                  ),
                ),
                child: Reuseable_Button(
                  text: "Get OTP",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
