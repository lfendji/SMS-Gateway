import 'package:get/get.dart';

class Fetch extends GetConnect {
  Future<Response> sendData(Map data) async {
    var response = await post("http://127.0.0.1:8000/hello", data);
    return response.body;
  }
}
