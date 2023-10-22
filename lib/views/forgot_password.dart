import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note/views/sign_in.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // // Container(
              //   alignment:Alignment.center,
              //   height: 200,
              //   child:Lottie.file('assets/Animation - 1697346931068 (1).json'),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: forgetEmailController,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  var forgetEmail = forgetEmailController.text.trim();
                  try {
                   await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: forgetEmail).then((value) =>
                    {
                    print('Email send!'),
                      print(forgetEmail),
                      Get.off(()=>const LognInScreen())
                    }
                    );
                  } on FirebaseAuthException catch (e) {
                    print('error $e');
                  }
                },
                child: const Text('Forgot Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
