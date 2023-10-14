


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../const/style.dart';
import '../controller/language_controller.dart';

class CustomTextField extends StatelessWidget {
    CustomTextField({Key? key,
    this.hint,
    this.icon,
    this.label,
    this.onChange,
    this.validator,
    this.controller,
    this.heightt,
     this.obSecure=false,
    this.enabled=true,

    this.prefixIcon,
    this.type})
      : super(key: key);
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final String? label;
  final String? hint;
  final Widget? icon;
  final TextInputType? type;
  final bool? obSecure;
  final double? heightt;
  final  Widget ?prefixIcon;
  final bool? enabled;

  final TextEditingController? controller;
  final co=Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:   EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      // height: ,
      margin:   EdgeInsets.symmetric( vertical: 5),
      // height: heightt??60.h,

      child: Obx(()=>Directionality(
    textDirection: co.isLtr?TextDirection.ltr:TextDirection.rtl,
    child:TextFormField(

          controller: controller,
          keyboardType: type,
          onChanged: onChange,
          autofocus: false,
          enabled:  enabled,validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obSecure!,
          decoration: InputDecoration(

              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            filled: enabled==false?true:false,
            // prefixIcon: prefixIcon,
              suffixIcon:prefixIcon ,
              // icon: prefixIcon,
              prefixIcon: icon,
              labelText: label!,

              labelStyle: const TextStyle(
                  color:Colors.grey, fontSize: 12),
              hintStyle: const TextStyle(
                fontSize:14, color: Colors.grey,),
              hintText: hint!,
              border: OutlineInputBorder(

                  // borderSide:   BorderSide(color:K.primaryColor),
                  // borderRadius: BorderRadius.circular(10),
                // u

              ),
              enabledBorder: OutlineInputBorder(
                borderSide:   BorderSide(color:K.greyColor),
                // borderSide:   BorderSide(color:Colors.grey),
                borderRadius: BorderRadius.circular(10),),
              disabledBorder: OutlineInputBorder(
                borderSide:   BorderSide(color:Colors.grey.withOpacity(.2)),
                // borderSide:   BorderSide(color:Colors.grey.shade200),
                borderRadius: BorderRadius.circular(5),),
              focusedBorder: OutlineInputBorder(

                  borderSide:   BorderSide(color:K.primaryColor),
                  borderRadius: BorderRadius.circular(10))



          ),
        ),
      ),
      ),
    );
  }
}
