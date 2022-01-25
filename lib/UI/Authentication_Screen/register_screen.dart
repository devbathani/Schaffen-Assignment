import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schaffen_assignment/TRANSITION/page_transition_left.dart';
import 'package:schaffen_assignment/UI/Authentication_Screen/login_screen.dart';

class Registerscreen extends StatefulWidget {
  Registerscreen({Key? key}) : super(key: key);

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen>
    with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phonenumber = TextEditingController();

  TextEditingController address = TextEditingController();
  late AnimationController animationController;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
            FadeTransition(
              opacity: animationController,
              child: SvgPicture.asset(
                'assets/signup.svg',
                height: 120.h,
                width: 180.w,
                fit: BoxFit.cover,
              ),
            ),
            FadeTransition(
              opacity: animationController,
              child: Container(
                height: 500.h,
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
                            "Create",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 27.w,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Account",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 27.w,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Form(
                      key: _form,
                      child: Column(
                        children: [
                          FadeTransition(
                            opacity: animationController,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.5, 0),
                                end: const Offset(0, 0),
                              ).animate(animationController),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name is required";
                                    }
                                  },
                                  controller: name,
                                  keyboardType: TextInputType.name,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5.w,
                                    ),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorMaxLines: 2,
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
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
                                    labelText: 'Name',
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          FadeTransition(
                            opacity: animationController,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.5, 0),
                                end: const Offset(0, 0),
                              ).animate(animationController),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email is required";
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return 'Please enter a valid Email';
                                    }
                                    return null;
                                  },
                                  controller: email,
                                  keyboardType: TextInputType.name,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5.w,
                                    ),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorMaxLines: 2,
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.grey,
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
                                    labelText: 'Email',
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          FadeTransition(
                            opacity: animationController,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.5, 0),
                                end: const Offset(0, 0),
                              ).animate(animationController),
                              child: Padding(
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
                                      fontSize: 15.5.w,
                                    ),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorMaxLines: 2,
                                    prefixText: '+91',
                                    prefixIcon: const Icon(
                                      Icons.phone_android,
                                      color: Colors.grey,
                                    ),
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
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          FadeTransition(
                            opacity: animationController,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.5, 0),
                                end: const Offset(0, 0),
                              ).animate(animationController),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Address is required";
                                    }
                                  },
                                  controller: address,
                                  keyboardType: TextInputType.name,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5.w,
                                    ),
                                  ),
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorMaxLines: 2,
                                    prefixIcon: const Icon(
                                      Icons.directions,
                                      color: Colors.grey,
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
                                    labelText: 'Address',
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
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
                            "Register",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Account already registered",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 13.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageTransitionLeft(
                                child: Loginscreen(),
                              ),
                            );
                          },
                          child: Text(
                            "LogIn",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 13.w,
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
            ),
          ],
        ),
      ),
    );
  }
}
