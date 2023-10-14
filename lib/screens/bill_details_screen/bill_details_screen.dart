import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../componants/custom_btn.dart';
import '../../componants/custom_text_field.dart';
import '../../const/style.dart';
import '../../data.dart';
import '../../main.dart';

class BillDetailsScreen extends StatelessWidget {
  const BillDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('details'.tr,
          style: K.blackText,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: K.blackColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: K.fixedPadding,
        margin: K.fixedPadding,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: K.blackColor)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Your Payment Details',style: K.semiblackText,)),
            K.sizedboxH,
            Text('Name on Card',style: K.semiblackText,),
            CustomTextField(
              label: '',
              hint: " John Smith",
              prefixIcon: Icon(Icons.check_circle_outline,color: Colors.green,),
              type: TextInputType.number,
              onChange: (v) {
                // _loginController.email=v;
              },
            ),
  K.sizedboxH,
             Text('Card Number',style: K.semiblackText,),
            CustomTextField(
              label: '',
              hint: "**** **** **** ****",
              prefixIcon: Icon(Icons.credit_card_sharp,color: K.mainColor,),
              // icon: Icon(Icons.credit_card_sharp),
              type: TextInputType.number,
              onChange: (v) {
                // _loginController.email=v;
              },
            ),
            K.sizedboxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expiry Date'),
                K.sizedboxW,
                Text('CVV'),
                K.sizedboxW
              ],
            ),
            K.sizedboxH,

            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: K.boxDecoration,


                    child: Center(
                      child: DropdownButton<String>(underline: SizedBox(),
                        icon:  SizedBox(),
                        // icon: Icon(Icons.arrow_drop_down,color: K.greyColor.withOpacity(.5),),
                        value: '12 -Aug',
                        // isExpanded: t,
                        items: <String>['12 -Aug', 'B', 'C', 'D'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                ),
                K.sizedboxW,
                Expanded(
                  child: Container(
                    decoration: K.boxDecoration,


                    child: Center(
                      child: DropdownButton<String>(underline: SizedBox(),
                        icon:  SizedBox(),
                        // icon: Icon(Icons.arrow_drop_down,color: K.greyColor.withOpacity(.5),),
                        value: '2024',
                        // isExpanded: t,
                        items: <String>['2024', 'B', 'C', 'D'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                ),
                K.sizedboxW,
                Expanded(child:  Container(
                    decoration: K.boxDecoration,

                    height: 50.h,
                    child:Center(
                      child: Text('512'),
                  ),
                )),
                
              ],
            ),K.sizedboxH,
            Button(
                color:Colors.green,
                text: ' Pay Now'.tr,
                size: MediaQuery.of(context).size.width / 1.w,
                height: MediaQuery.of(context).size.width / 11.h,
                isFramed: false,
                fontSize: 22.sp,
                onPressed: () async {
                  // Get.to(const CreateAccountScreen());
                }),


          ],
        ),
      ),
    );

  }
}
