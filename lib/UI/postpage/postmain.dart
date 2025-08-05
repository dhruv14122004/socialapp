import 'package:campusconnect/UI/postpage/addpost.dart';
import 'package:campusconnect/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Postmain extends StatefulWidget {
  const Postmain({super.key});

  @override
  State<Postmain> createState() => _SearchMainState();
}

class _SearchMainState extends State<Postmain> {
  final databaseref = FirebaseDatabase.instance.ref('posts');
  final searchfilter = TextEditingController();
  final updatecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: searchfilter,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.white,
                fillColor: Colors.grey.shade700,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('description').value.toString();
                final id = snapshot.child('id').value.toString();

                if (searchfilter.text.isEmpty) {
                  return ListTile(
                    title: Text(title),
                    subtitle: Text(id),
                    trailing: PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            title: Text("Edit"),
                            leading: Icon(Icons.edit),
                            onTap: () {
                              Navigator.of(context).pop();
                              showMyDialog(title, id);
                            },
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            title: Text("Delete"),
                            leading: Icon(Icons.delete),
                            onTap: () {
                              showDeleteAlert(id);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (title.toLowerCase().toString().contains(
                  searchfilter.text.toLowerCase().toString(),
                )) {
                  return ListTile(
                    title: Text(snapshot.child('description').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Addpost();
              },
            ),
          );
        },
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    updatecontroller.text = title;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text("Update", style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(controller: updatecontroller),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                databaseref
                    .child(id)
                    .update({'description': updatecontroller.text.toString()})
                    .then((value) {
                      Utils().error("Updated");
                    })
                    .onError((error, StackTrace) {
                      Utils().error(error.toString());
                    });
                Navigator.of(context).pop();
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteAlert(String id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete this post?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                databaseref
                    .child(id)
                    .remove()
                    .then((value) {
                      Utils().error("Post Deleted");
                    })
                    .onError((error, StackTrace) {
                      Utils().error(error.toString());
                    });
                Navigator.of(context).pop();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}



          // Expanded(
          //   child: StreamBuilder(
          //     stream: databaseref.onValue,
          //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //       if (snapshot.hasData) {
          //         Map<dynamic, dynamic> map =
          //             snapshot.data!.snapshot.value as dynamic;
          //         List<dynamic> list = [];
          //         list.clear();
          //         list = map.values.toList();
          //         return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(title: Text(list[index]['description']), subtitle: Text(list[index]['id']),);
          //           },
          //         );
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // ),