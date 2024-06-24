import 'package:get/get.dart';

class ChooseAccountController extends GetxController{
  RxBool status1 = false.obs;
  RxBool status2 = false.obs;

  updateBoxOne(){


     status1.value = true;
    if (status1.value == true) {
      status2.value = false;
    }


  }
  updateBoxTwo(){

      status2.value = true;

      if (status2.value == true) {
        status1.value = false;
      }



  }







}