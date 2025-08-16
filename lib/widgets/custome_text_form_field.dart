import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField(
      {super.key,
      required this.hintText,
      this.controller,
      this.onChanged,
      this.validator,
      this.prefixIconImage});

  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? prefixIconImage;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIconImage == null
            ? null
            : SvgPicture.asset(
                prefixIconImage!,
                height: 22,
                width: 22,
                fit: BoxFit.scaleDown,
              ),
      ),
      controller: controller,
      onChanged: onChanged,
    );
  }
}
