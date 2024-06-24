import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_ride/view/starting_module/authentication/login/view/login_view.dart';
import 'package:share_ride/widgets/reuseable_button.dart';

import '../choose_account/choose_account.dart';

class Onboarding_View extends StatelessWidget {
  bool _loading=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/oboarding_car.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome to Share Ride!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Ride together, ride safer. Share Ride connects you with a network of friendly drivers. Enjoy comfortable rides and peace of mind with our safety features.Share Ride brings people together, offering a safe and reliable way to explore your city." ,textAlign: TextAlign.center,
              ),
              Container(
                height: 80,
                width: double.infinity,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Select_Account()));
                  },
                  child: Reuseable_Button(
                    loading: _loading,
                    text: "Continue",
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}
