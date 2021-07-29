import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms/sms.dart' as sms;
import 'package:wiki/service/fetch.dart';
import 'package:telephony/telephony.dart';

class SMSController extends GetxController with StateMixin<dynamic> {
  Fetch fetch = Fetch();
  sms.SmsQuery query = new sms.SmsQuery();
  sms.SimCardsProvider provider = new sms.SimCardsProvider();
  final Telephony telephony = Telephony.instance;

  var address = "".obs;
  var isloading = false.obs;
  @override
  void onInit() {
    super.onInit();
    entMethod();
  }

  Future<dynamic> readSms() async {
    List<sms.SmsMessage> messages = await query.getAllSms;
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
    List<sms.SimCard> card = await provider.getSimCards();
    sms.SmsMessage message = new sms.SmsMessage(address, msg);
    sms.SmsSender sender = new sms.SmsSender();
    sender.sendSms(message, simCard: card[0]);
    message.onStateChanged.listen((event) {
      if (event == sms.SmsMessageState.Sent) {
        toast("Envoyer avec succés");
      } else if (event == sms.SmsMessageState.Delivered) {
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
      isloading.value = true;
      await fetch.sendData({
        "address": value["address"].toString(),
        "msg": value["body"].toString()
      }).then((value) async {
        isloading.value = false;

        telephony.sendSms(
            to: value["address"],
            message: value["msg"].toString(),
            isMultipart: true);
      });
    });
  }
}
