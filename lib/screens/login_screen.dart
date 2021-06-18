import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter CORE Login Screen"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
            child: Text(
              'Click to Move to Home Screen',
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
