import 'package:core_flutter/screens/login_screen.dart';
import 'package:core_flutter/services/graphql_service.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MaterialApp(
      title: 'Flutter CORE',
      theme: ThemeData(primaryColor: Colors.red),
      home: GraphQLProvider(
        client: graphQLConfiguration.client,
        child: MaterialApp(
          home: LoginScreen(),
        ),
      )));
}
