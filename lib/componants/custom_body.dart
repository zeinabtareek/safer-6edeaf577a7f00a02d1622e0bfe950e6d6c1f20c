import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/style.dart';

class CustomBody extends StatelessWidget {
  const CustomBody({
    super.key,
    required this.body,
    required this.isLoadoing,
    required this.appBarText,
  });

  final Widget body;
  final RxBool isLoadoing;
  final   appBarText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent  ,
        title: Text(
       appBarText,
        style: K.blackText,
    ),
    ),
    body:Stack(children: [ Padding(
      padding: K.fixedPadding,
      child:  body

    ),
      Obx(()=>isLoadoing.value? Container(height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        color: K.blackColor.withOpacity(.1),
        child: Center(child: CircularProgressIndicator(color: K.primaryColor,)),
      ):SizedBox())
    ],));
  }
}