import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    "https://staging.rakita.my/graphql",
  );

  static token() async {
    var token = '';
    return token;
  }

  static AuthLink authLink = AuthLink(
    getToken: () async => 'JWT ' + await token(),
  );

  static Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
    ),
  );
}
