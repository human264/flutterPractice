import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;

  final ValueChanged<String>? onChanged;

  final baseBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0));

  const CustomTextFormField({
    required this.onChanged,
    this.obscureText = false,
    this.autofocus = false,
    this.hintText,
    this.errorText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: const TextStyle(
            color: BODY_TEXT_COLOR,
            fontSize: 14.0,
          ),

          fillColor: INPUT_BG_COLOR,

          filled: true,

          border: baseBorder,
          enabledBorder: baseBorder,

          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: PRIMARY_COLOR
            )
          )
      ),
    );
  }
}
