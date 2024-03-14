
import 'package:e_commerce_appmerce_app/appColors/app_colors.dart';
import 'package:e_commerce_appmerce_app/styles/detail_screen_styles.dart';
import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  final String hintText;
  String ratingController;
  final List<String> item;
  DropButton(
      {super.key,
      required this.hintText,
      required this.ratingController,
      required this.item});
  @override
  _DropButtonState createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
            fillColor: AppColors.baseWhiteColor,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0))),
        hint: Text(
          widget.hintText,
          style: DetailScreenStyles.productDropDownValueStyle,
        ),
        value: widget.ratingController,
        items: widget.item
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            widget.ratingController = value!;
          });
        },
      ),
    );
  }
}
