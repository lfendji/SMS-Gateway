import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiki/controller/controller.dart';

class Home extends GetView<SMSController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(147, 214, 233, 1),
      backgroundColor: Color.fromRGBO(0, 9, 24, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Image.asset("assets/face.png")],
        ),
      ),
    );
  }
}
