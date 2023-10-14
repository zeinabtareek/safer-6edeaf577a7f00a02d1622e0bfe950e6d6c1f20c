import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:untitled3/screens/create_account_screen/create_account_screen.dart';

import '../../../componants/custom_snackbar.dart';
import '../../../const/app_conss.dart';
import '../../../controller/language_controller.dart';
import '../../../helper/cache_helper.dart';
import '../../../model/cities_model.dart';
import '../../../model/days_model.dart';
import '../../../model/search_model.dart';
import '../../../model/user_moddel.dart';
import '../../../services/auth_services.dart';
import '../../../services/home_services.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../account_screen/account_screen.dart';
import '../../language_screen/language_screen.dart';
import '../../order_status_screen/controller/order_status_controller.dart';

class HomeScreenController extends GetxController {
  final dateTime = DateTime.now().obs;
  final dateTimeShip = DateTime.now().obs;
  Rxn newTime = Rxn<DateTime>();
  Rxn newTimeShip = Rxn<DateTime>();
  final selectedValue = ''.obs;
  final selectedTripFromValue = ''.obs;
  final selectedTripToValue = ''.obs;

  //  final selectedValue = ''.obs;
  // final selectedValue = ''.obs;
  final services = HomeServices();
  final listOfDays = <DayData>[].obs;
  final listOfCitiesBe4 = <CityData>[].obs;
  final listOfCities = <CityData>[].obs;
  final selectedCityFrom = CityData().obs;
  final selectedCityTo = CityData().obs;
  final selectedCityShippingTo = CityData().obs;
  final selectedCityShippingFrom = CityData().obs;
  final isSearching = false.obs;
  final dayId = 1.obs;
  SearchData searchModel = SearchData();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final User? user;

  Future<DateTime?> showCalender({required BuildContext context}) async
  {
    DateTime currentDate = DateTime.now();
    DateTime lastDate = currentDate.add(Duration(days: 365));

    DateTime? selectedDate =
    await showDatePicker(
        context: context,
        // lastDate: DateTime(2),
        // firstDate: DateTime.now(),

        firstDate: currentDate,
        lastDate:lastDate,
        initialDate: dateTime.value,
      );
    return selectedDate;
  }
  Future<DateTime?> showCalenderShip({required BuildContext context}) async {
    DateTime currentDate = DateTime.now();
    DateTime lastDate = currentDate.add(Duration(days: 365));

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: dateTimeShip.value,
      firstDate: currentDate,
      lastDate:lastDate,
    );

    return selectedDate;
  }
 final co=Get.put(LocalizationController());

  final lan=false.obs;


  @override
  onInit()async  {
    super.onInit();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    user = _auth.currentUser;
    getUser(phone:CacheHelper.getData(key: AppConstants.phone));
    lan.value=co.isLtr;

    getCities();
    getDays();
  }

  getCities() async {
    isSearching.value = true;
    final list = await services.getCities();
    listOfCities.value = list;
    getDaysWithChoose(listOfCities.value);
    isSearching.value = false;
  }







  String chooseADay = 'choose_place'.tr;
  RxList   newList=[].obs;
  final dropdown1Options =[].obs;
  final dropdown2Options = [].obs;
  final  dropdown3Options =[].obs;

  getDaysWithChoose(List x) {
    var city = CityData(city: chooseADay, id: 00);
    x.insert(0, city);
    selectedCityFrom.value = x.first;
    selectedCityTo.value = x.first;
    selectedCityShippingFrom.value = x.first;
    selectedCityShippingTo.value = x.first;
    // selectedCityTo.value = x.first;
    for(int i=0;i<x.length;i++){
      if(i+1<x.length) {
        print(x[i + 1]);
        newList.add(x[i+1]);
      }

     }

      //
      // dropdown1Options.value = List.from(newList.value);
      // dropdown2Options.value = List.from(newList.value);
      //  dropdown3Options.value = List.from(newList.value);

    print('x ${x.length}' );
    // print('newList ${newList.length}');
  }


  // String? dropdown1Value;
  // String? dropdown2Value;
  // String? dropdown3Value;

  void updateDropdownOptions(CityData selectedValue) {
    listOfCities.remove(selectedValue);
  }



  getDays() async {
    listOfDays.value = await services.getDays();
    print(listOfDays.length);
  }

  validateSearch({
    String? type,
    required newTime,
    required to,
    required from,
    required fromId,
    required dayId,
    required toId,
  }) {
    if (from == chooseADay || to == chooseADay) {
      showCustomSnackBar(message: 'error_select_destination'.tr, isInfo: true,isError:false );

    } else if (newTime.value == null) {
      showCustomSnackBar(message: 'error_select_date'.tr, isInfo: true,isError:false );

    } else {

      search(
        type: type,
        newTime: newTime,
        to: to,
        from: from,
        fromId: fromId,
        dayId: dayId,
        toId: toId,
      );
    }
  }



  // validateShipmentSearch({
  //   String? type,
  //   required newTime,
  //   required to,
  //   required from,
  //   required fromId,
  //   required dayId,
  //   required toId,
  // }) {
  //   if (from == chooseADay || to == chooseADay) {
  //     showCustomSnackBar(message: 'يرجى تحديد الوجهه من و إلي', isInfo: true,isError:false );
  //
  //   } else if (newTime.value == null) {
  //     showCustomSnackBar(message: 'يرجى تحديد التاريخ', isInfo: true,isError:false );
  //
  //   } else {
  //     search(
  //       type: type,
  //       newTime: newTime,
  //       to: to,
  //       from: from,
  //       fromId: fromId,
  //       dayId: dayId,
  //       toId: toId,
  //     );
  //   }
  //
  //
  // }
  final authServices = AuthServices();
  UserModel? userModel;
  getUser({String? phone}) async {
    userModel = await authServices.getUserData(phone: phone);
    print(    "__________________________________________________gggg${userModel?.phone}");
    print(    "__________________________________________________gggg${userModel?.nationalID}");
    // if (userModel?.phone == null) {
    // } else {
    //   emailController.text = userModel?.email ?? "";
    //   idController.text = userModel?.nationalID ?? "";
    //   nameController.text = userModel?.name ?? "";
    // }
  }

  search({
    String? type,
    required newTime,
    required to,
    required from,
    required fromId,
    required dayId,
    required toId,
  }) async {
    isSearching.value = true;

    if (user?.uid != null) {
      //selectedCityShippingTo

      if(  userModel?.nationalID==null
          ||userModel?.nationalIdBack==null ||
          userModel?.nationalIdFront==null
      || userModel?.nationalID==''
          ||userModel?.nationalIdBack=='' ||
          userModel?.nationalIdFront==''
      ) {
        isSearching.value = false;

        Get.to(CreateAccountScreen());
      }else{

        await services.search(
          from: from,
          to: to,
          // from: selectedCityFrom.value.city,
          // to:selectedCityTo.value.city ,
          date: newTime,
          type: type,
          // type: type,
          // fromId: selectedCityFrom.value.id,
          // toId: selectedCityTo.value.id,
          toId: toId,
          fromId: fromId,
          dayId: dayId);

      isSearching.value = false;
    }
    }
      else {
      isSearching.value = false;


      Get.to(AccountScreen());
    }
  }

  showLocaleDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) => const LanguageScreen());
  }
}
