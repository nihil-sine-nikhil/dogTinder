import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/constants/ui_constants.dart';

class CustomUnderlineTextField extends StatefulWidget {
  const CustomUnderlineTextField({
    Key? key,
    required this.controller,
    this.prefix,
    this.hint,
    this.isObscure = false,
    required this.textInputType,
    required this.inputLength,
  }) : super(key: key);

  final int inputLength;
  final String? prefix;
  final String? hint;
  final bool? isObscure;
  final TextEditingController controller;

  final TextInputType textInputType;

  @override
  State<CustomUnderlineTextField> createState() =>
      _CustomUnderlineTextFieldState();
}

class _CustomUnderlineTextFieldState extends State<CustomUnderlineTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscuringCharacter: '●',
      obscureText: widget.isObscure!,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.inputLength),
      ],
      keyboardType: widget.textInputType,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: kTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      cursorColor: kDark,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: widget.controller.clear,
          icon: const Icon(
            BootstrapIcons.x_circle_fill,
            color: kDark,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kBorderColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kDark, width: 1),
        ),
        prefixText: widget.prefix,
        hintText: widget.hint,
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: kTextTertiary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        prefixStyle: const TextStyle(color: Colors.transparent),
      ),
    );
  }
}
