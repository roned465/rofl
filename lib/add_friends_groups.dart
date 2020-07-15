import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class AddFriends extends StatefulWidget {
  @override
  _AddFriends createState() => new _AddFriends();
}

class _AddFriends extends State<AddFriends> {
//class _AddFriends extends StatelessWidget {
  BuildContext _buildContext;
  DocumentSnapshot _document;
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 0));
    if (search == "empty") return [];
    if (search == "error") throw Error();

    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection("Friends").snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) return const Text("Loading...");
          return new SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBar<Post>(
                searchBarStyle: SearchBarStyle(
                  backgroundColor: Colors.yellow[100],
                  padding: EdgeInsets.all(10),
                  borderRadius: BorderRadius.circular(10),
                ),
                loader: Center(
                  child: Text("My loader"),
                ),
                placeHolder: Center(
                  child: Text("Placeholder"),
                ),
                onError: (error) {
                  return Center(
                    child: Text("Error occurred : $error"),
                  );
                },
                emptyWidget: Center(
                  child: Text("Empty"),
                ),
                onSearch: search,
                //suggestions:
                onItemFound: (Post post, int index) {
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.description),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
