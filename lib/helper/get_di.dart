import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../const/app_conss.dart';
import '../controller/language_controller.dart';
import '../model/language_model.dart';
import 'cache_helper.dart';
import 'network/dio_integration.dart';


final instance = GetIt.instance;

Future<Map<String, Map<String, String>>> init() async {
  await CacheHelper.init();
  await Firebase.initializeApp();

  DioUtilNew.getInstance();

  Get.lazyPut(() => LocalizationController(), fenix: true);
  DioUtilNew.getInstance();

  // Controller
  // Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
