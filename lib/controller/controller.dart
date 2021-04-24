import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms/sms.dart';
import 'package:wiki/service/fetch.dart';

class SMSController extends GetxController {
  Fetch fetch = Fetch();
  SmsQuery query = new SmsQuery();
  SimCardsProvider provider = new SimCardsProvider();

  readSms() async {
    List<SmsMessage> messages = await query.getAllSms;
    var data = {"body": messages.first.body, "address": messages.first.address};
    toast(data["body"]);
    return data;
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
    var data;
    await readSms().then((value) {
      data = value;
      print(data);
    });
    // print(data);
    // await fetch.sendData(data).then((value) => print(value));
  }
}
