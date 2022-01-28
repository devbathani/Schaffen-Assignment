import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schaffen_assignment/Database/DatabaseManager.dart';
import 'package:schaffen_assignment/TRANSITION/page_transition.dart';
import 'package:schaffen_assignment/UI/home_screen.dart';
import 'package:schaffen_assignment/UI/Authentication_Screen/register_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;
  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
        backgroundColor: Colors.red,
      ));
      print(e.message);
    }
  }

  getMobileFormWidget(context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          FadeTransition(
            opacity: animationController,
            child: SvgPicture.asset(
              'assets/login.svg',
              height: 180.h,
              width: 220.w,
              fit: BoxFit.cover,
            ),
          ),
          FadeTransition(
            opacity: animationController,
            child: Container(
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
                  Form(
                    key: _form,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: const Offset(0, 0),
                      ).animate(animationController),
                      child: FadeTransition(
                        opacity: animationController,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: TextFormField(
                            maxLength: 10,
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
                            controller: phoneController,
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
                              prefixIcon: const Icon(
                                Icons.phone_android,
                                color: Colors.grey,
                              ),
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  InkWell(
                    splashColor: Colors.pink,
                    onTap: () async {
                      setState(() {
                        showLoading = true;
                      });

                      await _auth.verifyPhoneNumber(
                          phoneNumber: '+91' + phoneController.text,
                          verificationCompleted: (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                            signInWithPhoneAuthCredential(phoneAuthCredential);
                          },
                          verificationFailed: (verificationFailed) async {
                            setState(() {
                              showLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(verificationFailed.message!),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          },
                          codeSent: (verificationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentState =
                                  MobileVerificationState.SHOW_OTP_FORM_STATE;
                              this.verificationId = verificationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async {});
                    },
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
                    height: 70.h,
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
                            CustomPageTransition(
                              child: Registerscreen(),
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
          ),
        ],
      ),
    );
  }

  getOtpFormWidget(context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          FadeTransition(
            opacity: animationController,
            child: SvgPicture.asset(
              'assets/login.svg',
              height: 180.h,
              width: 220.w,
              fit: BoxFit.cover,
            ),
          ),
          FadeTransition(
            opacity: animationController,
            child: Container(
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
                  Form(
                    key: _form,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: const Offset(0, 0),
                      ).animate(animationController),
                      child: FadeTransition(
                        opacity: animationController,
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
                            controller: otpController,
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
                              prefixIcon: const Icon(
                                Icons.phone_android,
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
                              labelText: 'OTP',
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
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  InkWell(
                    splashColor: Colors.pink,
                    onTap: () {
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: otpController.text,
                      );

                      signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                    child: Container(
                      height: 50.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: Center(
                        child: Text(
                          "Verify",
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
                    height: 70.h,
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
                            CustomPageTransition(
                              child: Registerscreen(),
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
          ),
        ],
      ),
    );
  }

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: showLoading
          ? SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  FadeTransition(
                    opacity: animationController,
                    child: SvgPicture.asset(
                      'assets/login.svg',
                      height: 180.h,
                      width: 220.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  FadeTransition(
                    opacity: animationController,
                    child: Container(
                      height: 440.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xfff2f2f2),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35.w),
                          topLeft: Radius.circular(35.w),
                        ),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
    );
  }
}
