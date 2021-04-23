import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SMSController controller = Get.put(SMSController());

  @override
  void initState() {
    super.initState();
    controller.entMethod();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Color.fromRGBO(147, 214, 233, 1),
        backgroundColor: Color.fromRGBO(0, 9, 24, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Image.asset("assets/face.png")],
          ),
        ),
      ),
    );
  }
}
