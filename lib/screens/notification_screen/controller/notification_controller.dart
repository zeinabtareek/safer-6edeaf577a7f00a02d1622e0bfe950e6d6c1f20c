import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled3/model/messages_model.dart';
import 'package:untitled3/screens/notification_screen/services/notification_services.dart';

import '../../../controller/language_controller.dart';

class NotificationController extends GetxController {
  final service = NotificationServices();
  final messages = <MessagesModel>[].obs;
  final loading = false.obs;
  final co=Get.put(LocalizationController());

  final lan=false.obs;


   @override
 onInit()   async{
     super.onInit();
     SystemChannels.textInput.invokeMethod('TextInput.hide');

     // messages.assignAll(await service.getAllMessages());
     // print(messages.length);
     loading.value = true;
     await   getMessage();
     lan.value=co.isLtr;
     loading.value = false;
   }


  getMessage()async{
    loading.value = true;
    messages.assignAll(await service.getAllMessages());
    print(messages.length);
    loading.value = false;
  }
}
