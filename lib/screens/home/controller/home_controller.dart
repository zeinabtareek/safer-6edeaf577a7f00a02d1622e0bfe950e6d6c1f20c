import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/helper/cache_helper.dart';
import 'package:untitled3/model/user_moddel.dart';
import 'package:untitled3/screens/account_screen/account_screen.dart';
import 'package:untitled3/screens/create_account_screen/create_account_screen.dart';
import 'package:untitled3/screens/home_screen/home_screen.dart';
import 'package:untitled3/screens/notification_screen/notification_screen.dart';
import 'package:untitled3/screens/office_location_screen/office_location_screen.dart';
import 'package:untitled3/screens/order_status_screen/order_status_screen.dart';
import 'package:untitled3/screens/profile/profile_screen.dart';
import 'package:untitled3/services/auth_services.dart';
import '../../../helper/connectivity.dart';

class HomeController extends GetxController {
  static HomeController to=Get.find();
  final services = AuthServices();
  final connection = Get.put(ConnectionStatusSingleton());
  final currentIndex = 2.obs;
  final token = "".obs;
  final auth = FirebaseAuth.instance;
  UserModel? userModel;
  final loading = false.obs;
  final bodyScreens = <Widget>[].obs;

  changeTabIndex(int index, BuildContext context) {
    currentIndex.value = index;
    update();
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    loading.value = true;
    await getCurrentUser();
    loading.value = false;
  }




  final authServices = AuthServices();
  getUser({String? phone}) async {
    userModel = await authServices.getUserData(phone: phone);
    print(    "__________________________________________________gggg${userModel?.phone}");
    print(    "__________________________________________________gggg${userModel?.nationalID}");

  }

  getCurrentUser() async {
    print(
        "------------------------------------------------------------------------------------${CacheHelper.getData(key: AppConstants.phone)}");
    print(      "------------------------------------------------------------------------------------${CacheHelper.getData(key: AppConstants.nationalID)}");

    await getUser(phone:CacheHelper.getData(key: AppConstants.phone));
    if (CacheHelper.getData(key: AppConstants.phone) == null) {
      bodyScreens.assignAll([
        const AccountScreen(),
        const AccountScreen(),
        const HomeScreen(),
        const AccountScreen(),
        const AccountScreen(),
      ]);
    } else {
      bodyScreens.assignAll([
        const NotificaionScreen(),
        const OfficeLocationScreen(),
        const HomeScreen(),
        const OrderStatusScreen(),
        CacheHelper.getData(key: AppConstants.phone) == null
            ? const CreateAccountScreen()
            :
        // CacheHelper.getData(key: AppConstants.nationalID) == null?
    (  userModel?.nationalID==null
    ||userModel?.nationalIdBack==null ||
    userModel?.nationalIdFront==null
    || userModel?.nationalID==''
    ||userModel?.nationalIdBack=='' ||
    userModel?.nationalIdFront==''
    ) ?
        const CreateAccountScreen():


        const ProfileScreen()
      ]);
    }
  }
}
