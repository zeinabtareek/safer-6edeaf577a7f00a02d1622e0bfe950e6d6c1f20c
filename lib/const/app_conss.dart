import '../model/language_model.dart';
import 'app_assets.dart';

class AppConstants {
  static const String baseurl = "https://safer.arrowscars.com";
  static const String getCitiesUrl = "/api/get-cities";
  static const String getDayssUrl = "/api/get-days";
  static const String getAgencies = "/api/get-agencies";
  static const String uploadImage = "/api/auth/upload/image";
  static const String search = "/api/search";
  static const String token = 'token';
  static const String phone = 'phone';
  static const String nationalID = 'nationalID';
  static const String idUser = 'idUser';
  static const String deviceToken = 'deviceToken';
  static const String firebaseUser = '/api/firebase-user';
  static const String getSaferData = '/api/get-info';
  static const String setTicket = '/api/set-ticket';
  static const String languageCode = 'language_code';
  static const String countryCode = 'country_code';

  static const String chooseLanguage = 'choose_language';
  static const String saveLanguage = 'SaveLanguage';
  static const String findLanguage = 'find_language';
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: AppAssets.english,
        languageName: "English",
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: AppAssets.arabic,
        languageName: "Arabic",
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
}
