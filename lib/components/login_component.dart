import 'package:core_flutter/services/mutations/authentication.dart';
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
    return new Scaffold(
        body: Mutation(
      options: MutationOptions(
          document: gql(tokenAuth),
          onCompleted: (result) {
            onLoginSuccess(result.toString());
          },
          onError: (errors) {}),
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
                    decoration: InputDecoration(
                        labelText: 'Username', icon: Icon(Icons.person)),
                    controller: _usernameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.lock)),
                    controller: _passwordController,
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

void onLoginSuccess(String token) async {
  print(token);
}
