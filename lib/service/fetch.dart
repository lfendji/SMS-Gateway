import 'package:get/get.dart';

class Fetch extends GetConnect {
  Future sendData(Map data) async {
    final response = await post(
      'https://desire-wiki-ai.herokuapp.com/hello',
      data,
    );
    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return response.body;
    }
  }
}
