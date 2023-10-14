import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class K{
  static   Color primaryColor= Color(0xffF36328);
  // static   Color primaryColor= Color(0xffA83901);
  // static   Color primaryColor= Color(0xffA83901);
  static   Color mainColor= Color(0xff006B5D);
  static   Color lightGreenColor= Color(0xff77f8df);
  // static   Color semiDarkRed= Color(0xffdb3243);
  static   Color lightMainColor= Color(0xfffff0e8);
  // static   Color lightMainColor= Color(0xfff8EBE7);
  static   Color greyColor= Color(0xff8a8a8a);
  static   Color blackColor= Colors.black;
  static   Color whiteColor= Colors.white;
  // static const mainColor=Colors.grey;
  // // static const blackColor=Colors.grey;


  static  final sizedboxH=   SizedBox(
    height: 10.h,
  ); static  final sizedboxH1=   SizedBox(
    height: 5.h,
  );
  static  final sizedboxW=   SizedBox(
    width: 20.w,
  );
  static final boxDecoration= BoxDecoration(
    border: Border.all(color: mainColor,width: 1),
    borderRadius: BorderRadius.circular(10),
  );
   static final boxDecorationFilled= BoxDecoration(
     color: mainColor,
    border: Border.all(color: mainColor,width: 1),
    borderRadius: BorderRadius.circular(10),
  );  static final boxDecorationFilledLightGreen= BoxDecoration(
     color: lightGreenColor,
    border: Border.all(color: lightMainColor,width: 1),
    borderRadius: BorderRadius.circular(5),
  );


  static final topRaduis= BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r)),
      color: K.whiteColor);
  static final boxDecorationLightBg= BoxDecoration(
    color: K.lightMainColor,
    borderRadius: BorderRadius.circular(50),
  );  static final boxDecorationLightBg20= BoxDecoration(
    color: K.lightMainColor,
    borderRadius: BorderRadius.circular(20),
  );
  static final boxDecorationLightBgWithBorder=  BoxDecoration(
    color: K.lightMainColor,
    borderRadius: BorderRadius.circular(10.0), // set border radius
    border: Border.all(
      color: K.primaryColor.withOpacity(.8),
      // width: .0, // set border width
    ),
  );
  static final boxDecorationLightGrey= BoxDecoration(
    color: K.lightMainColor,
    borderRadius: BorderRadius.circular(10.0), // set border radius
    border: Border.all(
      color: K.lightMainColor,
      width: 2.0, // set border width
    ),
  );
  // static get appTheme => ThemeData(
  //     colorScheme: _customColorScheme,
  //     appBarTheme: AppBarTheme(
  //         elevation: 0,
  //         centerTitle: true,
  //         foregroundColor: mainColor,
  //         shadowColor: mainColor.withAlpha(50)
  //     ));
  //

  static get appTheme => ThemeData(
      colorScheme: _customColorScheme,
      fontFamily:'Cairo',
      textTheme: const TextTheme(
        // Set the default font family for the app
        bodyText1: TextStyle(fontFamily: 'Cairo-Regular'),
        bodyText2: TextStyle(fontFamily: 'Cairo-Regular'),
        // You can also specify font family for other text styles
        headline1: TextStyle(fontFamily: 'Cairo-Light', fontSize: 24),
        subtitle1: TextStyle(fontFamily: 'Cairo', fontStyle: FontStyle.italic),),
      appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          foregroundColor: blackColor,
          shadowColor: blackColor.withAlpha(50)));

  static final ColorScheme _customColorScheme = ColorScheme(
    primary:primaryColor,
    secondary: primaryColor,
    surface:  mainColor,
    background:  mainColor,
    onError:  blackColor,
    brightness: Brightness.light,
    error: Colors.red,
    onBackground:  blackColor,
    onPrimary: mainColor,
    onSecondary: primaryColor,
    onSurface: primaryColor,
  );
  static final thirdFixedPadding=EdgeInsets.all(5.sp);
  static final fixedPadding=EdgeInsets.all(10.sp);
  static final fixedPaddingOnlyTopAndBottom=EdgeInsets.only(top:10.sp,bottom: 10.sp);
  static final secFixedPadding=EdgeInsets.all(20.sp);

  static final bodyText= TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w200,
  ); static final bodyTextWhite= TextStyle(
    fontSize: 13.sp,
    color: whiteColor,
    fontWeight: FontWeight.w200,
  );
  static final boldBlackText=TextStyle(color:  blackColor,fontWeight: FontWeight.w700,fontSize: 30.sp);
  static final blackText=TextStyle(color:  blackColor,fontWeight: FontWeight.w500,fontSize: 20.sp);//true
  static final semiblackText=TextStyle(color:  blackColor,fontWeight: FontWeight.w500,fontSize: 18.sp);
  static final smallBlackText=TextStyle(color:  blackColor,fontWeight: FontWeight.w500,fontSize: 15.sp);
  static final largeBlackText=TextStyle(color:  blackColor,fontWeight: FontWeight.w600,fontSize: 25.sp);
  static final boldBlackSmallText=TextStyle(color:  blackColor,fontWeight: FontWeight.w600,fontSize: 20.sp);
  static final redTextStyle=TextStyle(color:  Colors.red,fontWeight: FontWeight.w500,fontSize: 18.sp);
  static final primaryTextStyle=TextStyle(color:  primaryColor,fontWeight: FontWeight.w500,fontSize: 15.sp);//true
  static final mainColorTextStyle=TextStyle(color:  mainColor,fontWeight: FontWeight.w500,fontSize: 18.sp);//true
  static final largeMainColorTextStyle=TextStyle(color:  mainColor,fontWeight: FontWeight.w500,fontSize: 20.sp);//true
  static final extraLargeMainColorTextStyle=TextStyle(color:  mainColor,fontWeight: FontWeight.w500,fontSize: 35.sp);//true
  static final whiteTextStyle=TextStyle(color:  whiteColor,fontWeight: FontWeight.w400,fontSize: 15.sp);
  static final semiBoldWhiteTextStyle=TextStyle(color:  whiteColor,fontWeight: FontWeight.w500,fontSize: 15.sp);
  static final boldWhiteTextStyle=TextStyle(color:  whiteColor,fontWeight: FontWeight.w700,fontSize: 18.sp);
  static final boldLargeWhiteTextStyle=TextStyle(color:  whiteColor,fontWeight: FontWeight.w700,fontSize: 15.sp);
  static final boldWhiteSmallTextStyle=TextStyle(color:  whiteColor,fontWeight: FontWeight.w800,fontSize: 14.sp);


}