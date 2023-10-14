import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled3/screens/create_account_screen/create_account_screen.dart';
import '../../const/app_assets.dart';
import '../../const/style.dart';
import '../account_screen/account_screen.dart';
import '../home_screen/home_screen.dart';
import '../notification_screen/notification_screen.dart';
import '../office_location_screen/office_location_screen.dart';
import '../order_status_screen/order_status_screen.dart';
import 'controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: K.whiteColor,
      body: Obx(() => controller.loading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :
      // controller.connection.connectivity.value == 1
      //         ?
      controller.bodyScreens.elementAt(controller.currentIndex.value)
              // :
              //       Center(
              //         child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         AppAssets.no_connection,
              //         height: 300.h,
              //         width: 300.w,
              //        ),
              //       Text(
              //         'لا يوجد اتصال'.tr,
              //         style: TextStyle(
              //             fontSize: 25.sp,
              //             color: K.primaryColor,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ))

      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          // selectedItem/Color:   K.mainColor,
          elevation: 0,
          unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
          selectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: Colors.grey[400],),
          selectedLabelStyle: const TextStyle(color: Colors.black),
          fixedColor: K.mainColor,
          type: BottomNavigationBarType.fixed,
          // type: BottomNavigationBarType.shifting,
          onTap: (v) async {
            controller.changeTabIndex(v, context);
          },
          currentIndex: controller.currentIndex.value,
          items: [
            for (int i = 0; i < bottomNavBarData.length; i++)
              BottomNavigationBarItem(
                icon: Image.asset(
                  bottomNavBarData[i]['icon'],
                  height: 25.h,
                ),
                label: bottomNavBarData[i]['label'],
                activeIcon: Container(
                  padding: K.fixedPaddingOnlyTopAndBottom,
                  width: 100,
                  decoration: K.boxDecorationLightBg,
                  child: Image.asset(
                    bottomNavBarData[i]['active'],
                    // semanticsLabel: bottomNavBarData[i]['label'],
                    height: 20.h,
                    color: K.mainColor,
                    // fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

List bottomNavBarData = [
  {
    'icon': AppAssets.notification,
    'label': 'الإشعارات'.tr,
    'active': AppAssets.notification
  },
  {
    'icon': AppAssets.location,
    'label': ' المكاتب'.tr,
    'active': AppAssets.location
  },
  {'icon': AppAssets.home, 'label': 'الرئيسيه'.tr, 'active': AppAssets.home},
  {
    'icon': AppAssets.status_icon,
    'label': 'حالة الطلب'.tr,
    'active': AppAssets.status_icon
  },
  {'icon': AppAssets.profile, 'label': 'حسابي'.tr, 'active': AppAssets.profile},


];
