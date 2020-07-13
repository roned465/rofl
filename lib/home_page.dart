import 'package:flutter/material.dart';
import 'auth.dart';
import 'add_event.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});

  final BaseAuth auth;
  final VoidCallback onSignOut;

  final tab = new TabBar(tabs: <Tab>[
    new Tab(icon: new Icon(Icons.arrow_forward)),
    new Tab(icon: new Icon(Icons.arrow_downward)),
    new Tab(icon: new Icon(Icons.arrow_back)),
  ]);

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
          body: Column(children: <Widget>[
            SizedBox(
              height: 300,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
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
                            height: 200.0,
                            color: Colors.green,
                          ),
                          Container(
                            height: 200.0,
                            color: Colors.red,
                          ),
                        ]
                      ),
                    ),
                  ],
                ))
          ]),
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
                  context, MaterialPageRoute(builder: (context) => AddEvent()));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
