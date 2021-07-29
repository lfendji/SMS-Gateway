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
          children: <Widget>[
            Image.asset("assets/face.png"),
            SizedBox(height: 200),
            Obx(() => controller.isloading.value
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Traitement en cours ...",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          CircularProgressIndicator()
                        ],
                      ),
                    ))
                : Container())
          ],
        ),
      ),
    );
  }
}
