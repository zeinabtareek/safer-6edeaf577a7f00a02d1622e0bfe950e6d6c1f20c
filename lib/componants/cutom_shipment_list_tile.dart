import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/style.dart';
import '../model/search_model.dart';

class CustomShipmentListTile extends StatelessWidget {
   bool isClicked;
   Trips ?trips;
   CustomShipmentListTile({Key? key,required this.isClicked,required this.trips}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(right: 8.0.w, left: 8.w),
    child:  Card(
      elevation: 4,
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: K.greyColor.withOpacity(.5),
          width: 1.0,
        ),

      ),
      color:isClicked? K.lightMainColor:K.whiteColor,
      child: Container(
        // decoration: K.boxDecoration,
        margin: EdgeInsets.only(top: 10.w,bottom: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Expanded(
              child : Center(
                child: Text(trips!.time??'',
                  style: isClicked?K.semiblackText:K.primaryTextStyle,
                ),

            ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: K.primaryColor,
                      width: 1.0, // Adjust the width of the border as needed
                    ),
                  ),
                ),
                child:  Center(
                  child: Text(trips!.agency!.agencyName??'',
                     textDirection: TextDirection.rtl,

                    style: isClicked?K.semiblackText:K.primaryTextStyle,

                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
