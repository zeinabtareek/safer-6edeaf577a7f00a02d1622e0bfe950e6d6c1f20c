import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/style.dart';
import '../model/agencies_model.dart';

class CustomDropDown2 extends StatelessWidget {
  String hint;
  List<Data> listOfItems;
  final Data? type;

  void Function(Data?)? onSaved;
  void Function(Data?)? onChanged;

  CustomDropDown2({
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
      child: DropdownButtonFormField2<Data>(
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
            .map((item) => DropdownMenuItem<Data>(
          value: item,
          // value: item.city,
          child: Center(
            child: Text(
              item.agencyName.toString(),
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
