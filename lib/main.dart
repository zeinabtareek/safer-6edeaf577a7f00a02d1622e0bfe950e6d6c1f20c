import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:untitled3/const/app_conss.dart';
import 'package:untitled3/model/trip_model.dart';
import 'package:untitled3/screens/splash_screen/splash_screen.dart';
import 'package:untitled3/screens/trip_info_screen/trip_info_screen.dart';
import '../helper/get_di.dart' as di;
import 'package:intl/date_symbol_data_local.dart';
import 'const/style.dart';
import 'helper/cache_helper.dart';
import 'model/cities_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //     appId: '1:892619011899:android:8920a57521fb07d253a91e',
  //     apiKey: 'AIzaSyAxB29xDGq0aM4VfbbBXJo20vebkPkMFpU',//json file
  //     messagingSenderId: '892619011899',
  //     projectId: 'safer-1cc9d',
  //     storageBucket: 'safer-1cc9d.appspot.com',
  //    ),
  // );
  await Firebase.initializeApp();
  await CacheHelper.init();
  await FirebaseAppCheck.instance.activate();
  FirebaseFirestore.setLoggingEnabled(true);
  initializeDateFormatting("ar_SA");
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(460, 847),
        builder: (BuildContext, Widget) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return GetMaterialApp(
            theme: K.appTheme,
            fallbackLocale: Locale('ar'),
            debugShowCheckedModeBanner: false,
            // home: TripInfoScreen(isTrip: true, tripDetails: ''),
            home: SplashScreen(),
          );
        });
  }
}



class HomeScreen extends StatelessWidget {
  final List<Tab> tabs = [
    Tab(text: 'Tab 1'),
    Tab(text: 'Tab 2'),
   ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Example'),
          bottom: TabBar(
            indicatorColor:K.primaryColor,

            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Tab 1 content')),
            Center(child: Text('Tab 2 content')),
           ],
        ),
      ),
    );
  }
}
///
class CustomDropDown extends StatelessWidget {
  String hint;
  List<CityData> listOfItems;
  final CityData? type;

  void Function(CityData?)? onSaved;
  void Function(CityData?)? onChanged;

  CustomDropDown({
    Key? key,
    required this.hint,
    required this.type,
    required this.listOfItems,
    required this.onSaved,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: DropdownButtonFormField2<CityData>(
        isExpanded: true,
        value: type,
        decoration: InputDecoration(
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
            color:  K.primaryColor,
              width: 1, // Set the focused border width here
            ),

          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color:  K.primaryColor,
              width: 1, // Set the focused border width here
            ),

          ),
          filled: true,
          fillColor: K.lightMainColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),

          ),
        ),
        hint: Center(
          child: Text(
            hint,
            style: TextStyle(fontSize: 14, color: K.primaryColor),
          ),
        ),
        items: listOfItems
            .map((item) => DropdownMenuItem<CityData>(
                  value: item,
                  // value: item.city,
                  child: Center(
                    child: Text(
                      item.city.toString(),
                      style: TextStyle(fontSize: 14, color: K.primaryColor,fontWeight: FontWeight.w400),
                    ),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select Value';
          }
          return null;
        },
        onChanged: onChanged,
        onSaved: onSaved,
        buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
            decoration: K.boxDecorationLightBg),
        iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down, color: K.primaryColor),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: K.primaryColor,
              width: 1, // Set the border width here
            ),
          ),

        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}


