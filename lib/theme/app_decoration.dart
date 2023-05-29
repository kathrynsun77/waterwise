import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/size_utils.dart';

class AppDecoration {
  static BoxDecoration get white => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get gradientBluegray700Bluegray500 => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0.1,
            0,
          ),
          end: Alignment(
            0.64,
            1.02,
          ),
          colors: [
            ColorConstant.blueGray700,
            ColorConstant.blueGray500,
          ],
        ),
      );
  static BoxDecoration get fillBluegray4003d => BoxDecoration(
        color: ColorConstant.blueGray4003d,
      );
}

class BorderRadiusStyle {
  static BorderRadius customBorderTL25 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        25,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        25,
      ),
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
