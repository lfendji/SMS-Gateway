import 'dart:io';

import 'package:get/get.dart';

class Fetch extends GetConnect {
  Future sendData(String data) async {
    Response response = await post("", data);
    return response.body;
  }
}
