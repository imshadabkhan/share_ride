import 'package:flutter/material.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/view/starting_module/choose_account/choose_account.dart';
import 'package:share_ride/widgets/reuseable_button.dart';

class Enter_Otp_Code extends StatefulWidget {
  @override
  State<Enter_Otp_Code> createState() => _Enter_Otp_CodeState();
}

class _Enter_Otp_CodeState extends State<Enter_Otp_Code> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
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
              Text("Enter the OTP sent to"),
              SizedBox(height: 5),
              Text(
                "khanshahdabkhan1234@gmail.com",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: textField(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                      keyboardType: TextInputType.number,
                      maxlength: 1,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: textField(
                      keyboardType: TextInputType.number,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                      maxlength: 1,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: textField(
                      keyboardType: TextInputType.number,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                      maxlength: 1,
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: textField(
                      maxlength: 1,
                      keyboardType: TextInputType.number,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didnt you receive the OTP?"),
                  TextButton(
                    onPressed: () {},
                    child: Text("Resend OTP"),
                  ),
                ],
              ),
              SizedBox(height: 20),

              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (Context) => Select_Account(),
                  ),
                ),
                child: Reuseable_Button(
                  text: "Verify",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
