import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Primary_Btn extends StatelessWidget {
  Primary_Btn({

    this.icon,this.title,  this.onTap,this.color,
  });
  var title;
  var icon;
  var color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(

        height: 0.07.sh,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color),
        child: Center(
          child:title,

        ),
      ),
    );
  }
}