import 'package:flutter/material.dart';
import 'package:share_ride/view/starting_module/authentication/login/login_view.dart';

class Reuseable_Button extends StatelessWidget {
  Reuseable_Button({
    this.text,

  });
  var text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(20),

      ),child: Center(child: Text(text,style: TextStyle(color: Colors.white),)),
    );
  }
}