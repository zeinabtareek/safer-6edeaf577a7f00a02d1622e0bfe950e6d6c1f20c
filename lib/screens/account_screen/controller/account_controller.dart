import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/screens/home/controller/home_controller.dart';
import 'package:untitled3/screens/profile/profile_screen.dart';

import '../../../componants/custom_snackbar.dart';
import '../../../helper/cache_helper.dart';
import '../../../model/user_moddel.dart';
import '../../../services/auth_services.dart';
import '../../create_account_screen/create_account_screen.dart';
import '../../home/home.dart';
import '../componants/otp_dialog.dart';

class AccountController extends GetxController {
  String countryDialCode = CountryCode.fromCountryCode("BD").dialCode ?? '';
  final CarouselController carouselController = CarouselController();
  final currentImageIndex = 0.obs;
  final phoneController = TextEditingController();
  final pinController = TextEditingController();

  final isLoading = false.obs;
  AuthServices services = AuthServices();
  UserModel? userModel;

  // @override
  // onInit() async {
  //   super.onInit();
  //   // await getUser(phone: CacheHelper.getData(key: AppConstants.phone) ?? "");
  // }

  showOtpDialog(validation) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) => OtpDialog(validation: validation));
  }

  onCountryChanged(
      CountryCode countryCode, TextEditingController valueController) {
    //onInit
    countryDialCode = countryCode.dialCode.toString();
    valueController.text = countryDialCode;
  }

  String? verification;
  var userId;

  validation(phone) {
    if (phoneController.text == '') {
      showCustomSnackBar(message: 'error_phone_invalid'.tr, isError: true);
    } else {
      sendVerificationCode(phone: phone);
    }
  }

  Future<void> sendVerificationCode({phone}) async {
    try {
      isLoading.value = true; // Start loading

      await FirebaseAuth.instance.verifyPhoneNumber(
        // phoneNumber: '+201112526645' ?? "",
        phoneNumber: '$phone' ?? "",
        verificationCompleted:  (PhoneAuthCredential phoneAuthCredentials) async {
          isLoading.value = true; // Start loading
          await FirebaseAuth.instance
              .signInWithCredential(phoneAuthCredentials)
              .then((value) {
            if (value.user != null) {
              print("user verified");
            } else {
              print('failed');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          // Get.back();
          Get.defaultDialog(
              content: const Text(''), title: 'error_phone_invalid'.tr);
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          verification = verificationId;
          // Get.back();
          showOtpDialog(verification);
          await CacheHelper.saveData(key: AppConstants.phone, value: phone);

          // showOtpDialog(Get.context ,verificationId:);
          // Get.to(() => VerificationScreen(verification:verification.toString(),name:name,phone:phone));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verification = verificationId;
        },
        timeout: const Duration(minutes: 1),
      );
    } catch (error) {
      showCustomSnackBar(message: '$error', isError: true);
    } finally {
      isLoading.value = false; // Stop loading
    }
    update();
  }

  Future<void> verifyCode(String verification) async {
    isLoading.value = true; // Start loading

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verification ?? "",
        smsCode: pinController.text,
      );

      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = authResult.user;

      if (user != null) {
        // if (authResult.additionalUserInfo!.isNewUser == true) {
        // New user
        String? deviceToken = await FirebaseMessaging.instance.getToken();
        UserModel newUser = UserModel(
          name: '',
          deviceToken: deviceToken,
          phone: phoneController.text,
          id: user.uid,
        );
        await CacheHelper.saveData(key: AppConstants.token, value:  user.uid);

        userModel = await services.getUserData(phone: phoneController.text);
        if (userModel?.phone == phoneController.text) {
          CacheHelper.saveData(
              key: AppConstants.phone, value: phoneController.text);
          Get.offAll(() => const Home());
         } else {
          await addUser(newUser);
          await CacheHelper.saveData(
              key: AppConstants.idUser, value: newUser.id);
          await CacheHelper.saveData(
              key: AppConstants.deviceToken, value: deviceToken);
        }
        await CacheHelper.saveData(
            key: AppConstants.phone, value: userModel!.phone);
        await CacheHelper.saveData(
            key: AppConstants.idUser, value: userModel!.id);
        await CacheHelper.saveData(key: AppConstants.token, value: user.uid);

      }
    } catch (e) {
      // Handle any errors that occur during the authentication process
      print('Authentication failed: $e');

      // showCustomSnackBar(message: errorMessage,isError: true);
      // print('Authentication failed: $e');
      // String errorMessage = 'Authentication failed. Please try again.';
      // if (e is FirebaseAuthException) {
      //   errorMessage = e.message ?? errorMessage;
      // }
      // showCustomSnackBar(message: errorMessage,isError: true);


    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  addUser(UserModel userModel) async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection('Users');
    final newTicketRef = await userRef.doc(FirebaseAuth.instance.currentUser!.uid).set(userModel.toJson());
    // String ticketId = newTicketRef.id; // Get the document ID
    // userModel.id = ticketId; // Assign the document ID to the ticketModel
    // await newTicketRef
    //     .set(userModel.toJson()); // Update the document with the ticketModel
    await CacheHelper.saveData(key: AppConstants.phone, value: userModel.phone);
    print(CacheHelper.getData(key: AppConstants.phone));
    await CacheHelper.saveData(key: AppConstants.idUser, value: userModel.id);
    Get.to(() => const CreateAccountScreen());
    // await getUser(phone: userModel.phone);
  }

  /// two function copy mn Verify Code , and send Verification  bss 3shan ana at5n2t
// Future<void> sendVerificationCodeToReAuthenticate({phone}) async {
//   await FirebaseAuth.instance.verifyPhoneNumber(
//     phoneNumber:  phone ?? "",
//     // phoneNumber: countryDialCode+phone ?? "",
//     verificationCompleted: (PhoneAuthCredential phoneAuthCredentials) async {
//       await FirebaseAuth.instance
//           .signInWithCredential(phoneAuthCredentials)
//           .then((value) {
//         if (value.user != null) {
//           print("user verified");
//         }
//         else
//         {  print('failed');
//         }
//         Get.back();
//       });
//       Get.back();
//     },
//     verificationFailed: (FirebaseAuthException e) {
//       Get.back();
//       Get.defaultDialog(
//           content: Text(e.code.tr) ,title: 'تعذر الإتصال بالإنترنت'
//       );
//       print(e.message);
//     },
//     codeSent: (String verificationId, int? resendToken) {
//       verification = verificationId;
//       Get.back();
//       // showOtpDialog();
//       // showDialog(
//       //     context: Get.context!,
//       //     builder: (BuildContext context) {
//       //       return  VerifyDialog(verification:verification.toString(),phone:phone);
//       //
//       //     });
//       // Get.back();
//       // Get.to(() => VerificationScreen(verification:verification.toString(),name:name,phone:phone));
//
//     },
//     codeAutoRetrievalTimeout: (String verificationId) {
//       verification = verificationId;
//     },
//
//     timeout: Duration(minutes: 1),
//
//   );
//
// }
//
// Future<void> verifyCodeToReAuthenticate(verification,phone1) async {
//   PhoneAuthCredential credential = await PhoneAuthProvider.credential(
//       verificationId: verification ?? "",
//       smsCode: pinController.text);
//   // Get.back();
//
//   await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
//   //  await moreInfoController.deleteDataFromDatbase();
//   // await moreInfoController.deleteuser();
//   // await moreInfoController.deleteFun();
//   print('User successfully reauthenticated.');
//
//
// }

  ///
  ///
  ///
  ///
  ///
}
