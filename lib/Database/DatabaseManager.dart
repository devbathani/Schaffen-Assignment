import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseManager extends ChangeNotifier {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('usersInfo');

  Future<void> addUserInfo(
    String name,
    String email,
    String phone,
    String address,
    String uid,
  ) async {
    return await _collection.doc(uid).set(
      {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      },
    ).then((value) => print("User registered"));
  }
}
