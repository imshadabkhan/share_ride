import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
import '../starting_module/authentication/widgets/custom_textfield.dart';

class Driver_Map_View extends StatefulWidget {
  Driver_Map_View({Key? key}) : super(key: key);
  @override
  State<Driver_Map_View> createState() => _Driver_Map_ViewState();
}

class _Driver_Map_ViewState extends State<Driver_Map_View> {
  final databaseref =
      FirebaseDatabase.instance.ref("UserCredentials").child("userInfo");
  late GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: LatLng(34.006960, 71.533060), zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
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
                            // Expanded(
                            //   child: StreamBuilder(
                            //       stream: databaseref.onValue,
                            //       builder: (context,
                            //           AsyncSnapshot<DatabaseEvent> snapshot) {
                            //         return ListView.builder(
                            //             itemCount: snapshot
                            //                 .data!.snapshot.children.length,
                            //             itemBuilder: (context, index) {
                            //               if (snapshot.hasData && snapshot.data!.snapshot.value !=null) {
                            //                 Map<dynamic, dynamic> map = snapshot
                            //                     .data!
                            //                     .snapshot
                            //                     .value as dynamic;
                            //                 List list =   map.values.toList();
                            //
                            //
                            //                 return Padding(
                            //                   padding: EdgeInsets.all(8.0),
                            //                   child: Container(
                            //                     height: 150,
                            //                     decoration: BoxDecoration(
                            //                         color: Colors.grey,
                            //                         borderRadius:
                            //                             BorderRadius.circular(
                            //                                 20)),
                            //                     child: ListTile(
                            //                       title: Text(
                            //                           list[index]['username']),
                            //                       // subtitle:
                            //                       //     Text(list[index]['phoneNo']),
                            //                     ),
                            //                   ),
                            //                 );
                            //               } else {
                            //                 return Container(
                            //                   child: Center(
                            //                     child:
                            //                         CircularProgressIndicator(),
                            //                   ),
                            //                 );
                            //               }
                            //             });
                            //       }),
                            // ),

                            Expanded(
                              child: StreamBuilder(
                                stream: databaseref.onValue,
                                builder: (context,
                                    AsyncSnapshot<DatabaseEvent> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.snapshot.value != null) {
                                    Map<dynamic, dynamic> map = snapshot
                                        .data!.snapshot.value as dynamic;
                                    debugPrint(
                                        "maap value" + map.values.toString());
                                    List list = map.values.toList();
                                    debugPrint(
                                        'list values >> ,${list.toString()}');
                                    print("Snapshot data: ${snapshot.data!.snapshot.value}");
                                    print("List values: ${list.toString()}");
                                    return ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ListTile(
                                              title:
                                                  Text(list[0]['userName']),
                                              subtitle:
                                                  Text(list[1]['phoneNo']),
                                              // subtitle: Text(list[index]['phoneNo']),
                                            ),
                                          ),
                                        );
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
          Padding(
            padding: EdgeInsets.only(top: 0.05.sh, left: 20, right: 20),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.sp)),
              height: 0.09.sh,
              child: textField(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search here",
                  icon: Icon(Icons.location_on)),
            ),
          ),
        ],
      ),
    );
  }
}
