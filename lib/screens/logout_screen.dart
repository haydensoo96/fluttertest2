import 'package:core_flutter/database/database_helper.dart';
import 'package:flutter/material.dart';

class LogOutScreen extends StatefulWidget {
  @override
  _LogOutScreenState createState() => _LogOutScreenState();
}

class _LogOutScreenState extends State<LogOutScreen> {
  var db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.red,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Text(
            'You are now logged out!',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          FutureBuilder<List>(
            future: db.getToken(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return Text('Your token number : ${snapshot.data}',
                    style: TextStyle(fontSize: 24.0));
              }
              return Container();
            },
          ),
          SizedBox(height: 20),
        ])));
  }
}
