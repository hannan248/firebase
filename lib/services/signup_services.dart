import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../views/sign_in.dart';

signUpUser(String userName, String phone, String userEmail,
    String userPassword) async {
  User? userid = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("user").doc().set({
      "userName": userName,
      "userPhone": phone,
      "userEmail": userEmail,
      "Date": DateTime.now(),
      "UserId": userid!.uid,
    }).then((value) => {
          FirebaseAuth.instance.signOut(),
          Get.to(() => const LognInScreen()),
        });
  } on FirebaseAuthException catch (e) {
    print("error $e");
  }
}
