import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'cache_helper.dart';
import 'network/dio_integration.dart';


final instance = GetIt.instance;

Future<Map<String, Map<String, String>>> init() async {
  await CacheHelper.init();
  await Firebase.initializeApp();

  DioUtilNew.getInstance();
  Map<String, Map<String, String>> languages = {};
  return languages;
}
