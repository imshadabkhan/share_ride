import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController{
  final database_passenger=FirebaseDatabase.instance.ref().child("Users").child("Passengers");
  getUserName(){



  }




}