import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'primary_button.dart';
import 'auth.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


class Invite extends StatefulWidget {
  Invite({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _Invite createState() => new _Invite();
}

enum FormType { login, register }

class PasswordsException implements Exception {
  String code = "ERROR_NOT_MATCHING_PASSWORDS";
}

class _Invite extends State<Invite> {
  static final formKey = new GlobalKey<FormState>();
  List<String> _listgroups = ['bhood', 'dabs', 'rofls'];
  List<bool> _groupschecked = List.filled(3, false);
  List<String> _listfriends = ['shlomi', 'yojev'];
  List<bool> _friendschecked  = List.filled(3, false);
  bool _isChecked = false;



  final tab = new TabBar(
      labelColor: Colors.deepOrange,
      indicatorColor: Colors.deepOrange,
      tabs: <Tab>[
        new Tab(
          icon: new Icon(Icons.group, color: Colors.deepOrange),
          text: "Groups",
        ),
        new Tab(
          icon: new Icon(Icons.account_circle, color: Colors.deepOrange),
          text: "Friends",
        ),
      ]);

  String _name;
  String _Location;
  String _date = "";
  String _time = "";

  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: new Text(
              'Invite ',
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
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: new IconThemeData(color: Colors.deepOrange),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topLeft,
                      colors: <Color>[Colors.yellow[100], Colors.yellow[100]])),
            ),
            bottom: tab,
          ),
          body: new TabBarView(
            children: [
              new ListView(
                children: _listgroups
                    .map((text) => CheckboxListTile(
                          activeColor: Colors.deepOrange,
                          title: Text(text),
                          value: _groupschecked[_listgroups.indexOf(text)],
                          onChanged: (val) {
                            setState(() {
                              _groupschecked[_listgroups.indexOf(text)] = val;
                            });
                          },
                        ))
                    .toList(),
              ),
              new ListView(
                children: _listfriends
                    .map((text) => CheckboxListTile(
                          activeColor: Colors.deepOrange,
                          title: Text(text),
                          value: _friendschecked[_listfriends.indexOf(text)],
                          onChanged: (val) {
                            setState(() {
                              _friendschecked[_listfriends.indexOf(text)] = val;
                            });
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget padded({Widget child}) {
  return new Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: child,
  );
}
