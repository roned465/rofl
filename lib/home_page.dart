import 'package:flutter/material.dart';
import 'package:rofl/add_friends_groups.dart';
import 'auth.dart';
import 'add_friends_groups.dart';
import 'add_event.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignOut, Key key}) : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  _HomePage createState() => _HomePage(auth, onSignOut);
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  _HomePage(this.auth, this.onSignOut);

  final BaseAuth auth;
  final VoidCallback onSignOut;
  TabController _tabController;
  int tabIndex = 0;

  final List<Tab> myTabs = <Tab>[
    new Tab(
      icon: new Icon(Icons.event, color: Colors.deepOrange),
      text: "Events",
    ),
    new Tab(
      icon: new Icon(Icons.group, color: Colors.deepOrange),
      text: "Groups",
    ),
    new Tab(
      icon: new Icon(Icons.account_circle, color: Colors.deepOrange),
      text: "Friends",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            iconTheme: new IconThemeData(color: Colors.deepOrange),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topLeft,
                      colors: <Color>[Colors.yellow[100], Colors.yellow[100]])),
            ),
            bottom: new TabBar(
              tabs: myTabs,
              controller: _tabController,
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout',
                    style: new TextStyle(
                        fontSize: 17.0, color: Colors.deepOrange)),
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              new SizedBox(
                height: 300,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'Settings',
                    style: new TextStyle(color: Colors.yellow[100]),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                  ),
                ),
                ListTile(
                  title: Text('add event'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddEvent()));
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
              tabIndex = _tabController.index;
              print(tabIndex);
              switch(tabIndex){
                case 0: {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddEvent()));
                  break;
                }
                case 1: {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddFriends()));
                  break;
                }
                case 2: {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddFriends()));
                  break;
                }
              }

            },
            child: Icon(
              Icons.add,
              color: Colors.deepOrange,
            ),
            backgroundColor: Colors.yellow[100],
          ),
        ),
      ),);
  }
}
