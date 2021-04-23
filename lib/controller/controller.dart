import 'package:get/get.dart';
import 'package:sms/sms.dart';
import 'package:wiki/service/fetch.dart';

class Controller extends GetxController {
  Fetch fetch = Fetch();
  SmsQuery query = new SmsQuery();
  SimCardsProvider provider = new SimCardsProvider();
  SmsSender sender = new SmsSender();

  @override
  void onInit() async {
    super.onInit();
    var data = await readSms();
    print(data);
    // await readSms().then((value) async => await fetch
    //     .sendData(value["body"])
    //     .then((val) async => await sendSMS(val, value["address"])));
  }

  Future readSms() async {
    List<SmsMessage> messages = await query.getAllSms;
    return {"body": messages.first.body, "address": messages.first.address};
  }

  sendSMS(String address, String msg) async {
    List<SimCard> card = await provider.getSimCards();
    SmsMessage message = new SmsMessage(address, msg);
    sender.sendSms(message, simCard: card[0]);
  }
}
