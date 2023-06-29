import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kShimmerBase = Color(0xFFC2D398);
const kShimmerHighlight = Color(0xFFD8E9A8);
const kPaperColor = Color(0xFFffe1ba);
const kPaperColorText = Color(0xFFffc476);
const kPlasticColor = Color(0xFFCCFFFA);
const kPlasticColorText = Color(0xFF49ffed);
const kMetalColor = Color(0xFFF0D3FF);
const kMetalColorText = Color(0xFFda94ff);
// const kOtherColor = Color(0xFFd2ffba);
const kOtherColor = Color(0xFFC2D398);
const kOtherLightColor = Color(0xFFf2feec);
const kOthersColor = Color(0xFFFFCCD1);
const kOthersColorText = Color(0xFFff99a3);
const kYellow = Color(0xFFEAE509);
const kGreenLight = Color(0xFF7DCE13);
const kGreenExtraLight = Color(0xffF4FFDF);
const kGreenMedium = Color(0xFF5BB318);
const kGreenDark = Color(0xFF2B7A0B);
const kDarkBlack = Color(0xFF191A19);
const kDarkGreenDark = Color(0xFF1E5128);
const kDarkGreenMedium = Color(0xFF4E9F3D);
const kDarkGreenLight = Color(0xFFD8E9A8);
const kScaffoldColor = Color(0xFFefefef);
const kBorderColor = Color(0xFFb6b6b6);
const kBorderColor2 = Color(0xff98999e);
const kBorderColor3 = Color(0xff5c5d65);
const kBorderColor4 = Color(0xffd6d9db);
const kTextPrimary = Color(0xFF33363F);
const kTextSecondary = Color(0xFF4A4E5B);
const kTextTertiary = Color(0xff6B6E6F);
const kSilverNight = Color(0xFFB0B5B9);
const kWhite = Color(0xFFFFFFFF);
const kBlack = Color(0xFF000000);
const kRed = Colors.red;
const kRedDark = Color(0xFFc5152a);
const kBlue = Color(0xFF87e1d7);
const kLightYellow = Color(0xFFfdf6c0);
const kDark = Color(0xFF29235c);

Widget poppinsText(
        {required String? txt,
        required double? fontSize,
        Color color = kTextPrimary,
        FontWeight weight = FontWeight.w600,
        double? letterSpacing,
        int maxLines = 1,
        TextAlign? textAlign}) =>
    Text(
      txt!,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: weight,
            letterSpacing: letterSpacing),
      ),
    );
Widget poppinsMediumPrimary({
  required String? txt,
  required double? fontSize,
  double? letterSpacing,
  int maxLines = 1,
}) =>
    Text(
      txt!,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: kTextPrimary,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: letterSpacing),
      ),
    );

Widget poppinsMediumSecondary({
  required String? txt,
  required double? fontSize,
  double? letterSpacing,
  int maxLines = 1,
}) =>
    Text(
      txt!,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: kTextSecondary,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: letterSpacing),
      ),
    );
Widget poppinsMediumTertiary({
  required String? txt,
  required double? fontSize,
  double? letterSpacing,
  int maxLines = 1,
}) =>
    Text(
      txt!,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: kTextTertiary,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: letterSpacing),
      ),
    );

Widget poppinsSemiBoldSecondary({
  required String? txt,
  required double? fontSize,
  double? letterSpacing,
  int maxLines = 1,
}) =>
    Text(
      txt!,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: kTextSecondary,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: letterSpacing),
      ),
    );
Widget poppinsSemiBoldPrimary({
  required String? txt,
  required double? fontSize,
  double? letterSpacing,
  int maxLines = 1,
}) =>
    Text(
      txt!,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: kTextPrimary,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: letterSpacing),
      ),
    );
Widget poppinsSemiBoldWhite({
  required String? txt,
  required double? fontSize,
  double? letterSpacing,
  int maxLines = 1,
}) =>
    Text(
      txt!,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: kWhite,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: letterSpacing),
      ),
    );
Widget poppinsSemiBoldTertiary({
  required String? txt,
  required double? fontSize,
  double? letterSpacing,
  int maxLines = 1,
}) =>
    Text(
      txt!,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: kTextTertiary,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: letterSpacing),
      ),
    );
