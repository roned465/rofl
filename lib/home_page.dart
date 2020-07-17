import 'dart:developer';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rofl/add_friends_groups.dart';
import 'package:rofl/create_group.dart';
import 'auth.dart';
import 'add_friends_groups.dart';
import 'package:rofl/add_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_popup_menu.dart' as mypopup;


class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignOut, this.uid, Key key}) : super(key: key);
  final BaseAuth auth;
  final String uid;
  final VoidCallback onSignOut;

  @override
  _HomePage createState() => _HomePage(auth, onSignOut);
}

enum WhyFarther { attend, decline, maybe }

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  _HomePage(this.auth, this.onSignOut);

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final BaseAuth auth;
  final VoidCallback onSignOut;
  TabController _tabController;
  int tabIndex = 0;
  var myEvents = null;


  final List<Tab> myTabs = <Tab>[
    new Tab(
      icon: new Icon(Icons.event, color: Colors.deepOrange),
      text: "Events",
    ),
    new Tab(
      icon: new Icon(Icons.group, color: Colors.deepOrange, ),
      text: "Groups",
    ),
    new Tab(
      icon: new Icon(Icons.account_circle, color: Colors.deepOrange, ),
      text: "Friends",
    ),
  ];

  Stream<List<DocumentSnapshot>> _userEventsStream() async* {
      var userEventsDocument = await Firestore.instance.collection('userEvents').
      document("X5OjtXMEG0R6CNTriDFLqmAe5R33").get();

      var userEvents = List.from(userEventsDocument["eventlist"]);
      List<DocumentSnapshot> eventsSnapshot = List();

      for (var i = 0; i < userEvents.length; i++) {
        eventsSnapshot.add(await userEvents[i].get());
      }

      yield eventsSnapshot;
  }

  Future<List<DocumentSnapshot>> _getUserEvents() async {
    var userEventsDocument = await Firestore.instance.collection('userEvents').
    document("X5OjtXMEG0R6CNTriDFLqmAe5R33").get();

    var userEvents = List.from(userEventsDocument["eventlist"]);
    List<DocumentSnapshot> eventsSnapshot = List();

    for (var i = 0; i < userEvents.length; i++) {
      eventsSnapshot.add(await userEvents[i].get());
    }

    return eventsSnapshot;
  }


  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Card(
      color: Colors.yellow[100],
      child: ListTile(
        trailing: mypopup.PopupMenuButton<WhyFarther>(
          onSelected: (WhyFarther result) {
            setState(() {
              print(result);
            });
          },
          itemBuilder: (BuildContext context) => [
            mypopup.PopupMenuItem<WhyFarther>(
              value: WhyFarther.attend,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.lightGreen,
                // i use this to change the bgColor color right now
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.check),
                    SizedBox(width: 10.0),
                    Text("  Accept", textAlign: TextAlign.left,),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
            ),
            mypopup.PopupMenuItem<WhyFarther>(
              value: WhyFarther.maybe,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.yellow,
                // i use this to change the bgColor color right now
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.access_alarm),
                    SizedBox(width: 10.0),
                    Text("  Maybe"),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
            ),
            mypopup.PopupMenuItem<WhyFarther>(
              value: WhyFarther.decline,
              child: Container(

                height: double.infinity,
                width: double.infinity,
                color: Colors.red,
                // i use this to change the bgColor color right now
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.close),
                    SizedBox(width: 10.0),
                    Text("  Decline", textAlign: TextAlign.left,),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        leading: Text(
          document['date'] + '\n' + document['time'],
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          'Loctaion: ' + document['location'],
        ),
        title: Text(document['name'],
            textAlign: TextAlign.left, style: TextStyle(fontSize: 20.0)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    _getUserEvents().then((snapshots) => {
      setState(() {
      myEvents = snapshots;
      })
    });
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
      theme: ThemeData(cardColor: Colors.deepOrangeAccent),
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
          body: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Container(
                      child: myEvents == null ? Text("Loading...") :
                      SizedBox(
                          height: MediaQuery.of(context).size.height - 42 - MediaQuery.of(context).padding.bottom -AppBar().preferredSize.height - kToolbarHeight,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child:ListView.separated(
                                  itemCount: myEvents.length,
                                  itemBuilder: (context, index) =>
                                      _buildListItem(context, myEvents[index]),
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                  shrinkWrap: true,
                                ),
                              )
                            ],
                          ),
                      ),
                    ),
                    Container(
                      child: Text("Placeholder")
                    ),
                    Container(
                      child: Text("Placeholder")
                    ),
                  ],
                ),
              ),
//            StreamBuilder(
//              stream: _userEventsStream(),//Firestore.instance.collection("Events").snapshots(),
//              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
//                if (!snapshot.hasData) return const Text("Loading...");
//                return new SizedBox(
//                    height: MediaQuery.of(context).size.height - 42 - MediaQuery.of(context).padding.bottom -AppBar().preferredSize.height - kToolbarHeight,
//                    child: Column(
//                      children: <Widget>[
//                        Expanded(
//                          child:
//                        )
//                      ],
//                    ));
//              },
//            )
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

          floatingActionButton: new FabCircularMenu(
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
                              builder: (context) => createGroup()));
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
                              builder: (context) => CreateEvent(uid: widget.uid)));
                    })
              ]),
        ),
      ),
    );
  }
}
