import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart' as gett;
import 'package:untitled3/componants/custom_snackbar.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/helper/cache_helper.dart';
import 'package:untitled3/helper/network/dio_integration.dart';
import 'package:untitled3/helper/network/error_handler.dart';
import 'package:untitled3/model/info_model.dart';

import '../model/user_moddel.dart';
import '../screens/home/home.dart';

class AuthServices {
  final cloud = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final dio = DioUtilNew.dio;

  addUserToDb(UserModel userMModel) async {
    await cloud
        .collection('Users')
        .doc(auth.currentUser!.uid.toString())
        .set(userMModel.toJson());
  }

  updateUserToDb(UserModel userMModel) async {
    await cloud
        .collection('Users')
        .doc(auth.currentUser!.uid.toString())
        .update(userMModel.toJson());
  }

  // Future<UserModel> getUserData() async {
  //   final x = await cloud.collection('Users').doc(auth.currentUser!.uid).get();
  //   return UserModel.fromJson(x);
  // }

  Future<UserModel?> getUserData({String? phone}) async {
    UserModel? user;
    final data =
        await cloud.collection('Users').where("phone", isEqualTo: phone).get();
    if (data.docs.isNotEmpty) {
      user = UserModel.fromJson(data.docs.first);
      print(user.toJson());
    }
    return user;
  }
 getSaferData( ) async {
   try {
     final response = await dio!.get(AppConstants.getSaferData);

     if (response.statusCode == 200) {
       print(response.data);
       return InfoModel.fromJson(response.data);
     } else {
       print('Failed to fetch : ${response.statusCode}');
       throw Exception(
           'Failed to fetch info  . Status code: ${response.statusCode}');
     }
   } catch (error) {
     print('An error occurred: $error');
     throw Exception('An error occurred: $error');
   }

  }

  Future deleteData(id) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(auth.currentUser!.uid)
        .collection('listOfItems')
        .doc(id)
        .delete()
        .then((value) {
      // getHistory();
    });
  }

  Future<String?> uploadImage({File? file}) async {
    try {
      FormData data = FormData.fromMap({
        "photo": MultipartFile.fromBytes(file!.readAsBytesSync(),
            filename: file.path.split("/").last)
      });
      final response = await dio!.post(AppConstants.uploadImage, data: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        showCustomSnackBar(
            message: "Success to upload", isError: false, isInfo: true);
        print(response.data);
        return response.data["data"];
      }
    } catch (e) {
      if (e is DioErrorType) {
        HandleError.handleExceptionDio(e);
      }
    }
  }


  deleteDataFromDatbase()async{

    String uid = FirebaseAuth.instance.currentUser!.uid;

// Delete the document
    await FirebaseFirestore.instance.collection('Users').doc(uid).delete();

       await cloud.collection('Tickets')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete().then((value) {
         deleteuser();
       // gett. Get.snackbar('','تم الحذف بنجاح'.tr);
      showCustomSnackBar(message:'تم الحذف بنجاح' ,isInfo: false,isError: false);

  }).catchError((error) =>      showCustomSnackBar(message: 'خطأ في حذف الحساب : ',isInfo: false,isError: true));


   }


  deleteuser() async {
    try {
     // gett.Get.back();

      CacheHelper.clearData();
      CacheHelper.removeData(key: AppConstants.phone);
      CacheHelper.removeData(key: AppConstants.idUser);
      final user=  FirebaseAuth.instance.currentUser;
      print('%%%%%%%%%%%%%${user!.phoneNumber}');
      user.delete().then((value) async {
      // await   deleteDataFromDatbase();
        gett. Get.snackbar(' ', 'تم الحذف بنجاح'.tr);
        gett.Get.offAll(() => const Home());

      });


    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
      }
    }
    gett. Get.back();

  }


}
