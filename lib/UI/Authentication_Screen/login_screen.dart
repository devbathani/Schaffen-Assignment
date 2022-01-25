import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schaffen_assignment/UI/Authentication_Screen/register_screen.dart';
import 'package:schaffen_assignment/transition/page_transition_down.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({Key? key}) : super(key: key);

  TextEditingController phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
              height: 70.h,
            ),
            SvgPicture.asset(
              'assets/login.svg',
              height: 180.h,
              width: 220.w,
              fit: BoxFit.cover,
            ),
            Container(
              height: 440.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35.w),
                  topLeft: Radius.circular(35.w),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 30.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "In",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 30.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please a phone number";
                        }
                        if (value == toString()) {
                          return "Enter a valid number";
                        }
                        if (value.length < 10) {
                          return "Enter a valid number";
                        }
                      },
                      controller: phonenumber,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.5.w),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorMaxLines: 2,
                        prefixText: '+91',
                        prefixStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.5.w),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.w,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          ),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.w,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20.w),
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  InkWell(
                    splashColor: Colors.pink,
                    onTap: () {},
                    child: Container(
                      height: 50.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: Center(
                        child: Text(
                          "Get OTP",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 75.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New User Register ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageTransitionDown(
                              child: const Registerscreen(),
                            ),
                          );
                        },
                        child: Text(
                          "here",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 15.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
