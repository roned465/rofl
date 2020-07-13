import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

//class AddFriends extends StatefulWidget {
//@override
//_AddFriends createState() => new _AddFriends();
//}
//class _AddFriends extends State<AddFriends>{
class AddFriends extends StatelessWidget {
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
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
      body: SafeArea(
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
            onItemFound: (Post post, int index) {
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.description),
              );
            },
          ),
        ),
      ),
    );
  }
}
