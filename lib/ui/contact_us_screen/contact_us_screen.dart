import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';
import '../../API.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  Map user = {};
  String dropdownValue = 'Feedback'; // Default value for dropdown

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString) as Map;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }


  addPayment() async {
    var url = API + 'feedback.php';
    var response = await http.post(Uri.parse(url), body: {
      'cust-id': user['customer_id'],
      'message': messageController.text,
    });

    if (response.statusCode == 200) {
      print('success');
      print(response.body);
      Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback Sent!'),
          backgroundColor: Color(0xFF6F9C95),
        ),
      );
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }

  reqService() async {
    var url = API + 'request_service.php';
    var response = await http.post(Uri.parse(url), body: {
      'cust-id': user['customer_id'],
      'message': messageController.text,
    });

    if (response.statusCode == 200) {
      print('success');
      print(response.body);
      Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Service Request Sent!'),
          backgroundColor: Color(0xFF6F9C95),
        ),
      );
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }

  TextEditingController firstnameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
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
                        hintText: " Name",
                        margin: getMargin(top: 4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 21, left: 30),
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
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Feedback', 'Service'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsSemiBold14.copyWith(
                            letterSpacing: getHorizontalSize(1.0),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            CustomButton(
              height: getVerticalSize(51),
              width: getHorizontalSize(146),
              text: "Send",
              margin: getMargin(top: 58),
              onTap: () {
                addPayment();
              },
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
    Navigator.maybePop(context);
  }

  onTapContactSend(BuildContext context) {
    if (dropdownValue == 'Feedback') {
      addPayment();
    } else if (dropdownValue == 'Service') {
      reqService();
    }
  }
}
