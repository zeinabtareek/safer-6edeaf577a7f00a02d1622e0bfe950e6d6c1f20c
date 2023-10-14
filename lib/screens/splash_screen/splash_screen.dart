import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/app_assets.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(SplashController());

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(AppAssets.splashLogo,fit: BoxFit.fill,height: MediaQuery.of(context).size.height/2.4,),
          ],
        ),
      ),
    );
  }
}
