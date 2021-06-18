import 'package:core_flutter/database/database_helper.dart';
import 'package:core_flutter/screens/logout_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          Text('You are now logged in!', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          FutureBuilder<List>(
            future: db.getToken(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return Text('Your token number : ${snapshot.data}',
                    style: TextStyle(fontSize: 24));
              }
              return Container();
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: () {
              db.deleteToken();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogOutScreen()));
            },
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            shape: StadiumBorder(
              side: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        ])));
  }
}
