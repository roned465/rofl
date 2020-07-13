import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


Widget padded({Widget child}) {
  return new Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: child,
  );
}



class AddEvent extends StatefulWidget {
  AddEvent({Key key, this.User}) : super(key: key);
  String User;

  @override
  State<StatefulWidget> createState() => new _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  static final formKey = new GlobalKey<FormState>();
  String _name;
  String _Location;
  String _date = "";
  String _time = "";


  List<Widget> eventProperties()
  {
    return [
      padded(
        child: new TextFormField(
            style: TextStyle(color: Colors.redAccent),
            key: new Key('name'),
            onSaved: (val) => _name = val,
            cursorColor: Colors.deepOrange,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              fillColor: Colors.deepOrange,
              labelText: 'Event name',
              labelStyle: new TextStyle(color: Colors.deepOrange),
              hintText: 'What?',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange)),
              border: OutlineInputBorder(borderSide: BorderSide()),
            )),
      ),
      padded(
        child: new TextFormField(
            style: TextStyle(color: Colors.redAccent),
            obscureText: true,
            key: new Key('location'),
            onSaved: (val) => _Location = val,
            cursorColor: Colors.deepOrangeAccent,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Location',
              labelStyle: new TextStyle(color: Colors.deepOrange),
              hintText: 'Where?',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange)),
              border: OutlineInputBorder(borderSide: BorderSide()),
            )),
      ),
      padded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showDatePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2022, 12, 31), onConfirm: (date)  {
                      print('confirm $date');
                      _date = '${date.year} - ${date.month} - ${date.day}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                " $_date",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.yellow[100],
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showTimePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    showSecondsColumn: false,
                    onConfirm: (time) {
                      print('confirm $time');
                      _time = '${time.hour} : ${time.minute}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                " $_time",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Change",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.yellow[100],
            )
          ],
        ),
      ),
            ),
      ),
    ];
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.deepOrange),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topLeft,
                  colors: <Color>[Colors.yellow[100], Colors.yellow[100]])),
        ),
        title: Text("Create event", style: TextStyle(color: Colors.deepOrange, ),),
      ),
      body: new SingleChildScrollView(

          child: new Container(
              padding: const EdgeInsets.all(16.0),


              child: new Column(children: [
                new Card(
                    child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration:
                              BoxDecoration(
                                  border: Border.all(
                                      color: Colors.red
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)
                                  )
                              ),
                              child: new Form(
                                  key: formKey,
                                  child: new Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: eventProperties(),

                                  ))),
                        ])),
              ]))));
  }
}
