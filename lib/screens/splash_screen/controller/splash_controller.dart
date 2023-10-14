import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../helper/cache_helper.dart';
import '../../home/home.dart';

class  SplashController extends GetxController{

@override
  Future<void> onInit() async {

 var token=await _saveDeviceToken();

  // String userDeviceToken = await FirebaseMessaging.instance.getToken() ?? "";
  await CacheHelper.saveData(key:"deviceToken", value:token ??'' );
  Timer( Duration(seconds: 5), () async {
          Get.offAll(  Home());
        });
    super.onInit();
  }

 _saveDeviceToken() async {
  String? _deviceToken = '';
  if(Platform.isAndroid) {
    _deviceToken = await FirebaseMessaging.instance.getToken();
  }else if(Platform.isIOS) {
    _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
  }
  if (_deviceToken != null) {
    print('--------Device Token---------- '+_deviceToken);
  }
  return _deviceToken;
}

}