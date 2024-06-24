import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_ride/view/customer_module/customer_mapbox_view/services/destination_reverse_geocoding_service.dart';
import 'package:share_ride/view/customer_module/customer_mapbox_view/services/location_service.dart';
import 'package:share_ride/view/customer_module/customer_mapbox_view/services/reverse_geocoding_service.dart';
import 'package:share_ride/view/driver_module/driver_mapbox_view/services/forward_geocoding.dart';
import 'package:share_ride/view/driver_module/driver_mapbox_view/services/picklocation_forwardgeocoding.dart';
import 'package:share_ride/view/global_variable/global_variable.dart';
import 'package:share_ride/view/starting_module/authentication/sign_up/controller/signup_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../widgets/reuseable_button.dart';
import '../../../customer_module/customer_request/controller/customer_request_controller.dart';
import '../../../starting_module/authentication/widgets/custom_textfield.dart';
import '../../turnbyturn_navigation/turnbyturn.dart';
import '../services/driver_live_location_services.dart';

class DriverMapScreen extends StatefulWidget {
  const DriverMapScreen({super.key});

  @override
  State<DriverMapScreen> createState() => _DriverMapScreenState();
}

class _DriverMapScreenState extends State<DriverMapScreen> {
  @override
  PickupForwardGeocoding pickupForwardGeocoding = PickupForwardGeocoding();
  CustomerRequest_Controller customerRequest_Controller =
      CustomerRequest_Controller();
  final database_ref = FirebaseDatabase.instance.ref().child("SendRideRequest");
  final database_passenger =
      FirebaseDatabase.instance.ref().child("Users").child("Passengers");
  DriverForwardGeocoding driverForwardGeocoding = DriverForwardGeocoding();
  Signup_Controller signupController = Signup_Controller();

  void initState() {
    // TODO: implement initState
    super.initState();
    driver_location_Controller.getDriverCurrentLocation();
    _getCurrentLocation();
  }

  final MapController controller = MapController();
  Driver_Location_Controller driver_location_Controller =
      Driver_Location_Controller();
  LatLng? currentLocation;
  LatLng? customerPoint;
  LatLng? destinationPoint;
  ReverseGeocodingService reverseGeocodingService = ReverseGeocodingService();
  DestinationReverseGeocodingService destinationReverseGeocodingService =
      DestinationReverseGeocodingService();

  handleAcceptButtonPress(LatLng? passengerLocation,
      LatLng? passengerDestination, String? uID) async {
    Navigator.pop(context); // Assuming you want to close the current screen

    await Get.to(() => TurnByTurn(
          uniqueID: uID,
          driverLocation: currentLocation,
          passengerLocation: customerPoint,
          destinationLocation: destinationPoint,
        )); // If using GetX for navigation
  }

//Geting user current location and providing data in latitude and longitude
  Future<void> _getCurrentLocation() async {
    try {
      final locationData =
          await driver_location_Controller.getDriverCurrentLocation();
      final double latitude = locationData['latitude']!;
      final double longitude = locationData['longitude']!;
      setState(() {
        currentLocation = LatLng(latitude, longitude);
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  // get user final destination location
  Future<void> _getDestinationLocation(
      String destinationLocation, String Uid) async {
    final LatLng? destinationCoords = await driverForwardGeocoding
        .getCoordinatesFromAddress(destinationLocation);
    final double latitude = destinationCoords!.latitude;
    final double? longitude = destinationCoords.longitude;
    setState(() {
      destinationPoint = LatLng(longitude!, latitude);
    });
    //
    // if (destinationCoords != null) {
    //   // Use the retrieved coords object for display or further processing
    //   debugPrint(
    //       "The coords value from forward destination geo coding: ${destinationCoords.latitude}, ${destinationCoords.longitude}");
    //   // ... (Optional) Pass coords to another widget or function
    // } else {
    //   debugPrint(
    //       "Could not retrieve coordinates for '$destinationCoords'");
    //   // Handle the case where coordinates are not found
    // }
    // try{
    //
    // }catch(e){
    //
    // }

    //start navigation to points

    await handleAcceptButtonPress(customerPoint, destinationPoint, Uid);
  }

//get user pickup location
  Future<void> getcustomerLocation(String customerLocation) async {
    final LatLng? customerCoords = await pickupForwardGeocoding
        .getCoordinatesFromAddress(customerLocation);
    final double latitude = customerCoords!.latitude;
    final double? longitude = customerCoords.longitude;
    setState(() {
      customerPoint = LatLng(longitude!, latitude);
    });
  }

  Future updateValue(String uniqueId) async {
    await database_ref.child(uniqueId).update({
      "driverArriving": true,
    });
  }

  //Fetching username
  // Future fetchUserName(String uID)async{
  //  var data = database_passenger.child(uID).onValue.listen((event) {
  //    if(event.snapshot.value!=null){
  //      Map<dynamic, dynamic> data = event.snapshot
  //          .data!
  //          .snapshot
  //          .value as Map<dynamic, dynamic>;
  //
  //
  //
  //
  //    }
  //
  //  });
  //
  //
  //
  // }

//   Future fetchUserName(var uID) async {
//     DatabaseReference dataRef =
//     await FirebaseDatabase.instance.ref("Users").child("Passengers").child(uID);
//     dataRef.onValue.listen((DatabaseEvent event) {
//    dynamic data = event.snapshot.value ;
//       String passengerName = data['username'];
// return data['username'];
//
//     });
//   }






  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (currentLocation != null)
            FlutterMap(
              mapController: controller,
              options: MapOptions(
                initialCenter: currentLocation!,
                initialZoom: 18,

                //the below on tap funtion is to get desired location manually on map
                // onTap: (tapPosition, latLng) {
                //   setState(() {
                //     destinationPoint = latLng;
                //   });
                //   print('Destination Location: $destinationPoint');
                //   print('Tap Position: $tapPosition');
                // },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/imshadabkhan/cltvcme3z009501qsachq6fyc/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaW1zaGFkYWJraGFuIiwiYSI6ImNsdHZiam54NzFwaGMyb29hc21hZndidWwifQ.zAVfo5CWXYISVxuRSGVSPQ",
                  additionalOptions: {
                    "accessToken":
                        "pk.eyJ1IjoiaW1zaGFkYWJraGFuIiwiYSI6ImNsdHZiam54NzFwaGMyb29hc21hZndidWwifQ.zAVfo5CWXYISVxuRSGVSPQ",
                  },
                ),
                MarkerLayer(
                  markers: [
                    if (currentLocation != null)
                      Marker(
                        point: currentLocation ?? LatLng(0, 0),
                        width: 60,
                        height: 60,
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red.shade700,
                          size: 60,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          Positioned(
            bottom: 20,
            child: Container(
              width: MediaQuery.sizeOf(context).width / 2,
              child: GestureDetector(
                onTap: () {

                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      height: height * 1 / 3,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Finding Rides",
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.red),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Expanded(
                              child: StreamBuilder(
                                // stream: databaseref.onValue,
                                stream: database_ref.onValue,
                                builder: (context,
                                    AsyncSnapshot<DatabaseEvent> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.snapshot.value != null) {
                                    Map<dynamic, dynamic> data = snapshot
                                        .data!
                                        .snapshot
                                        .value as Map<dynamic, dynamic>;

                                    // List<String> list = map.values
                                    //     .map((value) => value.toString())
                                    //     .toList();

                                    return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        try {
                                          // var _destination =
                                          //     list[index].toString();
                                          // var _pickup = list[index].toString();
                                          // var offer = list[index].toString();
                                          String key = data.keys.elementAt(
                                              index); // Get the unique ID
                                          Map<dynamic, dynamic>
                                              rideRequestData = data[key];
                                          String destination =
                                              rideRequestData['Destination']
                                                  as String;
                                          String pickup =
                                              rideRequestData['Pickup']
                                                  as String;
                                          String offer =
                                              rideRequestData['offer']
                                                  as String;
                                          bool driverArriving =
                                              rideRequestData['driverArriving']
                                                  as bool;
                                          String uid =
                                              rideRequestData['uid'] as String;

                                          return Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Professionals_Widget(
                                              onPressed: () async {
                                                // fetchUserName(uid);
                                                debugPrint(
                                                  'the reuseable button is clicked'

                                                    // "the user name is===>" +
                                                    //     signupController
                                                    //         .currentUserName.value
                                                            );
                                                // fetchUserName(uid);
                                                // debugPrint("usernameee" +
                                                //     fetchUserName(uid)
                                                //         .toString());
                                                //Accept button functionality
                                                debugPrint(
                                                    "value of value is $driverArriving");
                                                updateValue(uid);

                                                // final LatLng? pickupcoords =
                                                //     await driverForwardGeocoding
                                                //         .getCoordinatesFromAddress(
                                                //             pickup);
                                                //
                                                // if (pickupcoords != null) {
                                                //   // Use the retrieved coords object for display or further processing
                                                //   debugPrint(
                                                //       "The coords value from forward pickup geo coding: ${pickupcoords.latitude}, ${pickupcoords.longitude}");
                                                //   // ... (Optional) Pass coords to another widget or function
                                                // } else {
                                                //   debugPrint(
                                                //       "Could not retrieve coordinates for '$pickup'");
                                                //   // Handle the case where coordinates are not found
                                                // }

                                                // final LatLng?
                                                //     destinationcoords =
                                                //     await driverForwardGeocoding
                                                //         .getCoordinatesFromAddress(
                                                //             destination);
                                                //
                                                // if (destinationcoords != null) {
                                                //   // Use the retrieved coords object for display or further processing
                                                //   debugPrint(
                                                //       "The coords value from forward destination geo coding: ${destinationcoords.latitude}, ${destinationcoords.longitude}");
                                                //   // ... (Optional) Pass coords to another widget or function
                                                // } else {
                                                //   debugPrint(
                                                //       "Could not retrieve coordinates for '$destinationcoords'");
                                                //   // Handle the case where coordinates are not found
                                                // }
                                                await getcustomerLocation(
                                                    pickup);
                                                await _getDestinationLocation(
                                                    destination, uid);

                                                debugPrint(
                                                    "the destination point value=${destinationPoint}");
                                                debugPrint(
                                                    "the customer point values=${customerPoint}");
                                              },
                                              pickup: pickup,
                                              destination: destination,
                                              offer: offer,
                                              // passengerName:  fetchUserName(uid).toString(),


                                            ),
                                          );
                                        } catch (e) {
                                          debugPrint(
                                              "Error building item at index $index: $e");
                                          // Handle the error, for now, I'm returning an empty Container
                                        }
                                      },
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("Error${snapshot.error}");
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.snapshot.value == null) {
                                    return Center(
                                      child: Text("No Customer Avaliable"),
                                    );
                                  } else {
                                    return Text("");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Reuseable_Button(
                  loading: false,
                  text: "Find Rides",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

class Professionals_Widget extends StatelessWidget {
   Professionals_Widget({
    required this.destination,
    required this.pickup,
    required this.offer,
    required this.onPressed,
    // required this.passengerName
  });
  // String passengerName;
  final offer;
  final destination;
  final pickup;
  final VoidCallback onPressed;

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: gphonenumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendMessage() async {

    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: gphonenumber,
      queryParameters: <String, String>{
        'body': Uri.encodeComponent('HelloSir!'),
      },
    );
    await launchUrl(smsLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          ListTile(
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  //fare price
                  "Rs: $offer",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _makePhoneCall();
                          },
                          child: Icon(
                            Icons.call,
                            color: Colors.black,
                            size: 20,
                          )),
                      GestureDetector(
                          onTap: () {
                            sendMessage();
                          },
                          child: Icon(
                            Icons.message,
                            color: Colors.white,
                            size: 20,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            // leading: Constant_Images.person,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //  "Name:${passengerName.toString()}",
                //   style: TextStyle(fontSize: 16),
                // ),
                Text("Pickup Location : $pickup"),
                Text("UserDestination:$destination"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  width: 0.3.sw,
                  height: 0.05.sh,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Center(
                          child: Text(
                        "Decline",
                      )),
                    ),
                  ),
                ),
                Container(
                  width: 0.3.sw,
                  height: 0.05.sh,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Accept",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
