import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/views/home_screen.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key});

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  TextEditingController noteController=TextEditingController();
  User? userId=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New Note'),
      ),
      body:
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical:10 ),
        child: Column(
          children: [
            TextFormField(
              controller:noteController,
              maxLength: null,
              decoration: const InputDecoration(hintText: 'Add Note'),
            ),
            const SizedBox(height:20),
            ElevatedButton(onPressed: ()async{
              var note =noteController.text.trim();
              if(note!=''){
                try{
                await  FirebaseFirestore.instance.collection('notes').doc().set({
                    "created at date":DateTime.now(),
                    "note":note,
                    "userId":userId!.uid,
                  });
                } catch(e){
                  print('Error $e');
                }
              }
              Get.to(()=>const HomeScreen());

            }, child: const Text("Save")),
          ],
        ),
      )
    );
  }
}
