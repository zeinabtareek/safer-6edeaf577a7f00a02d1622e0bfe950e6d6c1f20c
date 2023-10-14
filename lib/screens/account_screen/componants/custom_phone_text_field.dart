
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../const/style.dart';
import 'code_picker.dart';


class CustomPhoneTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final bool isAmount;
  final Function(String text)? onChanged;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final double borderRadius;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool showBorder;
  final String?countryDialCode;
  final double prefixHeight;
  final Color? fillColor;
  final bool prefix;
  final bool suffix;
  final Function()? onPressedSuffix;
  final Function(CountryCode countryCode)? onCountryChanged;


  const CustomPhoneTextField(
      {super.key,
        this.hintText = 'Write something...',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onChanged,
        this.prefixIcon,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.isAmount = false,
        this.borderRadius=50,
        this.showBorder = true,
        this.prefixHeight = 50,
        this.countryDialCode,
        this.onCountryChanged,
        this.fillColor,
        this.prefix=true,
        this.suffix=true, this.suffixIcon, this.onPressedSuffix,
      });

  @override
  State<CustomPhoneTextField> createState() => _CustomPhoneTextFieldState();
}

class _CustomPhoneTextFieldState extends State<CustomPhoneTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: const TextStyle(
          color:Colors.grey, fontSize: 12),
      textInputAction: widget.inputAction,
      keyboardType: (widget.isAmount || widget.inputType == TextInputType.phone) ? const TextInputType.numberWithOptions(
        signed: false, decimal: true,
      ) : widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
          : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
          : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
          : widget.inputType == TextInputType.url ? [AutofillHints.url]
          : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))]
          : widget.isAmount ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))] : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:  BorderSide(width: widget.showBorder? 0.5 : 0.5,
              color: Theme.of(context).hintColor.withOpacity(widget.showBorder?0.5:0.0)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:  BorderSide(width: widget.showBorder? 0.5 : 0.5,
              color: Theme.of(context).primaryColor),
        ),

        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor,
        hintStyle: const TextStyle(
            color:Colors.grey, fontSize: 12),
        filled: true,
        contentPadding:  K.fixedPadding,

        prefixIcon: widget.prefix==false?
        null: widget.prefixIcon!=null ?
        Container(
          margin: EdgeInsets.only(right: widget.fillColor!=null ? 0: 10),
          width: widget.prefixHeight,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color:  widget.fillColor!=null ?Colors.transparent :Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius),
              bottomLeft: Radius.circular(widget.borderRadius),
            ),
          ),
          child: Center(child: Image.asset(widget.prefixIcon!, height: 20, width: 20)),):
        Container(
            width: 70,
            decoration: BoxDecoration(
              color:widget.fillColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                bottomLeft: Radius.circular(widget.borderRadius),
              ),
            ),
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(left: 15),
            child: Center(
              child: CodePickerWidget(
                flagWidth: 25,
                onChanged: widget.onCountryChanged,
                initialSelection: widget.countryDialCode,
                favorite: [widget.countryDialCode!],
                showDropDownButton: true,
                showCountryOnly: true,
                showOnlyCountryWhenClosed: true,
                showFlagDialog: true,
                hideMainText: true,
                showFlagMain: true,
                dialogBackgroundColor: Theme.of(context).cardColor,
                barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
                textStyle:const TextStyle(
                    color:Colors.grey, fontSize: 12),
              ),
            )),
        suffixIcon: widget.suffixIcon!=null?
        GestureDetector(
          onTap: widget.onPressedSuffix != null?
          widget.onPressedSuffix!:null,
          child: Container(
            margin: EdgeInsets.only(right: widget.fillColor!=null ? 0: 10),
            width: 40,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color:  widget.fillColor!=null ?Colors.transparent :Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                bottomLeft: Radius.circular(widget.borderRadius),
              ),
            ),
            child: Center(child: Image.asset(widget.suffixIcon!, height: 20, width: 20)),),
        ) :widget.isPassword ?
        IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.5)),
          onPressed: _toggle,
        ) : null,
      ),
      onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : null,
      onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}