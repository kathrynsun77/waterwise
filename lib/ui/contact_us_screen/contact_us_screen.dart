import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController selectoptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25, left: 30),
              child: Text(
                "Contact Us",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                  letterSpacing: getHorizontalSize(1.0),
                ),
              ),
            ),
            Container(
              width: getHorizontalSize(236),
              margin: getMargin(left: 30, top: 30, right: 73),
              child: Text(
                "Have a question about your water supply?",
                maxLines: null,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsSemiBold15.copyWith(
                  letterSpacing: getHorizontalSize(1.0),
                ),
              ),
            ),
            Container(
              width: getHorizontalSize(253),
              margin: getMargin(left: 30, top: 1, right: 56),
              child: Text(
                "Email your company below to file your problems or complaints",
                maxLines: null,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsRegular10Indigo100,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsSemiBold12,
                      ),
                      CustomTextFormField(
                        width: getHorizontalSize(150),
                        focusNode: FocusNode(),
                        autofocus: true,
                        controller: firstnameController,
                        hintText: "First name",
                        margin: getMargin(top: 4),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Last Name",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsSemiBold12,
                      ),
                      CustomTextFormField(
                        width: getHorizontalSize(150),
                        focusNode: FocusNode(),
                        autofocus: true,
                        controller: firstnameController,
                        hintText: "First name",
                        margin: getMargin(top: 4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 19,left:30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    autofocus: true,
                    controller: emailController,
                    hintText: "Enter your email",
                    margin: getMargin(top: 4),
                    textInputType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 21,left:30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Message",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    autofocus: true,
                    controller: messageController,
                    hintText: "Enter Message",
                    margin: getMargin(top: 2),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 19, left:30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Remarks",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    autofocus: true,
                    controller: selectoptionController,
                    hintText: "Select an option",
                    margin: getMargin(top: 4),
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            CustomButton(
              height: getVerticalSize(51),
              width: getHorizontalSize(146),
              text: "Send",
              margin: getMargin(top: 58),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, top: 48, right: 91),
              child: Row(
                children: [
                  CustomImageView(
                    svgPath: ImageConstant.imgPhone,
                    height: getVerticalSize(14),
                    width: getHorizontalSize(19),
                    margin: getMargin(top: 2, bottom: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Text(
                      "company-cust@company.com",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsRegular12.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, top: 14, bottom: 5),
              child: Row(
                children: [
                  CustomImageView(
                    svgPath: ImageConstant.imgCall,
                    height: getVerticalSize(21),
                    width: getHorizontalSize(20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 9, top: 1, bottom: 1),
                    child: Text(
                      "+6582835537",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsRegular12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapContactus(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profileScreen);
  }
}
