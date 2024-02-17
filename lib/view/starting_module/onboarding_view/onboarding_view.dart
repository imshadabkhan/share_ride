import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_ride/view/starting_module/authentication/login/view/login_view.dart';
import 'package:share_ride/widgets/reuseable_button.dart';

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
                "Lorem ipsum dolor sit amet consectetur. Tempus nec pellentesque id cras vivamus amet libero vel. Pellentesque nullam quam iaculis erat tellus lectus nunc. Malesuada habitasse ligula vulputate enim mattis id adipiscing ut amet.",
                textAlign: TextAlign.center,
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
                            builder: (BuildContext context) => Login_View()));
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
