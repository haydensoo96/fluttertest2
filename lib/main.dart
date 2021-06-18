import 'package:core_flutter/database/database_helper.dart';
import 'package:core_flutter/screens/login_screen.dart';
import 'package:core_flutter/screens/home_screen.dart';
import 'package:core_flutter/screens/splash_screen.dart';
import 'package:core_flutter/services/graphql_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => DatabaseHelper()),
        Provider(create: (_) => GraphQLService())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      "/login": (BuildContext context) => LoginScreen(),
      "/home": (BuildContext context) => HomeScreen(),
    };
    return MaterialApp(
      title: 'Flutter Core Login',
      theme: ThemeData(primaryColor: Colors.red),
      routes: routes,
      home: SplashScreen(),
    );
  }
}
