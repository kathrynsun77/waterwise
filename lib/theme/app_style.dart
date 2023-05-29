import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/size_utils.dart';

class AppStyle {
  static TextStyle txtPoppinsRegular10 = TextStyle(
    color: ColorConstant.deepPurpleA200,
    fontSize: getFontSize(
      10,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtPoppinsRegular12 = TextStyle(
    color: ColorConstant.indigo100,
    fontSize: getFontSize(
      12,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtPoppinsMedium12 = TextStyle(
    color: ColorConstant.blueGray400,
    fontSize: getFontSize(
      12,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static TextStyle txtRobotoRegular16 = TextStyle(
    color: ColorConstant.blueGray40001,
    fontSize: getFontSize(
      16,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtPoppinsSemiBold12 = TextStyle(
    color: ColorConstant.gray800,
    fontSize: getFontSize(
      12,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  static TextStyle txtPoppinsSemiBold18 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      18,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  static TextStyle txtRobotoRegular20 = TextStyle(
    color: ColorConstant.black900,
    fontSize: getFontSize(
      20,
    ),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtPoppinsSemiBold18Gray800 = TextStyle(
    color: ColorConstant.gray800,
    fontSize: getFontSize(
      18,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );
}
