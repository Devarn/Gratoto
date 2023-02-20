import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class Button extends StatelessWidget {

  final Function onPressed;
  final String text;
  final Color ?color;

  const Button({Key? key, required this.onPressed, required this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: ()=> onPressed(),
        child: CustomText(
            text: text,
            size: 17.sp,
            color: Colors.white,
            fontFamily: "Ubuntu",
            fontWeight: FontWeight.w700),
      )
    );
  }
}