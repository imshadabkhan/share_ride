import 'package:flutter/material.dart';
import 'package:share_ride/constants/screensizes_constant.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share_ride/view/starting_module/starting/splash_screen.dart';
import 'firebase_services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSizesConstants.init(context);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Splash_View(),
      home: Splash_View(),
    );
  }
}
