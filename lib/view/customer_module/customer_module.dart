import 'package:flutter/material.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
class Customer_Module extends StatelessWidget {
  const Customer_Module({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text("Customer Module"),
        SizedBox(height: 50,),
        Container(child: textField(icon: Icon(Icons.add_location),hintText: "Pickup Location",),),
        SizedBox(height: 20,),
        Container(child: textField(icon: Icon(Icons.add_location),hintText: "Put destination",),),
        TextButton(onPressed: (){}, child: Row(children: [
          Icon(Icons.location_on,),
          Text("Set Location on map"),],),),
        Reuseable_Button(text: Text("Show drivers"),),
    ],),);
  }
}
