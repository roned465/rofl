import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add event"),
      ),
      body: Column(
        children: <Widget>[
          BottomAppBar(
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),

          ),
        ],

      ),


    );
  }
}