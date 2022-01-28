import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? name;
  String? email;
  String? phonenumber;
  String? address;

  getDetails() async {
    await _firestore
        .collection("usersInfo")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        name = value['name'];
        email = value['email'];
        phonenumber = value['phone'];
        address = value['address'];
      });
    }).catchError((error) {
      const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
      print("Failed to update details: $error");
    });
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 25.h,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _auth.signOut();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black87,
                          size: 16.h,
                        ),
                      ),
                      SizedBox(width: 70.w),
                      Text(
                        "My Profile",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 22.w,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black54,
                          size: 20.h,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage('assets/profile_photo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Text(
                        name!,
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 30.w,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 18.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        email!,
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number",
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 18.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        phonenumber!,
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 18.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        address!,
                        style: GoogleFonts.sourceSansPro(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 120.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 100.w,
                  ),
                  child: InkWell(
                    splashColor: Colors.pink,
                    onTap: () {
                      _auth.signOut();
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
                          "Log Out",
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
                ),
              ],
            ),
    );
  }
}
