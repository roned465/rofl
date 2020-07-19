import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'primary_button.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class Invite extends StatefulWidget {
  Invite(
      {Key key,
      this.name,
      this.time,
      this.date,
      this.location,
      this.listfriends,
        this.uid,
        this.listgroups
      })
      : super(key: key);

  final List<String> listfriends;
  final List<String> listgroups;
  final String name;
  final String time;
  final String uid;
  final String date;
  final String location;
  String groupname = "";

  @override
  _Invite createState() => new _Invite();
}

enum FormType { login, register }

class PasswordsException implements Exception {
  String code = "ERROR_NOT_MATCHING_PASSWORDS";
}

class _Invite extends State<Invite> {
  final firestoreInstance = Firestore.instance;
  static final formKey = new GlobalKey<FormState>();
  List<bool> _groupschecked = List.filled(14, false);
  List<bool> _friendschecked = List.filled(14, false);
  List<String> invited_groups = [];
  List<String> invited_friends = [];
  bool _isChecked = false;

  bool validateAndSave(var str) {
    widget.groupname = str;
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void initState() {
    super.initState();
  }

  final tab = new TabBar(
      labelColor: Colors.deepOrange,
      indicatorColor: Colors.deepOrange,
      tabs: <Tab>[
        new Tab(
            icon: new Icon(Icons.dashboard, color: Colors.deepOrange),
            text: "Group details"),
        new Tab(
          icon: new Icon(Icons.account_circle, color: Colors.deepOrange),
          text: "Invited friends",
        ),
      ]);

  void showFloatingFlushbar(BuildContext context, var message) {
    Flushbar(
      duration: new Duration(seconds: 4),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.deepOrange.shade300, Colors.yellow.shade300],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.easeOutQuad,

      message: message,
    )..show(context);
  }

  void voteUpB(var str) {
    print(str);
    setState(() => widget.groupname = str);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: new AppBar(
                centerTitle: true,
                title: new Text(
                  'Invite friends and groups ',
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.fill
                      ..strokeWidth = 1
                      ..color = Colors.red[700],
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    Navigator.of(context).pop();
                  },
                ),
                iconTheme: new IconThemeData(color: Colors.deepOrange),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topLeft,
                          colors: <Color>[
                        Colors.yellow[100],
                        Colors.yellow[100]
                      ])),
                ),
                bottom: tab,
              ),
              body: new TabBarView(
                children: [
                  padded(
                    child: new ListView(
                      children: widget.listgroups
                          .map((text) => CheckboxListTile(
                        activeColor: Colors.deepOrange,
                        title: Text(text),
                        value: _groupschecked[
                        widget.listgroups.indexOf(text)],
                        onChanged: (val) {
                          setState(() {
                            _groupschecked[
                            widget.listgroups.indexOf(text)] = val;
                          });
                        },
                      ))
                          .toList(),
                    ),

                  ),
                  new ListView(
                    children: widget.listfriends
                        .map((text) => CheckboxListTile(
                              activeColor: Colors.deepOrange,
                              title: Text(text),
                              value: _friendschecked[
                                  widget.listfriends.indexOf(text)],
                              onChanged: (val) {
                                setState(() {
                                  _friendschecked[
                                      widget.listfriends.indexOf(text)] = val;
                                });
                              },
                            ))
                        .toList(),
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.deepOrangeAccent,
                child: Icon(Icons.add_circle, color: Colors.yellow[100]),
                onPressed: () {

                  for (int i = 0; i < _groupschecked.length; i++) {
                    if (_groupschecked[i]) {
                      invited_groups.add(widget.listgroups[i]);
                    }
                  }
                  for (int i = 0; i < _friendschecked.length; i++) {
                    if (_friendschecked[i]) {
                      invited_friends.add(widget.listfriends[i]);
                    }
                  }

                  if (invited_friends.length == 0 ||
                      invited_groups.length == 0) {
                    showFloatingFlushbar(context, "Group cant be empty");
                  } else {
                    firestoreInstance.collection("Events").add({
                      "groups": invited_groups,
                      "friends": invited_friends,
                      "name": widget.name,
                      "location": widget.location,
                      "date": widget.date,
                      "time": widget.time,
                    }).then((value) {
                      String id = value.documentID;
                      firestoreInstance
                          .collection("userEvents")
                          .document(widget.uid)
                          .setData({}, merge: true);
                      DocumentReference documentReference =
                          Firestore.instance.collection("Events").document(id);
                      List idlist = [documentReference];
                      firestoreInstance
                          .collection("userEvents")
                          .document(widget.uid)
                          .updateData({
                        "counter": FieldValue.increment(1),
                        "eventlist": FieldValue.arrayUnion(idlist),
                      });
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    });
                  }
                },
              ),
            ),
          ),
        ));
  }
}

Widget padded({Widget child}) {
  return new Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: child,
  );
}
