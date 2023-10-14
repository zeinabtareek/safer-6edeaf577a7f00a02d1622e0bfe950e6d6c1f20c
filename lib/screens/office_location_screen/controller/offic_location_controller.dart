import 'package:get/get.dart';
import 'package:untitled3/model/agencies_model.dart';
import 'package:untitled3/model/days_model.dart';
import 'package:untitled3/model/ticket_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/cities_model.dart';
import '../../../services/home_services.dart';
import 'package:maps_launcher/maps_launcher.dart';

class OfficeLocationController extends GetxController {
  Data selectedValue = Data();
  final services = HomeServices();
  final tickets = <TicketModel>[].obs;
  RxList<CityData> listOfCities = <CityData>[].obs;
  final loading = false.obs;
  AgenciesModel? agenciesModel;

  @override
  onInit() async {
    super.onInit();
    loading.value = true;
    getCities();
    agenciesModel = await services.getAgencies();
    selectedValue=agenciesModel!.data!.first ;
    // tickets.assignAll(await services.getAllTicket());
    loading.value = false;
  }

  getCities() async {
    listOfCities.value = await services.getCities();
    // selectedValue=listOfCities.value.first ;
  }

  openMap({ double? lat,double? long}) async {
    MapsLauncher.launchCoordinates(lat ?? 0.0, long ?? 0.0);
  }

  makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }





}
