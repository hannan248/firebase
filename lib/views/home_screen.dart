import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/views/editscreen.dart';
import 'package:note/views/new_note_screen.dart';
import 'package:note/views/sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    User? userId = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen '),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.to(() => const LognInScreen());
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notes").where(
              "userId", isEqualTo: userId!.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something Went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No data Found!'));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(title: Text(
                          snapshot.data!.docs[index]['note'],),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: () {
                                Get.to(() => const EditScreen(),
                                    arguments: {
                                      "note": snapshot.data!
                                          .docs[index]['note'],
                                      "docId": snapshot.data!.docs[index].id,
                                    }
                                );
                              }, icon: const Icon(Icons.edit),),
                              const SizedBox(width: 10.0,),
                              IconButton(onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("notes")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              }, icon: const Icon(Icons.delete)),
                            ],
                          ),
                        )
                    );
                  });
            }
            return Container();
          },),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const NewNoteScreen());
          },
          child: const Icon(Icons.add)),
    );
  }
}
