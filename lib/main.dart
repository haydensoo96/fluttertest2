import 'package:core_flutter/provider/TodoModel.dart';
import 'package:core_flutter/screens/login_screen.dart';
import 'package:core_flutter/screens/home_screen.dart';
import 'package:core_flutter/screens/sample_screen.dart';
import 'package:core_flutter/services/graphql_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:core_flutter/screens/provider_screen.dart';

void main() async {
  await GetStorage.init();
  Provider.debugCheckInvalidValueType=null;
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => GraphQLService()),
        Provider(create: (_) => TodoModel(),)
      ],
      child: GetMaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      "/login": (BuildContext context) => LoginScreen(),
      "/home": (BuildContext context) => HomeScreen(),
      "/sample": (BuildContext context) => SampleScreen(), 
      "/provider": (BuildContext context) => ProviderScreen(),      
       };
    return MaterialApp(
      title: 'Flutter Core Login',
      theme: ThemeData(primaryColor: Colors.red),
      routes: routes,
      home: LoginScreen(),
    );
  }
}
