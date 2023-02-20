import 'package:b/main.dart';
import 'package:b/underlined_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button.dart';
import 'custom_text.dart';

class Login extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().statusBarHeight),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 35.h, left: 30.w, right: 30.w),
                          child: CustomText(
                            text: "Log into your \naccount",
                            size: 30.sp,
                            color: Colors.black,
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.w700,
                            ls: 1.1,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset("images/login.jpeg", height: 350.h),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: UnderlinedInputField(
                            hint: "Email",
                            isPassword: false,
                            controller: email,
                            type: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: UnderlinedInputField(
                            hint: "Password",
                            isPassword: true,
                            controller: password,
                          ),
                        ),
                        SizedBox(height: 35),
                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: CustomText(
                              text: 'Forget Password',
                              size: 16.sp,
                              color: Colors.black,
                              fontFamily: 'Google',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Button(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LandingScreen()),
                                );
                              },
                              text: "Log In"),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 42.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => (){},
                    child: RichText(
                      text: TextSpan(
                          text: 'Don’t have an account?  ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontFamily: "Google",
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 17.sp,
                                color: Colors.black,
                                fontFamily: "Google",
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
