import '../cart_screen/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/app_bar/appbar_image.dart';
import 'package:WaterWise/widget/app_bar/custom_app_bar.dart';
import 'package:WaterWise/widget/custom_button2.dart';
import 'package:WaterWise/widget/custom_switch.dart';
import 'package:WaterWise/widget/custom_text_form_field2.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController itemscounterController = TextEditingController();

  bool isSelectedSwitch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: getVerticalSize(68),
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
                            onTapArrowleft2(context);
                          }),
                      AppbarImage(
                          height: getSize(24),
                          width: getSize(24),
                          svgPath: ImageConstant.imgArrowleftGray900,
                          margin: getMargin(top: 6),
                          onTap: () {
                            onTapArrowleftone1(context);
                          })
                    ]))),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 40, top: 8, right: 40, bottom: 8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("My cart",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsSemiBold20),
                      CustomTextFormField(
                          focusNode: FocusNode(),
                          autofocus: true,
                          controller: itemscounterController,
                          hintText: "2 Items",
                          margin: getMargin(left: 6, top: 11, right: 6),
                          textInputAction: TextInputAction.done),
                      Padding(
                          padding: getPadding(left: 6, top: 31),
                          child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: getVerticalSize(19));
                              },
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return CartItemWidget();
                              })),
                      Padding(
                          padding: getPadding(top: 104),
                          child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.blueGray100,
                              indent: getHorizontalSize(4),
                              endIndent: getHorizontalSize(8))),
                      Padding(
                          padding: getPadding(left: 4, top: 8, right: 9),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: getPadding(bottom: 1),
                                    child: Text("Redeem Points (20)",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtPoppinsSemiBold1143Gray900)),
                                CustomSwitch(
                                    value: isSelectedSwitch,
                                    onChanged: (value) {
                                      isSelectedSwitch = value;
                                    })
                              ])),
                      Padding(
                          padding: getPadding(left: 4, top: 10, right: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: getPadding(bottom: 1),
                                    child: Text("Total Amount+GST(8%)",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtPoppinsSemiBold1143Gray900)),
                                Text("358.00",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsSemiBold1306)
                              ])),
                      Padding(
                          padding: getPadding(top: 7),
                          child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.blueGray100,
                              indent: getHorizontalSize(4),
                              endIndent: getHorizontalSize(8))),
                      CustomButton(
                          height: getVerticalSize(45),
                          text: "Checkout",
                          margin:
                          getMargin(left: 6, top: 41, right: 6, bottom: 5),
                          padding: ButtonPadding.PaddingAll13,
                          fontStyle: ButtonFontStyle.PoppinsSemiBold1143)
                    ]))));
  }

  onTapArrowleft2(BuildContext context) {
    Navigator.pop(context);
  }

  onTapArrowleftone1(BuildContext context) {
    Navigator.pop(context);
  }
}
