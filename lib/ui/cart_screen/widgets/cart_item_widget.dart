import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore: must_be_immutable
class CartItemWidget extends StatelessWidget {
  CartItemWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgChopardperfume,
          height: getVerticalSize(
            84,
          ),
          width: getHorizontalSize(
            40,
          ),
        ),
        Padding(
          padding: getPadding(
            left: 32,
            bottom: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: getHorizontalSize(
                  72,
                ),
                child: Text(
                  "Chopard Happy",
                  maxLines: null,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtPoppinsRegular1633,
                ),
              ),
              Padding(
                padding: getPadding(
                  top: 3,
                ),
                child: Text(
                  "249.00",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtPoppinsSemiBold1143Gray600,
                ),
              ),
            ],
          ),
        ),
        CustomImageView(
          svgPath: ImageConstant.imgIcbaselineplusGray900,
          height: getSize(
            19,
          ),
          width: getSize(
            19,
          ),
          margin: getMargin(
            left: 46,
            top: 32,
            bottom: 32,
          ),
        ),
        Container(
          width: getHorizontalSize(
            37,
          ),
          margin: getMargin(
            left: 6,
            top: 31,
            bottom: 31,
          ),
          padding: getPadding(
            left: 16,
            top: 1,
            right: 16,
            bottom: 1,
          ),
          decoration: AppDecoration.txtOutlineBluegray100.copyWith(
            borderRadius: BorderRadiusStyle.txtCircleBorder11,
          ),
          child: Text(
            "1",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtPoppinsSemiBold1143Gray900,
          ),
        ),
        CustomImageView(
          svgPath: ImageConstant.imgIcbaselineplusGray90019x19,
          height: getSize(
            19,
          ),
          width: getSize(
            19,
          ),
          margin: getMargin(
            left: 6,
            top: 32,
            bottom: 32,
          ),
        ),
      ],
    );
  }
}
