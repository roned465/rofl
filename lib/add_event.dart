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

      drawer: Drawer(child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Settings'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('ROFL'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('DAB'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('exit'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )
        ,),
    );
  }
}