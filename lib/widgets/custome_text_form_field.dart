import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomeTextFormField extends StatefulWidget {
  const CustomeTextFormField(
      {super.key,
      required this.hintText,
      this.controller,
      this.onChanged,
      this.validator,
      this.prefixIconImage,
      this.isPassword = false});

  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? prefixIconImage;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  State<CustomeTextFormField> createState() => _CustomeTextFormFieldState();
}

class _CustomeTextFormFieldState extends State<CustomeTextFormField> {
  late bool isObsecure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: isObsecure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIconImage == null
            ? null
            : SvgPicture.asset(
                widget.prefixIconImage!,
                height: 22,
                width: 22,
                fit: BoxFit.scaleDown,
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObsecure = !isObsecure;
                  setState(() {});
                },
                icon: isObsecure
                    ? const Icon(
                        Icons.visibility_outlined,
                        color: AppTheme.grey,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: AppTheme.grey,
                      ),
              )
            : null,
      ),
      controller: widget.controller,
      onChanged: widget.onChanged,
    );
  }
}
