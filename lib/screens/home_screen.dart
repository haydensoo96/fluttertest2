import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter CORE Home Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
            child: Text(
              'Click to Move to Login Screen',
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
          SizedBox(height: 150),
        ],
      ),
    );
  }
}
