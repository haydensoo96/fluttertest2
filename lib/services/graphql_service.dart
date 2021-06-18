import 'package:graphql/client.dart';

class GraphQLService {
  static HttpLink httpLink = HttpLink(
    "http://54.169.229.77/v1/graphql",
  );

  static token() async {
    String token = '';
    return token;
  }

  static AuthLink authLink = AuthLink(
    getToken: () async => 'JWT ' + await token(),
  );

  static Link link = authLink.concat(httpLink);

  final GraphQLClient client = GraphQLClient(
    // The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(),
    link: link,
  );
}
