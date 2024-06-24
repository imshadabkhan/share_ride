import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_ride/utils/toast_message.dart';
import 'package:share_ride/view/customer_module/customer_mapbox_view/services/places_search_services.dart';
import 'package:share_ride/view/customer_module/customer_request/controller/customer_request_controller.dart';
import 'package:share_ride/view/customer_module/customer_request/services/forward_geocoding.dart';
import 'package:share_ride/view/global_variable/global_variable.dart';
import 'package:share_ride/view/starting_module/authentication/widgets/custom_textfield.dart';
import 'package:share_ride/widgets/reuseable_button.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../starting_module/choose_account/choose_account.dart';
import '../../customer_mapbox_view/services/reverse_geocoding_service.dart';
import '../../customer_mapbox_view/view/customer_mapbox_view.dart';

class Customer_Module extends StatefulWidget {
  Customer_Module({super.key, this.placename});
  final placename;
  @override
  State<Customer_Module> createState() => _Customer_ModuleState();
}

class _Customer_ModuleState extends State<Customer_Module> {
  @override
  void initState() {
    // TODO: implement initState
    pickupDestination = widget.placename;
  }

  var pickupDestination;
  ForwardGeocoding forwardGeocoding = ForwardGeocoding();
  List<String> placeNames = [];
  TextEditingController _pickLocationController = TextEditingController();

  TextEditingController destinationController = TextEditingController();
  TextEditingController _offerController = TextEditingController();
  PlacesSearchServices placesSearchServices = PlacesSearchServices();
  bool locationPosition = false;
  bool destinationPosition = false;
  ToastMessage toastMessage = ToastMessage();
  // final databaseRef = FirebaseDatabase.instance.ref("UserCredentials");
  CustomerRequest_Controller customerRequest_Controller =
      CustomerRequest_Controller();
  var unique_Id = DateTime.now().millisecondsSinceEpoch.toString();
  var list;

  ReverseGeocodingService reverseGeocodingService = ReverseGeocodingService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(leading: InkWell(onTap:(){Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> Select_Account()));},child: Icon(Icons.arrow_back)),title: Text("Passenger Module"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              SizedBox(
                height: 50,
              ),
              Container(
                child: Column(
                  children: [
                    textField(
                      hintText: gpickupaddress,
                      keyboardType: TextInputType.text,
                      controller:
                          TextEditingController(text: pickupDestination),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             CustomerMapScreen()));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CustomerMapScreen(),
                          ),
                        ).then((selectedAddress) {
                          if (selectedAddress != null) {
                            customerRequest_Controller
                                .updatePickUpLocation(selectedAddress);
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Get Location on map"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: textField(
                  controller: destinationController,
                  hintText: "To where",
                  onChanged: (text) async {
                    if (text.isEmpty) {
                      setState(() {
                        placeNames = [];
                      });
                    } else {
                      try {
                        List<String> names = await placesSearchServices
                            .getSearchResultFromQueryUsingMapbox(text);
                        setState(() {
                          placeNames = names;
                        });
                      } catch (e) {
                        print("Error: $e");
                      }
                    }
                  },
                ),
              ),
              destinationController.text.isNotEmpty && placeNames.isNotEmpty
                  ? Container(
                      height: 100,
                      child: GestureDetector(
                          child: ListView.builder(
                            // Wrap in Expanded for better layout
                            itemCount: placeNames.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                  ),
                                  child: ListTile(
                                    title: AutoSizeText(
                                      placeNames.isEmpty
                                          ? "No Result Found"
                                          : list = placeNames[index],
                                      minFontSize: 8.0,
                                      maxFontSize: 12.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          onTap: () {
                            // Update text field content without argument
                            setState(() {
                              destinationController.text = placeNames.isNotEmpty
                                  ? list
                                  : " "; // Handle empty list case
                              placeNames = [];
                            });
                          }),
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              Container(
                child: textField(
                  controller: _offerController,
                  maxlength: 5,
                  keyboardType: TextInputType.number,
                  hintText: "Enter your offer",
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              SizedBox(
                height: height * .1,
              ),
              GestureDetector(
                onTap: () async {
                  if (destinationController.text.isNotEmpty &&
                      _offerController.text.isNotEmpty) {
                    customerRequest_Controller.sendRequest(
                        rideCompleted:false,
                        driverArriving: false,
                        destinationController: destinationController.text,
                        pickupController:
                            pickupDestination, //pickupdestination is stored in pickupDestination
                        offerController: _offerController.text,
                        uid: unique_Id);
                    final _coords = await forwardGeocoding
                        .getCoordinatesFromAddress(destinationController.text);
                    debugPrint('this is the coordination value ${_coords}');
                    Get.to(() => CustomerMapScreen(
                          destinationPoint: _coords,
                        ));
                  } else {
                    toastMessage.Toaster("All fields must be filled");
                  }
                },
                child: Obx(
                  () => Reuseable_Button(
                    loading: customerRequest_Controller.loading.value,
                    text: "Make A Request",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
