import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/app_bar/appbar_image.dart';
import 'package:WaterWise/widget/app_bar/custom_app_bar.dart';
import 'package:WaterWise/widget/custom_button2.dart';

class ProductdetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(56),
                leadingWidth: 375,
                leading: Container(
                    height: getVerticalSize(30),
                    width: getHorizontalSize(24),
                    margin:
                    getMargin(left: 19, top: 13, right: 332, bottom: 13),
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      AppbarImage(
                          height: getVerticalSize(14),
                          width: getHorizontalSize(7),
                          svgPath: ImageConstant.imgArrowleft,
                          margin: getMargin(left: 8, right: 9, bottom: 16),
                          onTap: () {
                            onTapArrowleft1(context);
                          }),
                      AppbarImage(
                          height: getSize(24),
                          width: getSize(24),
                          svgPath: ImageConstant.imgArrowleftGray900,
                          margin: getMargin(top: 6),
                          onTap: () {
                            onTapArrowleftone(context);
                          })
                    ]))),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 15, top: 25, right: 15, bottom: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: getPadding(left: 9, top: 20),
                          child: Text("Pipa Abu-abu",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsRegular32)),
                      Padding(
                          padding: getPadding(left: 9, top: 5),
                          child: Text("249.00",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsSemiBold16)),
                      CustomImageView(
                          imagePath: ImageConstant.imgImage1,
                          height: getVerticalSize(220),
                          width: getHorizontalSize(285),
                          margin: getMargin(left: 10, top: 38)),
                      Padding(
                          padding: getPadding(top: 25),
                          child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.blueGray100)),
                      Padding(
                          padding: getPadding(top: 15),
                          child: Row(children: [
                            CustomImageView(
                                svgPath: ImageConstant.imgIcbaselineplus,
                                height: getSize(24),
                                width: getSize(24),
                                margin: getMargin(top: 2, bottom: 2)),
                            CustomButton(
                                height: getVerticalSize(28),
                                width: getHorizontalSize(46),
                                text: "1",
                                margin: getMargin(left: 8),
                                variant: ButtonVariant.OutlineBluegray100,
                                shape: ButtonShape.CircleBorder14),
                            CustomImageView(
                                svgPath:
                                ImageConstant.imgIcbaselineplusGray90001,
                                height: getSize(24),
                                width: getSize(24),
                                margin: getMargin(left: 8, top: 2, bottom: 2))
                          ])),
                      Padding(
                          padding: getPadding(top: 16),
                          child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.blueGray100)),
                      Container(
                          width: getHorizontalSize(329),
                          margin: getMargin(top: 15, right: 15),
                          child: Text(
                              "Paying tribute to this plant that is unique in the \nworld of perfumery, Dora Baghriche has played \nwith the rich, multiple nuances of its flowers, \nleaves, twigs and fruits.",
                              maxLines: null,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsRegular14Gray500)),
                      Container(
                          width: getHorizontalSize(156),
                          margin: getMargin(top: 14),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Expiry Date:",
                                    style: TextStyle(
                                        color: ColorConstant.gray600,
                                        fontSize: getFontSize(12),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                    text: " 15 March 2027\n",
                                    style: TextStyle(
                                        color: ColorConstant.gray900,
                                        fontSize: getFontSize(12),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: "Country of Origin",
                                    style: TextStyle(
                                        color: ColorConstant.gray600,
                                        fontSize: getFontSize(12),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                    text: ": Italy",
                                    style: TextStyle(
                                        color: ColorConstant.gray900,
                                        fontSize: getFontSize(12),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600))
                              ]),
                              textAlign: TextAlign.left))
                    ])),
            bottomNavigationBar: CustomButton(
                height: getVerticalSize(56),
                text: "Add to cart",
                margin: getMargin(left: 15, right: 15, bottom: 42),
                padding: ButtonPadding.PaddingT17,
                fontStyle: ButtonFontStyle.PoppinsSemiBold14WhiteA700,
                prefixWidget: Container(
                    margin: getMargin(right: 8),
                    child: CustomImageView(
                        svgPath: ImageConstant.imgIcbaselineplusWhiteA700)))));
  }

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }

  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
