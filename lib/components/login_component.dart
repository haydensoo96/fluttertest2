import 'package:core_flutter/components/utils.dart';
import 'package:core_flutter/database/database_helper.dart';
import 'package:core_flutter/models/auth.dart';
import 'package:core_flutter/services/mutations/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginComponent extends StatefulWidget {
  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final db = DatabaseHelper();

    return new Scaffold(
        body: Mutation(
      options: MutationOptions(
        document: gql(tokenAuth),
        onCompleted: (result) {
          print(result);
          if (result == null) {
            showDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: new Text('Incorrect Credentials'),
                      content: new Text(
                          'Please enter the correct username and password'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: Text('Ok'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ],
                    ));
          } else if (result['tokenAuth'] != null) {
            final auth = Auth(result['tokenAuth']['token']);
            db.saveToken(auth);
            PopUpMessage.showToast("Login Successful", context);
            Navigator.pushReplacementNamed(context, "/home");
          }
        },
      ),
      builder: (RunMutation insert, QueryResult result) {
        return Container(
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Flutter CORE Login',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        labelText: 'Username', icon: Icon(Icons.person)),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(value))
                        return 'Enter Valid Email';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.lock)),
                    validator: (value) {
                      return value.length < 4
                          ? "Password must be at least 4 characters long"
                          : null;
                    },
                    obscureText: true,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.width * 0.22,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: RaisedButton(
                        onPressed: () {
                          insert(<String, dynamic>{
                            "username": _usernameController.text,
                            "password": _passwordController.text
                          });
                        },
                        child: Text(
                          'Login',
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
