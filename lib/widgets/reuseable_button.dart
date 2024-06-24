import 'package:flutter/material.dart';
import 'package:share_ride/view/starting_module/authentication/login/view/login_view.dart';

class Reuseable_Button extends StatelessWidget {
  Reuseable_Button({
    this.text,
    this.loading,

  });

  var text;
  final bool ?loading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery
          .sizeOf(context)
          .width,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(20),

      ),
      child: Center(child: loading!
          ? Container(
          height: 20,width: 20,
          child: CircularProgressIndicator(color: Colors.grey,))
          :Text(text, style: TextStyle(color: Colors.white),),
    ));
  }
}
