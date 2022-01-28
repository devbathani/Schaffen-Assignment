import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:schaffen_assignment/Database/DatabaseManager.dart';
import 'package:schaffen_assignment/TRANSITION/page_transition_left.dart';
import 'package:schaffen_assignment/UI/home_screen.dart';
import 'package:schaffen_assignment/UI/Authentication_Screen/login_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class Registerscreen extends StatefulWidget {
  const Registerscreen({Key? key}) : super(key: key);

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen>
    with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  TextEditingController address = TextEditingController();
  late AnimationController animationController;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String verificationId;
  bool showLoading = false;

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  getRegisterationForm(context) {
    final registerprovider =
        Provider.of<DatabaseManager>(context, listen: false);
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
          registerprovider.addUserInfo(
            name.text,
            email.text,
            phoneController.text,
            address.text,
            authCredential.user!.uid,
          );
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
                              child: const Loginscreen(),
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
    );
  }

  getRegisterOtp(context) {
    final registerprovider =
        Provider.of<DatabaseManager>(context, listen: false);
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
          registerprovider.addUserInfo(
            name.text,
            email.text,
            phoneController.text,
            address.text,
            authCredential.user!.uid,
          );
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

    SingleChildScrollView(
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
                  SizedBox(
                    height: 10.h,
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
                              child: const Loginscreen(),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ? getRegisterationForm(context)
              : getRegisterOtp(context),
    );
  }
}
