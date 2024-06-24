import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_ride/view/customer_module/customer_mapbox_view/services/destination_reverse_geocoding_service.dart';
import 'package:share_ride/view/customer_module/customer_mapbox_view/services/location_service.dart';
import 'package:share_ride/view/customer_module/customer_mapbox_view/services/reverse_geocoding_service.dart';
import 'package:share_ride/view/customer_module/customer_request/services/forward_geocoding.dart';
import 'package:share_ride/view/customer_module/customer_request/view/customer_request.dart';
import 'package:share_ride/view/global_variable/global_variable.dart';

import '../../../../widgets/reuseable_button.dart';
import '../../../starting_module/authentication/widgets/custom_textfield.dart';
import '../../customer_request/controller/customer_request_controller.dart';

class CustomerMapScreen extends StatefulWidget {
  CustomerMapScreen({this.destinationPoint});
  final destinationPoint;

  @override
  State<CustomerMapScreen> createState() => _CustomerMapScreenState();
}

class _CustomerMapScreenState extends State<CustomerMapScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location_Controller.getUsersCurrentLocation();

    _getCurrentLocation();
    destinationLocation = widget.destinationPoint;
  }

  final database_ref = FirebaseDatabase.instance.ref().child("SendRideRequest");
  ForwardGeocoding forwardGeocoding = ForwardGeocoding();
  final MapController controller = MapController();
  Location_Controller location_Controller = Location_Controller();
  LatLng? currentLocation; //store current location of driver
  late final destinationLocation;
  ReverseGeocodingService reverseGeocodingService = ReverseGeocodingService();
  DestinationReverseGeocodingService destinationReverseGeocodingService =
      DestinationReverseGeocodingService();
  bool functionNo1 = false;
  CustomerRequest_Controller customerRequest_Controller =
      CustomerRequest_Controller();

  TextEditingController textfield_searchlocation_Controller =
      TextEditingController(); //
  TextEditingController textfield_searchdestination_Controller =
      TextEditingController();
  bool showLoading = true;

//Geting user current location

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await location_Controller.getUsersCurrentLocation();
      final double latitude = locationData['latitude']!;
      final double longitude = locationData['longitude']!;
      setState(() {
        currentLocation = LatLng(latitude, longitude);
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future payNow() async {
    await LaunchApp.openApp(
        androidPackageName: 'com.techlogix.mobilinkcustomer',
        // iosUrlScheme: 'pulsesecure:'
        appStoreLink:
            'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
        openStore: false);
  }

  // void showAlertDialog(BuildContext context) async {
  //   final showLoading = ValueNotifier<bool>(true); // State for loading indicator
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return StreamBuilder<DatabaseEvent>(
  //           stream: database_ref.onValue, // Assuming database_ref is your Firebase stream
  //           builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               // Show indicator while waiting for data
  //               return Center(child: CircularProgressIndicator(color: Colors.blueGrey));
  //             } else {
  //               if (snapshot.hasData) {
  //                 if (snapshot.data!.snapshot.value != null) {
  //                   Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
  //                   bool driverArriving = data.containsKey('driverArriving') ? data['driverArriving'] as bool : true;
  //
  //                   showLoading.value = false; // Hide indicator once data is fetched
  //
  //                   return AlertDialog(
  //                     title: Text('Ride Status'),
  //                     content: driverArriving
  //                         ? Text('Driver is arriving.')
  //                         : Text('No driver assigned yet.'),
  //                     actions: [
  //                      driverArriving ? TextButton(
  //                         onPressed: ()async{
  //                           debugPrint("the data stored in data variable${data as String?} as String?");
  //                           // await LaunchApp.openApp(
  //                           //     androidPackageName: 'com.techlogix.mobilinkcustomer',
  //                           //     // iosUrlScheme: 'pulsesecure://',
  //                           //     // appStoreLink: 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
  //                           //     openStore: false
  //                           // );
  //
  //                         }, // Close dialog
  //                         child: Text('PayNow'),
  //                       ):
  //                       TextButton(
  //                         onPressed: () => Navigator.pop(context), // Close dialog
  //                         child: Text('OK'),
  //                       ),
  //                     ],
  //                   );
  //                 } else {
  //                   showLoading.value = false; // Hide indicator if no data
  //                   return AlertDialog(
  //                     title: Text('Error'),
  //                     content: Text('No data found in the database.'),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () => Navigator.pop(context), // Close dialog
  //                         child: Text('OK'),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               } else {
  //                 // Handle potential errors during data retrieval
  //                 return AlertDialog(
  //                   title: Text('Error'),
  //                   content: Text('An error occurred while fetching ride data.'),
  //                   actions: [
  //                     TextButton(
  //                       onPressed: () => Navigator.pop(context), // Close dialog
  //                       child: Text('OK'),
  //                     ),
  //                   ],
  //                 );
  //               }
  //             }
  //           });
  //     },
  //   );
  // }

  // void showAlertDialog(BuildContext context) async {
  //   final showLoading = ValueNotifier<bool>(true); // State for loading indicator
  //
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return StreamBuilder<DatabaseEvent>(
  //           stream: database_ref.onValue, // Assuming database_ref is your Firebase stream
  //           builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               // Show indicator while waiting for data
  //               return Center(child: CircularProgressIndicator(color: Colors.blueGrey));
  //             } else {
  //               if (snapshot.hasData) {
  //                 if (snapshot.data!.snapshot.value != null) {
  //                   Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
  //                   bool driverArriving = data.containsKey('driverArriving') ? data['driverArriving'] as bool : false;
  //                   showLoading.value = false; // Hide indicator once data is fetched
  //
  //                   return AlertDialog(
  //                     title: Text('Ride Status'),
  //                     content: driverArriving==true
  //                         ? Text('Driver is arriving.')
  //                         : Text('No driver avaliable yet.Look for Nearby BRT'),
  //                     actions: [
  //                       driverArriving==true
  //                           ? TextButton(
  //                         onPressed: () async {
  //                           // Handle PayNow functionality
  //                           debugPrint("The data stored in data variable: $driverArriving");
  //                           // Implement your payment logic here (assuming data contains relevant information)
  //                         },
  //                         child: Text('Pay Now'),
  //                       )
  //                           : TextButton(
  //                         onPressed: () => Navigator.pop(context), // Close dialog
  //                         child: Text('OK'),
  //                       ),
  //                     ],
  //                   );
  //                 } else {
  //                   showLoading.value = false; // Hide indicator if no data
  //                   return AlertDialog(
  //                     title: Text('Error'),
  //                     content: Text('No data found in the database.'),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () => Navigator.pop(context), // Close dialog
  //                         child: Text('OK'),
  //                       ),
  //                     ],
  //                   );
  //                 }
  //               } else {
  //                 // Handle potential errors during data retrieval
  //                 return AlertDialog(
  //                   title: Text('Error'),
  //                   content: Text('An error occurred while fetching ride data.'),
  //                   actions: [
  //                     TextButton(
  //                       onPressed: () => Navigator.pop(context), // Close dialog
  //                       child: Text('OK'),
  //                     ),
  //                   ],
  //                 );
  //               }
  //             }
  //           });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
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
                          Icons.gps_fixed,
                          color: Colors.blue,
                          size: 60,
                        ),
                      ),
                    if (destinationLocation != null)
                      Marker(
                        // point:destination ?? LatLng(33.99849, 71.48528),
                        point: destinationLocation,
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
                // Padding(
                //   padding: EdgeInsets.only(top: 0.05.sh, left: 20, right: 20),
                //   child: Column(
                //     children: [
                //       Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20.sp)),
                //         height: 0.09.sh,
                //         child: textField(
                //           controller: textfield_searchdestination_Controller,
                //             contentPadding: EdgeInsets.all(10),
                //             hintText: "Search location here",
                //             icon: Icon(Icons.location_on),
                //             suffixicon: GestureDetector(
                //                 onTap: (){
                //             //      _getCurrentLocation();
                //                 },
                //                 child: Icon(Icons.my_location)),
                //         ),
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20.sp)),
                //         height: 0.09.sh,
                //         child: textField(
                //           controller: textfield_searchdestination_Controller,
                //             contentPadding: EdgeInsets.all(10),
                //             hintText: "Search destination here",
                //             icon: Icon(Icons.location_on)),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: .9.sh, left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      var placename = await reverseGeocodingService
                          .getAddressFromCoordinates(currentLocation!.latitude,
                              currentLocation!.longitude);
                      if (destinationLocation == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Customer_Module(
                                      placename: placename,
                                    )));
                      }
                      if (destinationLocation != null)
                        Get.bottomSheet(
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            height: height * 1 / 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Finding Drivers",
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
                                          AsyncSnapshot<DatabaseEvent>
                                              snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data!.snapshot.value !=
                                                null) {
                                          Map<dynamic, dynamic> data = snapshot
                                              .data!
                                              .snapshot
                                              .value as Map<dynamic, dynamic>;

                                          // List<String> list = map.values
                                          //     .map((value) => value.toString())
                                          //     .toList();

                                          return ListView.builder(
                                            itemCount: 1,
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

                                                bool driverArriving =
                                                    rideRequestData[
                                                            'driverArriving']
                                                        as bool;
                                                bool rideCompleted =
                                                    rideRequestData[
                                                            'rideCompleted']
                                                        as bool;

                                                return Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          driverArriving
                                                              ? Text(
                                                                  rideCompleted
                                                                      ? "Ride Completed"
                                                                      : "BE READY! Driver Accepted your Request and He is Arriving,Your journey will start please wait and join a ride,thanks!",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "No Nearby Driver Avaliable Look For Nearby BRT Station",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          rideCompleted
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          payNow();
                                                                        },
                                                                        child: Text(
                                                                            "Pay 0nline")),
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.to(
                                                                              Customer_Module());
                                                                        },
                                                                        child: Text(
                                                                            "Pay Cash")),
                                                                  ],
                                                                )
                                                              : ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "Done"),
                                                                ),
                                                        ],
                                                      ),
                                                    ));
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
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text("Error${snapshot.error}");
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.snapshot.value ==
                                                null) {
                                          return Center(
                                            child:
                                                Text("No Customer Avaliable"),
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
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 48,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(
                        destinationLocation == null ? "Done" : "Find Ride",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ), //Done button at last
                  ),
                ), //Done button at last
              ],
            ),
        ],
      ),
    );
  }
}

//TODO show the user location and destionation location with polyline on map.
//TODO WHEN THE DRIVERS ACCEPT REQUEST SHOW ON CUSTOMER MAP THE RIDER IS COMING WHEN HE ARRIVES SHOW DRIVER IS ARRIVE WHEN RIDE COMPLETE SHOW RIDE COMPLETED
//TODO AFTER THE RIDE COMPLETION SHOW PAYMENT THROUGH JAZZ CASH
