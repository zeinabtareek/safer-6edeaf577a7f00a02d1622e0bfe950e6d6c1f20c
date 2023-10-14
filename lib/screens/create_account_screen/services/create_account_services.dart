
import 'package:dio/dio.dart';

import '../../../componants/custom_snackbar.dart';
import '../../../const/app_conss.dart';
import '../../../helper/network/dio_integration.dart';
import '../../../helper/network/error_handler.dart';
import '../model/firebase_user_model.dart';

class CreateAccountServices{




  final dio = DioUtilNew.dio;

  //api/firebase-user


  Future<String?> addUserToServer(FirebaseUserModel model) async {
    try {

      final response = await dio!.post(AppConstants.firebaseUser, data: model.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {


        print(response.data);
        return response.data["data"];
      }
    } catch (e) {
      if (e is DioErrorType) {
        HandleError.handleExceptionDio(e);
      }
    }
  }
}