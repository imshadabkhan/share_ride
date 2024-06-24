import 'package:flutter/cupertino.dart';

class ScreenSizesConstants {
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  static init(BuildContext context) {
    MediaQuery.sizeOf(context).height;
    MediaQuery.sizeOf(context).width;
  }
}
