import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms/sms.dart';
import 'package:wiki/service/fetch.dart';

class SMSController extends GetxController {
  Fetch fetch = Fetch();
  SmsQuery query = new SmsQuery();
  SimCardsProvider provider = new SimCardsProvider();
  SmsSender sender = new SmsSender();

  readSms() async {
    List<SmsMessage> messages = await query.getAllSms;
    var data = {"body": messages.first.body, "address": messages.first.address};
    toast(data["body"]);
    return data;
  }

  sendSMS(String address, String msg) async {
    List<SimCard> card = await provider.getSimCards();
    SmsMessage message = new SmsMessage(address, msg);
    sender.sendSms(message, simCard: card[0]);
  }

  toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  entMethod() async {
    await readSms().then((value) {
      print(value);
    });
  }
}
