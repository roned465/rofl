import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rofl/add_friends_groups.dart';
import 'auth.dart';
import 'add_friends_groups.dart';
import 'package:rofl/add_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bubble/bubble.dart';
class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignOut, Key key}) : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  _HomePage createState() => _HomePage(auth, onSignOut);
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  _HomePage(this.auth, this.onSignOut);
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
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

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Column(
        children: <Widget>[
          Bubble(
            color: Colors.deepOrange,
            child: Text("name = " + document['name'] + "| location= " + document['location'] + "| time " + document['time'], textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
          )
        ],
      ),
    );
  }

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

            centerTitle: true,
            title: new Text(
              "Home Page",
              style: TextStyle(
                color: Colors.deepOrange,
              ),
            ),
            backgroundColor: Colors.deepOrange,
            iconTheme: new IconThemeData(color: Colors.deepOrange),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topLeft,
                      colors: <Color>[Colors.yellow[100], Colors.yellow[100]])),
            ),
            bottom: new TabBar(
              indicatorColor: Colors.deepOrangeAccent,
              labelColor: Colors.deepOrange,
              tabs: myTabs,
              controller: _tabController,
            ),
            actions: <Widget>[
              new IconButton(
                icon: new Image.asset('assets/option2.png'),
                color: Colors.deepOrange,

              ),
            ],
          ),
          body: Column(children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance.collection("Events").snapshots(),
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading...");
                return new SizedBox(
                    height: 500,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              Container(
                                child: ListView.builder(
                                  itemExtent: 80.0,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) =>
                                      _buildListItem(context,
                                            snapshot.data.documents[index]),
                                  shrinkWrap: true,
                                ),
                              ),
                              Container(
                                child: ListView.builder(
                                  itemExtent: 80.0,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) =>
                                      _buildListItem(context,
                                          snapshot.data.documents[index]),
                                  shrinkWrap: true,
                                ),
                              ),
                              Container(
                                child: ListView.builder(
                                  itemExtent: 80.0,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) =>
                                      _buildListItem(context,
                                          snapshot.data.documents[index]),
                                  shrinkWrap: true,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ));
              },
            )
          ]),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 75.0,
                  child: DrawerHeader(
                    child: Text(
                      'Settings',
                      style: new TextStyle(color: Colors.yellow[100]),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: _signOut,
                ),
                ListTile(
                  title: Text('close'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FabCircularMenu(
              key: fabKey,
              fabOpenIcon:
                  Icon(Icons.add, color: Colors.yellow[100], size: 30.0),
              fabCloseIcon: Icon(Icons.close, color: Colors.deepOrange),
              animationDuration: Duration(seconds: 1),
              ringColor: Colors.deepOrange,
              ringDiameter: 300.0,
              ringWidth: 100.0,
              fabSize: 64.0,
              fabOpenColor: Colors.yellow[100],
              fabCloseColor: Colors.deepOrange,
              fabElevation: 8.0,
              animationCurve: Curves.elasticIn,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.group_add,
                        color: Colors.yellow[100], size: 30.0),
                    onPressed: () {
                      fabKey.currentState.close();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFriends()));
                    }),
                IconButton(
                    icon: Icon(Icons.person_add,
                        color: Colors.yellow[100], size: 30.0),
                    onPressed: () {
                      fabKey.currentState.close();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFriends()));
                    }),
                IconButton(
                    icon: Icon(Icons.add_box,
                        color: Colors.yellow[100], size: 30.0),
                    onPressed: () {
                      fabKey.currentState.close();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateEvent()));
                    })
              ]),
        ),
      ),
    );
  }
}
