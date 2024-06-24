import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_ride/utils/toast_message.dart';
import 'package:share_ride/view/customer_module/customer_request/view/customer_request.dart';
import 'package:share_ride/view/driver_module/driver_mapbox_view/view/driver_map_box_view.dart';
import 'package:share_ride/view/global_variable/global_variable.dart';
import 'package:share_ride/view/starting_module/choose_account/choose_account.dart';
import 'package:share_ride/view/starting_module/choose_account/controller/chooseaccount_controller.dart';

class LoginController extends GetxController {
  ChooseAccountController chooseAccountController=Get.find<ChooseAccountController>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  ToastMessage toastMessage = ToastMessage();

  RxBool loading = false.obs;

  void Login(var _emailController, var _passwordController) async {
    try {
      loading.value = true;
      final User? userFirebase = (await _auth.signInWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passwordController.text.toString()))
          .user;
      //getting username and assigning it to global variable
      final databaseref = FirebaseDatabase.instance
          .ref()
          .child("Users")
          .child(userFirebase!.uid);
      databaseref.once().then((snap) {
        if (snap.snapshot.value != null) {
          gname = (snap.snapshot.value as Map)['username'];
          gphonenumber = (snap.snapshot.value as Map)['phoneno'];
        }
        debugPrint(gname.toString());
        debugPrint(gphonenumber.toString());
      });

      Get.to(() => chooseAccountController.status1.value ? DriverMapScreen() : Customer_Module());
    } catch (error) {
      loading.value = false;
      toastMessage.Toaster(error.toString());
    }
  }
}

