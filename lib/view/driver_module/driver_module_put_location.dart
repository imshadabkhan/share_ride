// import 'package:flutter/material.dart';
//
//
// import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
// import 'package:share_ride/widgets/reuseable_button.dart';
// import 'package:get/get.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../customer_module/customer_mapbox_view/view/customer_mapbox_view.dart';
//
// class Driver_Module extends StatefulWidget {
//   Driver_Module({super.key});
//   @override
//   State<Driver_Module> createState() => _Driver_ModuleState();
// }
//
// class _Driver_ModuleState extends State<Driver_Module> {
//   final TextEditingController _pickLocationController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();
//   final TextEditingController _offerController = TextEditingController();
//   bool locationPosition = false;
//   bool destinationPosition = false;
//   final databaseRef = FirebaseDatabase.instance.ref("Customer");
//   bool _loading = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: height * .1,
//             ),
//             Text("Driver Module"),
//             SizedBox(
//               height: 50,
//             ),
//             Container(
//               child: textField(
//                 keyboardType: TextInputType.none,
//                 onTap: () {
//                   Get.bottomSheet(
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(20)),
//                       height: height * 1,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 15),
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: height * .02,
//                             ),
//                             Container(
//                               child: textField(
//                                 controller: _pickLocationController,
//                                 hintText: "Pickup Location",
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Get.to(CustomerMapScreen());
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.location_on,
//                                   ),
//                                   Text("Set Location on map"),
//                                 ],
//                               ),
//                             ),
//                             ElevatedButton(
//                                 onPressed: () {
//                                   locationPosition = true;
//                                   Navigator.pop(context);
//                                   setState(() {});
//                                 },
//                                 child: Text("Done")),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 icon: Icon(Icons.location_on),
//                 hintText: locationPosition
//                     ? _pickLocationController.text.toString()
//                     : "PickupLocation2",
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               child: textField(
//                 keyboardType: TextInputType.none,
//                 hintText: destinationPosition
//                     ? _destinationController.text.toString()
//                     : "Destination",
//                 onTap: () {
//                   Get.bottomSheet(
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(20)),
//                       height: height * 1,
//                       child: Padding(
//                         padding:
//                         EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: height * .02,
//                             ),
//                             Container(
//                               child: textField(
//                                 controller: _destinationController,
//                                 hintText: "Destination",
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // Get.to(Customer_Map_View());
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.location_on,
//                                   ),
//                                   Text("Set Location on map"),
//                                 ],
//                               ),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   destinationPosition = true;
//                                 });
//                                 Navigator.pop(context);
//                               },
//                               child: Text("Done"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 icon: Icon(Icons.location_on),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               child: textField(
//                 controller: _offerController,
//                 maxlength: 5,
//                 keyboardType: TextInputType.number,
//                 hintText: "Enter your offer",
//               ),
//             ),
//             SizedBox(
//               height: height * .01,
//             ),
//             SizedBox(
//               height: height * .1,
//             ),
//             GestureDetector(
//               onTap: () {
//                 databaseRef.child('1').set({
//                   'Pickup location': _pickLocationController.text.toString(),
//                   'Destination location':
//                   _destinationController.text.toString(),
//                   'Customer offer': _offerController.text.toString(),
//                 });
//                 // Get.to(Driver_Map_View());
//               },
//               child: Reuseable_Button(
//                 loading: _loading,
//                 text: "Next",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
