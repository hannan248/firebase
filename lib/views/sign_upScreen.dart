
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/services/signup_services.dart';
import 'package:note/views/sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController userPasswordController = TextEditingController();
    User? currentUser=FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.center,
              //   height: 200,
              //   child: Lottie.file('assets/Animation - 1697346931068 (1).json'),
              // ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.person),
                      hintText: 'User Name',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.phone),
                      hintText: 'Phone',
                      enabledBorder: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: emailController,
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
                  controller: userPasswordController,
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
                  var userName = userNameController.text.trim();
                  var phone = phoneController.text.trim();
                  var userEmail = emailController.text.trim();
                  var userPassword = userPasswordController.text.trim();
                await  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword)
                      .then((value) => {print('user created'),
                  signUpUser(userName,phone,userEmail,userPassword),

                  });
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => const LognInScreen());
                  },
                  child: const Text('Already have Account'))
            ],
          ),
        ),
      ),
    );
  }
}
