import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'binding/controller_binding.dart';
import 'views/home.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: ControllerBindging(),
    home: Home(),
  ));
}
