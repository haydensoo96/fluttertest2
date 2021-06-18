import 'package:core_flutter/screens/login_screen.dart';
import 'package:core_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hasura_connect/hasura_connect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String url = 'https://staging.rakita.my/graphql';
    HasuraConnect hasuraConnect = HasuraConnect(url);

    //query
    final String recipeNames = """
    query MyQuery {
      allFoodRecipes {
        id
        name
      }
    }
    """;

    var recipes = hasuraConnect.query(recipeNames);
    print(recipes);

    Future<String> getRecipes() async {
      var r = await hasuraConnect.query(recipeNames);
      return r;
    }

    getRecipes().then((value) => print(value));

    final routes = <String, WidgetBuilder>{
      "/login": (BuildContext context) => LoginScreen(),
      "/home": (BuildContext context) => HomeScreen(),
    };
    return MaterialApp(
      title: 'Flutter Core Login',
      theme: ThemeData(primaryColor: Colors.red),
      routes: routes,
      home: LoginScreen(),
    );
  }
}
