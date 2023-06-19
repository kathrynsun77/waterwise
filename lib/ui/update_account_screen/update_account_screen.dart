import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';

class UpdateAccountScreen extends StatefulWidget {
  const UpdateAccountScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

// ignore_for_file: must_be_immutable
class _UpdateAccountScreenState extends State<UpdateAccountScreen> {

  Map user = {};
  getUser() async{
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if(userString!=null){
      user = jsonDecode(userString);
      setState(() {
      });
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void updateUser() async {
    final response = await http.post(
        Uri.parse('http://192.168.1.12/water_wise/update_account.php'),
        body: {
          'id': user['id'],
          'fname': firstnameController.text,
          'lname': lastnameController.text,
          'email': emailController.text,
          'password': passwordController.text
        });

    if (response.statusCode == 200) {
      print('success');
      print(response.body);
      try {
        Map responseBody = jsonDecode(response.body);
        Map user = responseBody['data'];
        final pref = await SharedPreferences.getInstance();
        pref.setString('user', jsonEncode(user));
        Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Update Success!'),
            backgroundColor: Color(0xFF6F9C95),
          ),
        );
      } catch (e) {
        print('Error decoding JSON: $e');
        // Handle the JSON decoding error here
      }
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }
  String currentValue = '';
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
            CustomImageView(
                svgPath: ImageConstant.imgArrowleft,
                height: getVerticalSize(16),
                width: getHorizontalSize(9),
                margin: getMargin(left: 16,top:20),
                onTap: () {
                  onTapImgArrowleft(context);
                }),
            Padding(
              padding: getPadding(
                top:25,
                left:30,
              ),
              child:
              Text(
                "Update Account",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                  letterSpacing: getHorizontalSize(
                    1.0,
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: getPadding(left: 30, right: 30, bottom: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Set the mainAxisSize to min
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: getPadding(top: 76),
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
                                hintText: user['fname'],
                                margin: getMargin(top: 4),
                              ),
                              CustomTextFormField(
                                width: getHorizontalSize(150),
                                autofocus: true,
                                controller: lastnameController,
                                hintText: user['lname'],
                                margin: getMargin(top: 4),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(top: 19),
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
                            hintText: user['email'],
                            margin: getMargin(top: 4),
                            textInputType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(top: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsSemiBold12,
                          ),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            autofocus: true,
                            controller: passwordController,
                            margin: getMargin(top: 4),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            isObscureText: true,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      height: getVerticalSize(51),
                      width: getHorizontalSize(145),
                      text: "Save",
                      margin: getMargin(top: 51, bottom: 5),
                      alignment: Alignment.center,
                      onTap: () {
                        updateUser();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapImgArrowleft(BuildContext context) {
      Navigator.pushNamed(context, AppRoutes.profileScreen);

  }

  // onTapUpdateaccount(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.profileScreen);
  // }
}
