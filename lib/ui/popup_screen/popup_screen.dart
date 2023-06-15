import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widgets/custom_text_form_field.dart';



class PopupScreen extends StatefulWidget {
  const PopupScreen({Key? key}) : super(key: key);

  @override
  State<PopupScreen> createState() => _PopupScreenState();
}
// ignore_for_file: must_be_immutable
class _PopupScreenState extends State<PopupScreen> {
  TextEditingController promocodeinputController = TextEditingController();
  String? selectedCard; // Selected card

  List<String> cardList = [
    '••••  ••••  ••••  1324',
    '••••  ••••  ••••  5678',
    '••••  ••••  ••••  9012',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: 375, // Set the desired width
                height: 500, // Set the desired height
                alignment: Alignment.centerLeft, // Adjust the alignment as needed
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsSemiBold14
                              .copyWith(letterSpacing: getHorizontalSize(1.0))),
                      Padding(
                        padding: getPadding(top: 20, left: 20),
                        child: DropdownButtonFormField<String>(
                          value: selectedCard,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCard = newValue!;
                            });
                          },
                          items: cardList.isNotEmpty
                              ? cardList.map((String card) {
                            return DropdownMenuItem<String>(
                              value: card,
                              child: Row(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgVisa1,
                                    height: getVerticalSize(28),
                                    width: getHorizontalSize(45),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    card,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsSemiBold14.copyWith(
                                      letterSpacing: getHorizontalSize(1.0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()
                              : null,
                        ),
                      ),
                      Padding(
                          padding: getPadding(top: 16, left:20),
                          child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.gray300)),
                      Padding(
                          padding: getPadding(top: 16, left:20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Enter Promo Code",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsSemiBold12),
                                CustomTextFormField(
                                    focusNode: FocusNode(),
                                    autofocus: true,
                                    controller: promocodeinputController,
                                    hintText: "Enter your code",
                                    margin: getMargin(top: 4),
                                    textInputAction: TextInputAction.done)
                              ])),
                      Padding(
                          padding: getPadding(top: 16, left:20),
                          child: Text("Payment Summary",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsSemiBold14.copyWith(
                                  letterSpacing: getHorizontalSize(1.0)))),
                      Padding(
                          padding: getPadding(top: 16, left:20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: getPadding(top: 3),
                                    child: Text("Top up",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtPoppinsRegular12Gray400
                                            .copyWith(
                                            letterSpacing:
                                            getHorizontalSize(0.6)))),
                                Text("20",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsSemiBold14
                                        .copyWith(
                                        letterSpacing:
                                        getHorizontalSize(1.0)))
                              ])),
                      Padding(
                          padding: getPadding(top: 16, left:20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: getPadding(top: 1, bottom: 1),
                                    child: Text("Admin Fee",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtPoppinsRegular12Gray400
                                            .copyWith(
                                            letterSpacing:
                                            getHorizontalSize(0.6)))),
                                Text("0.5",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsSemiBold14
                                        .copyWith(
                                        letterSpacing:
                                        getHorizontalSize(1.0)))
                              ])),
                      Padding(
                          padding: getPadding(top: 16, left:20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtPoppinsSemiBold14Bluegray700
                                        .copyWith(
                                        letterSpacing:
                                        getHorizontalSize(1.0))),
                                Text("20.5",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtPoppinsSemiBold14Bluegray700
                                        .copyWith(
                                        letterSpacing:
                                        getHorizontalSize(1.0)))
                              ]))
                    ])),
            bottomNavigationBar: CustomButton(
                height: getVerticalSize(51),
                width: getHorizontalSize(208),
                text: "Make Payment",
                margin: getMargin(left: 83, right: 83, bottom: 30),
                onTap: () {
                  onTapTopupnow(context);
                })));
  }

  onTapTopupnow(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.successTransactionsScreen);
  }
}
