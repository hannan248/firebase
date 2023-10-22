import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/views/home_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Text"),
      ),
      body: Column(children: [
        TextFormField(
          controller: editingController
            ..text = " ${Get.arguments['note'].toString()}",
          maxLength: null,
          decoration: const InputDecoration(hintText: 'Update'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('notes')
                  .doc(Get.arguments['docId'].toString())
                  .update({
                'note':editingController.text.trim(),
              });
              Get.to(()=>const HomeScreen());
            },
            child: const Text("Update"))
      ]),
    );
  }
}
