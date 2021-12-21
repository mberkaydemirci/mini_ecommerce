import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/helpers/common.dart';
import 'package:mini_ecommerce/model/user_model.dart';
import 'package:mini_ecommerce/screens/login_page.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "users";
  String collection = "users";

  void createUser(Map<String, dynamic> data) {
    try {
      _firestore.collection(collection).doc(data["uid"]).set(data);
      print("USER WAS CREATED");
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        print("==========id is $id=============");
        return UserModel.fromSnapshot(doc);
      });

  SignOut(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    changeScreen(context, LoginPage());
    return await firebaseAuth.signOut();
  }
}
