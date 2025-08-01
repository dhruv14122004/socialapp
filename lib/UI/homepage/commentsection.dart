import 'package:campusconnect/mock_data/mock_post.dart';
import 'package:flutter/material.dart';

class Commentsection extends StatefulWidget {
  const Commentsection({super.key});

  @override
  State<Commentsection> createState() => _CommentsectionState();
}

class _CommentsectionState extends State<Commentsection> {
  Map<int, int> voteState = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            blurRadius: 10,
            offset: Offset(0, -1),
          ),
        ],
      ),
      height: 500,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Comments",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(color: Colors.grey.shade400),
            Expanded(
              child: ListView.builder(
                itemCount: (posts[0]['comments'] as List).length,
                itemBuilder: (context, index) {
                  int currentVote = voteState[index] ?? 0;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  color: Colors.black,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text((posts[0]['comments'] as List)[index]['by']),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (currentVote == 1) {
                                      voteState[index] = 0;
                                    } else {
                                      voteState[index] = 1;
                                    }
                                  });
                                },
                                icon: Icon(Icons.arrow_circle_up, color: currentVote == 1 ? Colors.green : Colors.black,),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (currentVote == -1) {
                                      voteState[index] = 0;
                                    } else {
                                      voteState[index] = -1;
                                    }
                                  });
                                },
                                icon: Icon(Icons.arrow_circle_down, color: currentVote == -1 ? Colors.red : Colors.black,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
