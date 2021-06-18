import 'package:core_flutter/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static HttpLink httpLink = HttpLink(
    "https://staging.rakita.my/graphql",
  );

  static token() async {
    String token = '';
    var db = new DatabaseHelper();
    var userDetail = await db.getToken();

    if (userDetail.length > 0) {
      token = userDetail[userDetail.length - 1]['token'];
    } else if (userDetail.length == 0) {}
    return token;
  }

  static final WebSocketLink webSocketLink = WebSocketLink(
    'wss://staging.rakita.my/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initialPayload: {
        'headers': {'Authorization': token()},
      },
    ),
  );

  static AuthLink authLink = AuthLink(
    getToken: () async => 'JWT ' + await token(),
  );

  static Link link = authLink.concat(httpLink).concat(webSocketLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}
