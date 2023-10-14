import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/helper/cache_helper.dart';
import 'package:untitled3/model/info_model.dart';
import 'package:untitled3/model/user_moddel.dart';
import 'package:untitled3/screens/home/home.dart';
import 'package:untitled3/services/auth_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../componants/re_auth.dart';
import '../../../controller/language_controller.dart';

class ProfileController extends GetxController {
  final services = AuthServices();
  UserModel? userModel;
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final isLoading = false.obs;
  final loading = false.obs;
  final co=Get.put(LocalizationController());

  final lan=false.obs;


  @override
  onInit() async {
    super.onInit();
    lan.value=co.isLtr;

    await getUser(phone: CacheHelper.getData(key: AppConstants.phone));
    await getSaferInf0();
  }

  getUser({String? phone}) async {
    userModel = await services.getUserData(phone: phone);
    print(
        "__________________________________________________gggg${userModel?.phone}");
    if (userModel?.phone == null) {
    } else {
      emailController.text = userModel?.email ?? "";
      idController.text = userModel?.nationalID ?? "";
      nameController.text = userModel?.name ?? "";
    }
  }
InfoModel infoModel =InfoModel();
  getSaferInf0( ) async {
    loading.value=true;
    infoModel = await services.getSaferData();

    loading.value=false;
  }


  showDelayReasonDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) => DelayDialog());
  }
  deleteFun()async{
     isLoading.value = true;
      await services.deleteDataFromDatbase();
     CacheHelper.clearData();
     CacheHelper.removeData(key: AppConstants.phone);
     CacheHelper.removeData(key: AppConstants.idUser);
     Get.offAll(() => const Home());
      isLoading.value = false;
  }



  ///new try

  Future<void> deleteDocumentsWithUserId() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Create a reference to the Firestore collection
    CollectionReference<Map<String, dynamic>> collectionRef =
    FirebaseFirestore.instance.collection('Tickets');

    // Create a query to retrieve documents with the matching userId
    Query<Map<String, dynamic>> query =
    collectionRef.where('userId', isEqualTo: currentUserId);

    // Get the documents that match the query
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();

    // Create a batch for deleting the documents
    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Iterate through the documents and add delete operations to the batch
    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
    in querySnapshot.docs) {
      batch.delete(documentSnapshot.reference);
    }

    // Commit the batch to delete the documents
    await batch.commit();
  }
  ///new try





  logOut(BuildContext context) async {
    isLoading.value = true;
    await services.auth.signOut();
    CacheHelper.clearData();
    CacheHelper.removeData(key: AppConstants.phone);
    CacheHelper.removeData(key: AppConstants.idUser);
    Get.offAll(() => const Home());
    isLoading.value = false;
  }


  makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
