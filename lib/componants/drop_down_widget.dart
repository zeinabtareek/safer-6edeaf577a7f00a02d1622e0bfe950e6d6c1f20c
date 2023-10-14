import 'package:flutter/material.dart';
import 'package:untitled3/model/cities_model.dart';

import '../const/style.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({Key? key, this.type, this.list, this.onchange})
      : super(key: key);
  final CityData? type;
  final List<CityData>? list;
  final Function(CityData?)? onchange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        child: DropdownButtonFormField<CityData>(

          elevation: 1,
          isExpanded: true,
          value: type,
          onChanged: onchange,
           decoration: InputDecoration(

            filled: true,
            fillColor: K.lightMainColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),

          // decoration:   InputDecoration(
          //     contentPadding: EdgeInsets.symmetric(horizontal: 10),
          //     constraints: BoxConstraints(maxHeight: 50),
          //     border: OutlineInputBorder(          borderRadius: BorderRadius.circular(15),
          //
          //         borderSide: BorderSide(color: Colors.white))
          //
          // ),
          items: list!.map<DropdownMenuItem<CityData>>((CityData type) {
            return DropdownMenuItem<CityData>(
              value: type,
              child: Text(type.city ?? ""),
            );
          }).toList(),
        ),
      ),
    );
  }
}
