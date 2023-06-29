import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/constants/ui_constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.prefix,
    this.onChanged,
    this.hint,
    required this.textInputType,
    required this.inputLength,
  }) : super(key: key);
  final void Function(String)? onChanged;

  final int inputLength;
  final String? prefix;
  final String? hint;
  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.inputLength),
        ],
        keyboardType: widget.textInputType,
        style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: kWhite,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: Colors.black87), //<-- SEE HERE
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2.0),
            // borderRadius: BorderRadius.circular(25.0),
          ),
          prefixText: widget.prefix,
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 18,
              fontWeight: FontWeight.w400),
          prefixStyle: const TextStyle(color: Colors.transparent),
        ),
        onChanged: (value) => widget.onChanged!(value));
  }
}

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

class CustomUnderlineTextField2 extends StatefulWidget {
  const CustomUnderlineTextField2({
    Key? key,
    required this.controller,
    this.hint,
    this.lines,
    required this.textInputType,
  }) : super(key: key);

  final String? hint;
  final TextEditingController controller;
  final int? lines;
  final TextInputType textInputType;

  @override
  State<CustomUnderlineTextField2> createState() =>
      _CustomUnderlineTextField2State();
}

class _CustomUnderlineTextField2State extends State<CustomUnderlineTextField2> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.lines,
      keyboardType: TextInputType.multiline,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: kTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      cursorColor: kDark,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: widget.controller.clear,
          icon: const Icon(
            Icons.cancel,
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
        hintText: widget.hint,
        hintStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: kTextTertiary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        prefixStyle: const TextStyle(color: Colors.transparent),
      ),
    );
  }
}
