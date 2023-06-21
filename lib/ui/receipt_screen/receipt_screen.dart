import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widget/custom_button_small.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            body: Container(
                width: double.maxFinite,
                padding: getPadding(all: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath: ImageConstant.imgArrowleftIndigo800,
                          height: getVerticalSize(16),
                          width: getHorizontalSize(9),
                          onTap: () {
                            onTapImgArrowleft(context);
                          }),
                      Padding(
                          padding: getPadding(left: 113, top: 34),
                          child: Text("Receipt",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsSemiBold18.copyWith(
                                  letterSpacing: getHorizontalSize(1.0)))),
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              margin: getMargin(top: 39),
                              padding: getPadding(
                                  left: 16, top: 27, right: 16, bottom: 27),
                              decoration: AppDecoration.white.copyWith(
                                  borderRadius:
                                  BorderRadiusStyle.roundedBorder12),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Invoice  id: ",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtPoppinsBold12
                                            .copyWith(
                                            letterSpacing:
                                            getHorizontalSize(1.0))),
                                    Padding(
                                        padding: getPadding(top: 13),
                                        child: Text("Payment date:",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtPoppinsBold12
                                                .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(
                                                    1.0)))),
                                    Padding(
                                        padding: getPadding(top: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: getPadding(top: 1),
                                                  child: Text("Total Usage",
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtPoppinsRegular12
                                                          .copyWith(
                                                          letterSpacing:
                                                          getHorizontalSize(
                                                              1.0)))),
                                              Padding(
                                                  padding:
                                                  getPadding(bottom: 1),
                                                  child: Text("300L",
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtPoppinsRegular12Bluegray700
                                                          .copyWith(
                                                          letterSpacing:
                                                          getHorizontalSize(
                                                              1.0))))
                                            ])),
                                    Padding(
                                        padding: getPadding(top: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Rate",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtPoppinsRegular12
                                                      .copyWith(
                                                      letterSpacing:
                                                      getHorizontalSize(
                                                          1.0))),
                                              Text("1.19",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtPoppinsRegular12Bluegray700
                                                      .copyWith(
                                                      letterSpacing:
                                                      getHorizontalSize(
                                                          1.0)))
                                            ])),
                                    Padding(
                                        padding: getPadding(top: 11),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Amount",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtPoppinsRegular12
                                                      .copyWith(
                                                      letterSpacing:
                                                      getHorizontalSize(
                                                          1.0))),
                                              Text("20",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtPoppinsRegular12Bluegray700
                                                      .copyWith(
                                                      letterSpacing:
                                                      getHorizontalSize(
                                                          1.0)))
                                            ])),
                                    Padding(
                                        padding: getPadding(top: 10, bottom: 6),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "Total  Payment +GST(8%) + Admin Fee (2.5)",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtPoppinsRegular12
                                                      .copyWith(
                                                      letterSpacing:
                                                      getHorizontalSize(
                                                          1.0))),
                                              Padding(
                                                  padding: getPadding(
                                                      top: 10, bottom: 10),
                                                  child: Text("200",
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                          .txtPoppinsRegular12Bluegray700
                                                          .copyWith(
                                                          letterSpacing:
                                                          getHorizontalSize(
                                                              1.0))))
                                            ]))
                                  ]))),
                      CustomButton(
                          height: getVerticalSize(29),
                          width: getHorizontalSize(133),
                          text: "Report a problem",
                          margin: getMargin(left: 2, top: 35, bottom: 5))
                    ]))));
  }

  onTapImgArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}
