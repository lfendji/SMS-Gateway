import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms/sms.dart';
import 'package:wiki/service/fetch.dart';

class SMSController extends GetxController with StateMixin<dynamic> {
  Fetch fetch = Fetch();
  SmsQuery query = new SmsQuery();
  SimCardsProvider provider = new SimCardsProvider();
  var address = "".obs;
  @override
  void onInit() {
    super.onInit();
    entMethod();
  }

  Future<dynamic> readSms() async {
    List<SmsMessage> messages = await query.getAllSms;
    if (messages.first.address.length >= 9) {
      Map data = {
        "body": messages.first.body,
        "address": messages.first.address
      };
      toast(data["body"]);
      address.value = messages.first.address;
      return data;
    } else if (messages.first.address.length < 9) {
      Map data = {"body": "Cet sms n'est pas valide", "address": "test"};
      toast(data["body"]);
      return data;
    } else {
      return {"body": "aucune idée", "address": "fantome"};
    }
  }

  sendSMS(String address, String msg) async {
    List<SimCard> card = await provider.getSimCards();
    SmsMessage message = new SmsMessage(address, msg);
    SmsSender sender = new SmsSender();
    sender.sendSms(message, simCard: card[0]);
    message.onStateChanged.listen((event) {
      if (event == SmsMessageState.Sent) {
        toast("Envoyer avec succés");
      } else if (event == SmsMessageState.Delivered) {
        toast("Message reussi avec succés");
      } else {
        toast("Message n'a pas été envoyé");
      }
    });
  }

  toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  entMethod() async {
    await readSms().then((value) async {
      print(address.value);
      await fetch.sendData({
        "address": value["address"].toString(),
        "msg": value["body"].toString()
      }).then((value) async {
        print(value);
        await sendSMS(address.value, value["result"]);
      });
    });
  }
}
