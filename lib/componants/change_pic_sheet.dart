// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../const/style.dart';
// import '../screens/create_account_screen/controller/create_account_controller.dart';
// import 'custom_btn.dart';
// import 'custom_text_field.dart';
//
// class ChangePicSheet extends StatelessWidget {
//   ChangePicSheet({super.key});
//
//   final controller = Get.put(CreateAccountController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("غير صورتك الشخصية".tr, style: K.boldBlackSmallText
//                     // .copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
//                     ),
//                 IconButton(
//                     onPressed: () => Get.back(), icon: const Icon(Icons.close))
//               ],
//             ),
//             const SizedBox(height: 20),
//             Obx(() => controller.photo.value != null &&
//                     controller.photo.value!.path.isNotEmpty
//                 ? CircleAvatar(
//                     radius: 80,backgroundColor: Colors.white,
//                     backgroundImage:
//                         FileImage(File(controller.photo.value!.path)),
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: FloatingActionButton.small(backgroundColor: Colors.white,
//                           child: const Icon(Icons.delete_outline_outlined),
//                           onPressed: () => controller.photo.value = XFile("")),
//                     ),
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () => controller.pickImage(fromGallery: true),
//                         child: Container(
//                           decoration: K.boxDecorationLightGrey,
//                           padding: K.fixedPadding,
//                           child: Row(
//                             children: [
//                               Text(' من المعرض  '),
//                               Icon(
//                                 Icons.photo_library_outlined,
//                                 color: K.greyColor,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//
//                         decoration: K.boxDecorationLightBgWithBorder,
//                         padding: K.fixedPadding,
//                         child: GestureDetector(
//                           onTap: () => controller.pickImage(fromGallery: false),
//                           child: Row(
//                             children: [
//                               Text(' من الكاميرا  '),
//                               Icon(
//                                 Icons.camera_alt_outlined,
//                                 color: K.greyColor,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   )),
//             const SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0),
//               child:
//                   // Obx(() =>
//                   // Button(
//                   // text: 'update'.tr,
//                   // : controller.photo.value != null &&
//                   //     controller.photo.value!.path.isNotEmpty,
//                   // onTap: () => controller.changeProfilePic(),
//                   // loading: controller.picLoading.value)),
//
//                   Button(
//                       color: K.mainColor,
//                       text: '  إرسال الصورة '.tr,
//                       size: MediaQuery.of(context).size.width / 1.w,
//                       height: MediaQuery.of(context).size.width / 11.h,
//                       isFramed: false,
//                       fontSize: 22.sp,
//                          onPressed: () async {
//                           await controller.uploadImage(image: File(controller.photo.value!.path));
//                         // controller.image.value = (await controller.selectImage()) ?? "";
//
//                         // Get.to(const CreateAccountScreen());
//                       }),
//             ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
