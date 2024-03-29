
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Button extends StatelessWidget {
  final String text;
  double size = 250;
  double height = 250;
  double? fontSize = 16;
  final bool isFramed;
  final Color color;
  final Color? textColor;
  final Widget? widget;
  final VoidCallback? onPressed;
  Button({
    required this.text,
    required this.size,
    required this.height,
    required this.isFramed,
    this.onPressed,
    this.fontSize,
    this.textColor,
    required this.color,
    this.widget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return InkWell(
      onTap: onPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: size.w,
        height: height.h,
        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
        child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    color !=null ?color:
                    isFramed ? Colors.white : K.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color:textColor!=null?Colors.transparent : isFramed ? K.mainColor : K.mainColor,
                            width: 1)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget??SizedBox(),
                Text(
                  text,
                  style: TextStyle(
                      color:textColor!=null?textColor:isFramed ? K.mainColor : Colors.white,
                      fontSize: fontSize?.sp),
                ),

              ],
            )),
      ),
    );
  }
}
