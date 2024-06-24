import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_ride/view/customer_module/customer_request/view/customer_request.dart';
import 'package:share_ride/view/driver_module/driver_mapbox_view/view/driver_map_box_view.dart';
import 'package:share_ride/view/starting_module/choose_account/controller/chooseaccount_controller.dart';

import '../../../../../utils/toast_message.dart';
import '../../../choose_account/choose_account.dart';

class Signup_Controller extends GetxController {
  final ChooseAccountController chooseAccountController = Get.find<ChooseAccountController>();
  var currentSignupUserId;
  RxString currentUserName = RxString("");
  ToastMessage toastMessage = ToastMessage();
  RxBool loading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void createUser(var _emailController, var _passwordController,
      var _usernameController, var _phonenoController) async {
    //Create/signUp user with email and password with unique id//

    try {
      loading.value = true;
      final User? userFirebase = (await _auth.createUserWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passwordController.text.toString()))
          .user;

      //Store User info in RealTime database//
      final databaseref = FirebaseDatabase.instance
          .ref()
          .child("Users").child("Passengers")
          .child(userFirebase!.uid);




      currentSignupUserId = userFirebase!.uid;
      currentUserName.value = _usernameController.text.toString();


      await databaseref.set({
        "username": _usernameController.text.toString(),
        "phoneno": _phonenoController.text.toString(),
        "email": _emailController.text.toString(),
        "password": _passwordController.text.toString(),
        "uniqueId":userFirebase.uid,

      });

      //Navigate to other screen after these functions//
      Get.to(() => Customer_Module());
      loading.value = false;
    } catch (error) {
      toastMessage.Toaster(error.toString());
      loading.value = false;
    }

  }

  Future createDriver(var _emailController, var _passwordController,var _usernameController, var _phonenoController,var carNumberController,var nicController,var carRegistrationController,)async{
    var UniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    final databaseref = FirebaseDatabase.instance
        .ref()
        .child("Users").child("Drivers").child(UniqueId);
    await databaseref.set({
      "username": _usernameController.text.toString(),
      "phoneno": _phonenoController.text.toString(),
      "email": _emailController.text.toString(),
      "password": _passwordController.text.toString(),
      "car number":carNumberController.text.toString(),
      "nic":nicController.text.toString(),
      "carRegistration":carRegistrationController.text.toString(),
      "uID":UniqueId

    });
    Get.to(() => DriverMapScreen());
  }




}
