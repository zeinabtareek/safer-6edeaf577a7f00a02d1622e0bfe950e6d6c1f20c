import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/helper/cache_helper.dart';
import 'package:untitled3/screens/create_account_screen/services/create_account_services.dart';
import 'package:untitled3/services/auth_services.dart';
import '../../../componants/change_pic_sheet.dart';
import '../../../model/user_moddel.dart';
import '../model/firebase_user_model.dart';

class CreateAccountController extends GetxController {
  final CarouselController carouselController = CarouselController();
  final currentImageIndex = 0.obs;
  final cloud = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  final services = AuthServices();
  final createUserServices = CreateAccountServices();
  final key=GlobalKey<FormState>();
  UserModel? user;
  final image = ''.obs;
  final image2 = ''.obs;
  final na = ''.obs;
  final nationalIdBack = ''.obs;
  final nationalIdFront = ''.obs;
  final _picker = ImagePicker();
  late String email = '';
  late String nationalId = '';
  late String name = '';

  addAdditionData(name1, id1, email1) {
    email = email1;
    nationalId = id1;
    name = name1;
    print(nationalId);
  }

  Future<void> updateUser({String? id}) async {
    try {
      print(id);
      UserModel updateData = UserModel(
        nationalID: idController.text,
        phone: CacheHelper.getData(key: AppConstants.phone),
        deviceToken: await CacheHelper.getData(key: AppConstants.deviceToken),
        email: emailController.text,
        name: nameController.text,
        id: CacheHelper.getData(key: AppConstants.idUser),
        nationalIdBack: nationalIdBack.value,
        nationalIdFront: nationalIdFront.value,
      );
      await cloud.collection("Users").doc(id!).update(updateData.toJson());
      await addUserToServer( user:updateData);
     await CacheHelper.saveData(key: 'nationalID', value: idController.text,);
    } catch (e) {
      print('Failed to update user: $e');
      throw e;
    }
  }
  addUserToServer({required UserModel user})async {
    FirebaseUserModel userModel=FirebaseUserModel(
      nationalId: idController.text,
      phone: CacheHelper.getData(key: AppConstants.phone),
       name: nameController.text,
      email: emailController.text,
       userId: FirebaseAuth.instance.currentUser!.uid,
       nationalIdBack: nationalIdBack.value,
      nationalIdFront: nationalIdFront.value,
    );
    var x=await createUserServices.addUserToServer(userModel);

    print('x  $x');
  }




  Future<String?> selectImage() async {
    try {
      final XFile? _image =
          await _picker.pickImage(source: ImageSource.gallery);
      if (_image != null) {
        return _image.path;
      }
    } catch (e) {
      print(e.toString());
    }
  }
final loading=false.obs;
  Future<String?> updateImage({String? image}) async {
    loading.value=true;
    final image2 = await services.uploadImage(file: File(image!));
    await CacheHelper.saveData(key: AppConstants.nationalID, value: image2);
    loading.value=false;

     return   image2;
    // return  image2;
  }



}
