import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note/views/forgot_password.dart';
import 'package:note/views/home_screen.dart';
import 'package:note/views/sign_upScreen.dart';

class LognInScreen extends StatefulWidget {
  const LognInScreen({super.key});

  @override
  State<LognInScreen> createState() => _LognInScreenState();
}

class _LognInScreenState extends State<LognInScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loginEmailController = TextEditingController();
    TextEditingController loginPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Logn In'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginEmailController,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: loginPasswordController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(Icons.visibility),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  var loginEmail = loginEmailController.text.trim();
                  var loginPassword = loginPasswordController.text.trim();
                  try {
                    final User? firebaseUser = ( await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: loginEmail, password: loginPassword)).user;
                    if(firebaseUser!=null){
                      Get.to(()=>const HomeScreen());
                    }else{
                      print("check email and password");
                    }
                  } on FirebaseAuthException catch (e) {
                    print("error $e");
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPasswordScreen());
                  },
                  child: const Text('Forget Password')),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const SignUpScreen());
                  },
                  child: const Text("Don't have Account Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}
