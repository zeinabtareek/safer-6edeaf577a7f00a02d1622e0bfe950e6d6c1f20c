import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/app_assets.dart';
import '../const/style.dart';

class CustomCard extends StatelessWidget {
  Widget widget;
    CustomCard({Key? key
    ,required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: K.lightMainColor,
      child: Container(
        padding: K.fixedPadding,
        // padding: K.fixedPadding,
        decoration: K.boxDecorationLightBg20,
        width: double.infinity,
        child: widget
      ),
    );
  }
}
