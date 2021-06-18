import 'package:core_flutter/components/login_component.dart';
import 'package:core_flutter/components/home_component.dart';
import 'package:core_flutter/services/graphql_service.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final graphql = Provider.of<GraphQLService>(context);

    return GraphQLProvider(
      client: graphql.client,
      child: HomeComponent(),
    );
  }
}
