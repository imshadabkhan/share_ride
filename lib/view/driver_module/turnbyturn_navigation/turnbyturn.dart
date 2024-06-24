
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:latlong2/latlong.dart';

import '../driver_mapbox_view/view/driver_map_box_view.dart';

class TurnByTurn extends StatefulWidget {
  TurnByTurn({required this.uniqueID,required this.driverLocation,required this.destinationLocation,required this.passengerLocation});
  LatLng? driverLocation;
  LatLng? destinationLocation;
   LatLng? passengerLocation;
   var uniqueID;
  final database_ref = FirebaseDatabase.instance.ref().child("SendRideRequest");
  // LatLng?

  @override
  State<TurnByTurn> createState() => _TurnByTurnState();
}

class _TurnByTurnState extends State<TurnByTurn> {
  final database_ref = FirebaseDatabase.instance.ref().child("SendRideRequest");
  @override
  void initState() {
    super.initState();
    source= widget.driverLocation;
    finalDestination=widget.destinationLocation;
     pickupdestination=widget.passengerLocation;
     uID=widget.uniqueID;
    // pickupdestination=widget.driverLocation;
    initialize();
  }
  // Waypoints to mark trip start and end

 // LatLng(33.9984,  71.5391) source
  var uID;
  LatLng? source;             //here the driver live location will be stored
  LatLng? pickupdestination;
  // = LatLng(34.00309,  71.50174);       //here the passenger location will be stored
  LatLng? finalDestination;
  // =LatLng(33.99849, 71.48528);         //here the destination location of passenger will be stored
   late WayPoint sourceWaypoint, pickupdestinationWaypoint,finalDestinationWaypoint;
  var wayPoints = <WayPoint>[];

  // Config variables for Mapbox Navigation
  late MapBoxNavigation directions;
  late MapBoxOptions _options;
  late double distanceRemaining, durationRemaining;
  late MapBoxNavigationViewController _controller;
  final bool isMultipleStop = true;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;





  Future<void> initialize() async {
    if (!mounted) return;

    // Setup directions and options
    directions = MapBoxNavigation();


    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: true,
        language: "en");

    // Configure waypoints
    sourceWaypoint = WayPoint(
        name: "Source", latitude: source!.latitude, longitude: source!.longitude);
    pickupdestinationWaypoint = WayPoint(
        name: "PickupDestination",
        latitude: pickupdestination!.latitude,
        longitude: pickupdestination!.longitude);
    finalDestinationWaypoint = WayPoint(name: "FinalDestination", latitude: finalDestination!.latitude, longitude: finalDestination!.longitude);
    wayPoints.add(sourceWaypoint);
    wayPoints.add(pickupdestinationWaypoint);
    wayPoints.add(finalDestinationWaypoint);

    // Start the trip
    await directions.startNavigation(wayPoints: wayPoints, options: _options);

  }

  Future<void> _onRouteEvent(e) async {
    //distanceRemaining = await directions.distanceRemaining;
    // durationRemaining = await directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }

  Future updateValue(String uniqueId) async {

    await database_ref.child(uniqueId).update({
      "rideCompleted": true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
      AlertDialog(
        title: Text("Ride Completed"),
        content: Text("Please confirm a payment from passenger"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Call the onConfirm callback passed from outside
              updateValue(uID);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DriverMapScreen()),
              );
              // Close the dialog
            },
            child: Text('Ride Completed'),
          ),
        ],

      ),


    ],),);









    // return Scaffold(body: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Visibility(
    //       visible:arrived ,
    //       child: AlertDialog(
    //         title: Text('Ride Completed'),
    //         content: Text('Please confirm a payment from passenger'),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: (){
    //               // Call the onConfirm callback passed from outside
    //
    //               Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(builder: (context) => DriverMapScreen()),
    //               );
    //               //Close the dialog
    //             },
    //             child: Text('Confirm'),
    //           ),
    //         ],
    //       ),
    //     ),
    //
    //     Visibility(
    //       visible: !isNavigating, // Show when not arrived and not navigating
    //       child: AlertDialog(
    //         title: Text('Ride Canceled'),
    //         content: Text('You have canceled the ride'),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               // Navigate to MapScreen
    //               Get.off(() => DriverMapScreen());
    //             },
    //             child: Text('Confirm'),
    //           ),
    //         ],
    //       ),),
    //
    //   ],
    // ) ,);
    return DriverMapScreen();



  }

}
