import 'package:flutter/material.dart';
import 'package:rofl/add_friends_groups.dart';
import 'auth.dart';
import 'add_friends_groups.dart';
import 'add_event.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});

  final BaseAuth auth;
  final VoidCallback onSignOut;
  final tab = new TabBar(tabs: <Tab>[
    new Tab(
      icon: new Icon(Icons.event),
      text: "Events",
    ),
    new Tab(
      icon: new Icon(Icons.group),
      text: "Groups",
    ),
    new Tab(
      icon: new Icon(Icons.account_circle),
      text: "Friends",
    ),
  ]);
  final pages = new SizedBox(
    height: 300,
    child: Column(
      children: <Widget>[
        Expanded(
          child: TabBarView(children: <Widget>[
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text('Event1'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: Text('Event2'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text('Brotherhood'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: Text('Nispahim'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text('Shlomi'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: Text('Liad'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: new AppBar(
            actions: <Widget>[
              new FlatButton(
                  onPressed: _signOut,
                  child: new Text('Logout',
                      style:
                          new TextStyle(fontSize: 17.0, color: Colors.white))),
            ],
            bottom: tab,
          ),
          body: Column(
            children: <Widget>[
              pages,
            ],
          ),
          drawer: Drawer(
            child: ListView(
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
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddFriends()));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
