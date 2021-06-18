import 'package:core_flutter/components/utils.dart';
import 'package:core_flutter/database/database_helper.dart';
import 'package:core_flutter/services/queries/me.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeComponent extends StatefulWidget {
  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  VoidCallback refetchQuery;
  @override
  Widget build(BuildContext context) {
    final db = DatabaseHelper();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter CORE"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Query(
                  options: QueryOptions(
                    document: gql(me),
                  ),
                  builder: (QueryResult result,
                      {VoidCallback refetch, FetchMore fetchMore}) {
                    refetchQuery = refetch;
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }
                    if (result.isLoading) {
                      return Text('Loading');
                    }
                    return Text(
                      "Hello " + result.data['me']['name'],
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center,
                    );
                  })),
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () {
              db.deleteToken();
              PopUpMessage.showToast("Logout Successful", context);
              Navigator.pushReplacementNamed(context, "/login");
            },
            child: Text(
              'Log Out',
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
