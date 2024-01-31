import 'package:flutter/material.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/widgets/reuseable_button.dart';

class Amount_View extends StatefulWidget {
  const Amount_View({super.key});

  @override
  State<Amount_View> createState() => _Amount_ViewState();
}

class _Amount_ViewState extends State<Amount_View> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(children: [
        SizedBox(height: 20,
        ),
        Container(height: 200,width: double.infinity,child: Column(children: [
          Text("Enter fare amount"),
          Container(
              height: 80,
              child: textField()),
          Reuseable_Button(text: "Send Request",),
        ],),)
      ],),
    );
  }
}
