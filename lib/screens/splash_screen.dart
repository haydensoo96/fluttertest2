import 'package:core_flutter/database/database_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key key,
  }) : super(key: key);

  initMethod(context) async {
    var db = DatabaseHelper();
    var _token = await db.getToken();

    String token = '';
    if (_token.length > 0) {
      token = _token[_token.length - 1]['token'];
    } else if (_token.length == 0) {}

    if (token.isEmpty) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else
      Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

    return Scaffold(
        body: Center(
      child: new CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    ));
  }
}
