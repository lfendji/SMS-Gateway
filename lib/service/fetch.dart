import 'package:get/get.dart';

class Fetch extends GetConnect {
  Future sendData(Map data) async {
    final response = await post("http://192.168.43.34:8000/summarizer", data);
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return response.body;
    }
  }
}
