
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/helper/cache_helper.dart';

import '../const/app_conss.dart';
import '../helper/network/dio_integration.dart';
import '../model/language_model.dart';
import 'base_controller.dart';

class LocalizationController extends BaseController {
  LocalizationController() {
    loadCurrentLanguage();
  }

  final _locale = Locale(AppConstants.languages[0].languageCode!,
          AppConstants.languages[0].countryCode)
      .obs;
  final _isLtr = true.obs;
  final _languages = <LanguageModel>[].obs;

  Locale get locale => _locale.value;

  bool get isLtr => _isLtr.value;

  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale.value = locale;
    if (_locale.value.languageCode == 'ar') {
      _isLtr.value = false;

    } else {
      _isLtr.value = true;

    }
    saveLanguage(_locale.value);
    update();
  }

  void loadCurrentLanguage() async {
    _locale.value = Locale(
        CacheHelper.getData(key: AppConstants.languageCode) ??
            AppConstants.languages[0].languageCode!,
        CacheHelper.getData(key: AppConstants.countryCode) ??
            AppConstants.languages[0].countryCode);
    _isLtr.value = _locale.value.languageCode != 'ar';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode ==
          _locale.value.languageCode) {
        _selectedIndex.value = index;
        break;
      }
    }
    _languages.value = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void saveLanguage(Locale locale) async {
    CacheHelper.saveData(
        key: AppConstants.languageCode, value: locale.languageCode);
    CacheHelper.saveData(
        key: AppConstants.countryCode, value: locale.countryCode!);
    print(CacheHelper.getData(key: AppConstants.languageCode));
    DioUtilNew.setDioAgain();
  }

  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  void setSelectIndex(int index) {
    _selectedIndex.value = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages.value = [];
      _languages.value = AppConstants.languages;
    } else {
      _selectedIndex.value = -1;
      _languages.value = [];
      for (var language in AppConstants.languages) {
        if (language.languageName!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          _languages.add(language);
        }
      }
    }
    update();
  }

  changeLanguage(int index) {
    setLanguage(Locale(
      AppConstants.languages[index].languageCode!,
      AppConstants.languages[index].countryCode,
    ));
    setSelectIndex(index);
  }
}
