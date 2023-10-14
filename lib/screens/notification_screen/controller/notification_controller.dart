import 'package:get/get.dart';
import 'package:untitled3/model/messages_model.dart';
import 'package:untitled3/screens/notification_screen/services/notification_services.dart';

class NotificationController extends GetxController {
  final service = NotificationServices();
  final messages = <MessagesModel>[].obs;
  final loading = false.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    loading.value = true;
    messages.assignAll(await service.getAllMessages());
    print(messages.length);
    loading.value = false;
  }


  getMessage()async{
    loading.value = true;
    messages.assignAll(await service.getAllMessages());
    print(messages.length);
    loading.value = false;
  }
}
