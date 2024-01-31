import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:share_ride/widgets/reuseable_button.dart';

import '../starting_module/authentication/widgets/custom_textfield.dart';

class Driver_Map_View extends StatefulWidget {
  const Driver_Map_View({Key? key}) : super(key: key);

  @override
  State<Driver_Map_View> createState() => _Driver_Map_ViewState();
}

class _Driver_Map_ViewState extends State<Driver_Map_View> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Reuseable_Button(text: "Save Location",),
          GoogleMap(
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: LatLng(24.633333, 46.716667), zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          Padding(
            padding:  EdgeInsets.only(top: 0.05.sh,left: 20,right: 20),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.sp)),
              height: 0.09.sh,
              child: textField(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search here",
                  icon: Icon(Icons.location_on)

              ),),
          ),
        ],
      ),
    );
  }
}
