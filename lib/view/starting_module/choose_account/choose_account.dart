import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:share_ride/constants/constant_color.dart';
import 'package:share_ride/widgets/primary_button.dart';
import '../../customer_module/customer_module.dart';
import '../../driver_module/driver_module_put_location.dart';

class Select_Account extends StatefulWidget {
  Select_Account({super.key});
  @override
  State<Select_Account> createState() => _Select_AccountState();
}

class _Select_AccountState extends State<Select_Account> {
  bool status1 = false;
  bool status2 = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.09.sh),
            Center(child: Container(
                height: 60,
                child: Image(image: AssetImage("assets/images/logo.png"),))),
            SizedBox(height: 0.03.sh),
            Center(
              child: Text(
                "Choose Account Type",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp),
                maxLines: 2,
              ),
            ),

            Center(
              child: Text(
                "Choosing your role will customize the app experience based on your specific needs",
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 0.05.sh),
            Row(
              children: [
                Unfocused_Box(
                  onTap: () {


                    setState(() { status1 = true;
                    if (status1 == true) {
                      status2 = false;
                    }});
                  },
                  border: status1 == false
                      ? Border.all(
                          color: Constant_Colors.account_type_box_color,
                          width: 1)
                      : Border.all(
                          color: Constant_Colors.secondarycolor, width: 2),
                  image: status1 == false
                      ? Image(
                          image: AssetImage("assets/images/driver.png"),
                          height: MediaQuery.sizeOf(context).height * .1 / 2,
                          width: MediaQuery.sizeOf(context).width,
                        )
                      : Image(
                          image: AssetImage("assets/images/driver.png"),
                          height: MediaQuery.sizeOf(context).height * .1 / 2,
                          width: MediaQuery.sizeOf(context).width,
                          color: Constant_Colors.secondarycolor,
                        ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Unfocused_Box(
                  onTap: () {


                    setState(() { status2 = true;

                    if (status2 == true) {
                      status1 = false;
                    }});
                  },
                  image: status2 == false
                      ? Image(
                          image: AssetImage("assets/images/passenger.png"),
                          height: MediaQuery.sizeOf(context).height * .1,
                          width: MediaQuery.sizeOf(context).width,
                        )
                      : Image(
                          image: AssetImage("assets/images/passenger.png"),
                          height: MediaQuery.sizeOf(context).height * .1,
                          width: MediaQuery.sizeOf(context).width,
                          color: Constant_Colors.secondarycolor,
                        ),
                  border: status2 == false
                      ? Border.all(
                          color: Constant_Colors.account_type_box_color,
                          width: 1)
                      : Border.all(
                          color: Constant_Colors.secondarycolor, width: 2),
                ),
              ],
            ),

            SizedBox(
              height: 0.08.sh,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Primary_Btn(
                    color: status1 || status2 == true
                        ? Constant_Colors.secondarycolor
                        : Constant_Colors.disable_btn,
                    title: Text("Next"),
                    onTap: () {
                      status1 || status2 == true
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => status2 == true
                                    ? Customer_Module()
                                    : Driver_Module(),
                              ),
                            )
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Unfocused_Box extends StatelessWidget {
  Unfocused_Box({
    required this.image,
    required this.onTap,
    required this.border,
  });

  Image image;
  Border border;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 0.2.sh,
          decoration: BoxDecoration(
              border: border,
              color: Constant_Colors.account_type_box_color,
              borderRadius: BorderRadius.circular(10)),
          child: image,
        ),
      ),
    );
  }
}
