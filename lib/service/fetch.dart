import 'package:get/get.dart';

class Fetch extends GetConnect {
  Future sendData(Map data) async {
    final response =
        await post("http://192.168.43.108:8000/summarizer", data, headers: {
      "content-type": "application/json ",
      // "connectTimeout": "20000",
      // "connection": "keep-alive"
    });
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return response.body;
    }
  }
}
