import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schaffen_assignment/UI/Authentication_Screen/login_screen.dart';
import 'package:schaffen_assignment/transition/page_transition_left.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    Navigator.pushReplacement(
      context,
      CustomPageTransitionLeft(
        child: Loginscreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 140.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120.h,
              width: 120.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/company_logo.png'),
                fit: BoxFit.cover,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
