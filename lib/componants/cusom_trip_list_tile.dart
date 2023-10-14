import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled3/model/search_model.dart';

import '../const/style.dart';

class CustomTripListTile extends StatelessWidget {
  bool isClicked;
  Trips? model;

  CustomTripListTile({Key? key, required this.isClicked, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0.w, left: 8.w),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: K.greyColor.withOpacity(.5),
            width: 1.0, // Adjust the width of the border as needed
          ),
        ),
        color: isClicked ? K.lightMainColor : K.whiteColor,
        child:
            Container(
              margin: EdgeInsets.only(top: 10.w,bottom: 10.w),
              // margin: K.fixedPadding,

              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "${model?.price!}دينار ",
                        style: isClicked ? K.semiblackText : K.primaryTextStyle,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: K.primaryColor,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        model!.time ?? '',
                        // child: Text('14:00',
                        style: isClicked ? K.semiblackText : K.primaryTextStyle,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: K.primaryColor,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        model!.agency!.agencyName ?? '',
                        // child:  Text('اسم مكتب السفرياتاسم مكتب السفرياتاسم مكتب السفريات',
                        textDirection: TextDirection.rtl,

                        style: isClicked ? K.semiblackText : K.primaryTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///^^^^^^^^^^^

      ),
    );
  }
}
