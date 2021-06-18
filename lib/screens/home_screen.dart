import 'package:core_flutter/services/graphql_service.dart';
import 'package:core_flutter/services/queries/recipes.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final gs = Provider.of<GraphQLService>(context);

    final QueryOptions recipes = QueryOptions(
      document: gql(recipeQuery),
      variables: <String, dynamic>{},
    );

    Future<String> getRecipes() async {
      final QueryResult result = await gs.client.query(recipes);

      if (result.hasException) {
        print(result.exception.toString());
      }

      return result.data!['allFoodRecipes'].toString();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Query Example"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FutureBuilder<String>(
            future: getRecipes(), // function where you call your api
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              // AsyncSnapshot<Your object type>
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Please wait its loading...'));
              } else {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else {
                  return Center(child: new Text('${snapshot.data}'));
                }
              }
            },
          ),
          SizedBox(height: 50),
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
            child: Text(
              'Go to Mutation Example',
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
