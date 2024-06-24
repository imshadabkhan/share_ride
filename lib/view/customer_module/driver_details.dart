import 'package:flutter/material.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
class Driver_Details extends StatefulWidget {
  const Driver_Details({super.key});

  @override
  State<Driver_Details> createState() => _Driver_DetailsState();
}

class _Driver_DetailsState extends State<Driver_Details> {
  bool _loading=false;
  String name="shadab";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [Icon(Icons.arrow_back_ios), Text("Driver Details")],
          ),
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 120,
          ),
          Text("Driver name"),
          Text("Phone number"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Reuseable_Contact(
                icon: Icons.request_quote_outlined,
                txt: "Request",
              ),
              Reuseable_Contact(
                icon: Icons.call,
                txt: "Call",
              ),
              Reuseable_Contact(
                icon: Icons.message,
                txt: "Message",
              ),
            ],
          ),
          Reuseable_Button(
            loading: _loading,
            text: "Show directions",
          )
        ],
      ),
    );
  }
}

class Reuseable_Contact extends StatelessWidget {
  Reuseable_Contact({
    this.icon,
    this.txt,
  });
  var icon;
  var txt;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        Text(txt),
      ],
    );
  }
}
