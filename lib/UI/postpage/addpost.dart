import 'package:campusconnect/UI/postpage/postmain.dart';
import 'package:campusconnect/UI/widget/roundedbutton.dart';
import 'package:campusconnect/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  final databaseref = FirebaseDatabase.instance.ref('posts');
  final postController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              controller: postController,
              decoration: InputDecoration(
                hintText: "Whats on your mind?",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.deepOrange),
                ),
              ),
            ),
            SizedBox(height: 20),
            Roundedbutton(
              title: "Add Post",
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                databaseref
                    .child(DateTime.now().millisecondsSinceEpoch.toString())
                    .set({
                      'description': postController.text.toString(),
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    })
                    .then((value) {
                      Utils().error("Post Added");
                      setState(() {
                        loading = false;
                      });
                    })
                    .onError((error, StackTrace) {
                      Utils().error(error.toString());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
