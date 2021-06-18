// import 'package:graphql_flutter/graphql_flutter.dart';

// Subscription(
// fetchOnlineUsers,
// OnlineFetch.fetchUsers,
// builder: ({
// bool loading,
// dynamic payload,
// dynamic error,
// }) {
// if (payload != null) {
// Expanded(
// return Expanded(
// child: ListView.builder(
// itemCount: onlineList.list.length,
// itemCount: payload['online_users'].length,
// itemBuilder: (context, index) {
// return Card(
// child: ListTile(
// title: Text(onlineList.list[index]),
// title: Text(
// payload['online_users'][index]['user']['name']),
// ),
// );
// },
// ),
// ),
// );
// } else {
// return Text("Fetching Online Users");
// }
// },
// ),
