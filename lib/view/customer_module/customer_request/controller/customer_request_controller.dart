
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../utils/toast_message.dart';


class CustomerRequest_Controller extends GetxController {
 // ForwardGeocoding forwardGeocoding=ForwardGeocoding();

  RxBool loading = false.obs;
  ToastMessage toastMessage = ToastMessage();

  void sendRequest(
      {final destinationController,
      final pickupController,
      final offerController,
        required bool driverArriving,
        required bool rideCompleted,
      var uid}) {
    //uplaod data on firebase_realtime_database//

    try {
      loading.value = true;
      final database_ref = FirebaseDatabase.instance
          .ref()
          .child("SendRideRequest")
          .child("${uid}");
      database_ref.set({
        'Destination': destinationController.toString(),
        'Pickup': pickupController.toString(),
        'offer': offerController.toString(),
        'uid':uid,
        'driverArriving':false,
        'rideCompleted':false,
      });


      loading.value = false;
    } catch (error) {
      toastMessage.Toaster(error.toString());
      loading.value = false;
    }
  }

  // Future getCoordinates(String pickAddress)async{
  //   return forwardGeocoding.getCoordinatesFromAddress(pickAddress);

  final pickUpLocation = ''.obs;

  Future<void> updatePickUpLocation(String newLocation) async {
    pickUpLocation.value = newLocation;
    // Additional logic like saving location to database (if needed)
  }


  }





