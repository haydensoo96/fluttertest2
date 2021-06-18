import 'package:core_flutter/models/auth.dart';
import 'package:core_flutter/services/graphql_service.dart';
import 'package:core_flutter/services/mutations/authentication.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalStorage storage = new LocalStorage('Auth');

  @override
  Widget build(BuildContext context) {
    final gs = Provider.of<GraphQLService>(context);

    final MutationOptions login = MutationOptions(
      document: gql(tokenAuth),
      variables: <String, dynamic>{
        'username': 'Adila',
        'password': 'bcss2013',
      },
    );

    Future<String> getToken() async {
      final QueryResult result = await gs.client.mutate(login);

      if (result.hasException) {
        print(result.exception.toString());
      }

      return result.data!['tokenAuth']['token'].toString();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Mutation Example, Check Local Storage for Token"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FutureBuilder<String>(
            future: getToken(), // function where you call your api
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              // AsyncSnapshot<Your object type>
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Please wait its loading...'));
              } else {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else {
                  print('${snapshot.data}');
                  final Auth auth = new Auth(token: '${snapshot.data}');
                  storage.setItem('auth', auth.toJSONEncodable());
                  return Center(child: new Text('${snapshot.data}'));
                }
              }
            },
          ),
          SizedBox(height: 50),
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
            child: Text(
              'Go to Query Example',
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
        ],
      ),
    );
  }
}
