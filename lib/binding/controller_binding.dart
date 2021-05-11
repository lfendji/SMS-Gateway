import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:wiki/controller/controller.dart';

class ControllerBindging implements Bindings {
  @override
  void dependencies() {
    Get.put(SMSController());
  }
}
