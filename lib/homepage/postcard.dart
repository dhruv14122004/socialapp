import 'package:campusconnect/homepage/commentsection.dart';
import 'package:campusconnect/mock_data/mock_post.dart';
import 'package:flutter/material.dart';

class Postcard extends StatefulWidget {
  const Postcard({super.key});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  int isliked = 0;
  int hasimage = 1;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "${posts[index]['pfp']}",
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "@${posts[index]['name']}",
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              "${posts[index]['info']}",
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        Spacer(flex: 1),
                        IconButton(
                          onPressed: () {
                            debugPrint("Option Button pressed");
                          },
                          icon: Icon(Icons.more_horiz),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black),
                    Text("${posts[index]['post_txt']}"),
                    Center(
                      child: posts[index]['post_photo'] == null
                          ? SizedBox(height: 0)
                          : Image.asset(
                              "${posts[index]['post_photo']}",
                              height: 250,
                            ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              debugPrint("Liked Button pressed");
                              if (isliked == 0) {
                                isliked = 1;
                              } else {
                                isliked = 0;
                              }
                            });
                          },
                          icon: Icon(
                            isliked == 0
                                ? Icons.favorite_border
                                : Icons.favorite,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Commentsection();
                              },
                            );
                          },
                          icon: Icon(Icons.comment),
                        ),
                        Spacer(flex: 1),
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
