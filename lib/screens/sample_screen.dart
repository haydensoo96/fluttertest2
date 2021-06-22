import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// class Controller extends GetxController {
//   final data = GetStorage();
//   var count = 0.obs;
//   var nextTitle = 'Hello Second Page'.obs;
//   increment() => count++;

//   void initState() {
//     if(data.read('count')!=null){
//       count=data.read('count');
//     }
//   }
// }

class SampleScreen extends StatefulWidget {
  @override
  _SampleScreenState createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  var _count = 0;
  final data = GetStorage();

@override
void initState(){
  super.initState();

  if(data.read('count')!=null){
    _count = data.read('count');
  }
}

  @override
  Widget build(context) {
    data.writeIfNull('count', 0);
    return Scaffold(
        // ignore: unnecessary_brace_in_string_interps
        appBar: AppBar(title: Text("Clicks: ${data.read('count')}")),
        body: Center(
            child: ElevatedButton(
                child: Text("Go to Other"),
                onPressed: () => Get.to(OtherPage()))),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _count++;
                data.write('count', _count);
              });
            }));
  }
}

class OtherPage extends StatefulWidget {
  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  // final Controller c = Get.find();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "${c.nextTitle}",
        //   style: Theme.of(context).textTheme.headline6,
        // ),
        // backgroundColor: Colors.white,
        // elevation: 0,
      ),
      // body: Center(child: Text("${c.count}")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
    );
  }
}
