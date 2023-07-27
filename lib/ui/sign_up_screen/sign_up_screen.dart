import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_style.dart';
import '../../widgets/custom_button2.dart';
import '../../widget/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // String API= "http://172.28.200.128/water_wise/";
  // String API= "http://10.33.133.168/water_wise/";
  String API= "http://192.168.1.12/water_wise/";

  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void registerUser(String fname, String lname, String email, String password) async {
    var url = API+'register_config1.php';
    // var url = 'https://master--waterwise-api.netlify.app/register_config?';
    var response = await http.post(Uri.parse(url), body: {
      'fname': fname,
      'lname': lname,
      'email': email,
      'password': password,
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
            content: Text('Registration Success!'),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            physics: MediaQuery.of(context).viewInsets.bottom > 0
                ? BouncingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: getPadding(left: 29, top: 30, right: 29, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: getPadding(left: 1),
                      child: Text(
                        "Create Your Account",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsSemiBold18.copyWith(
                          letterSpacing: getHorizontalSize(1.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: getPadding(left: 1),
                      child: Text(
                        "Create your account to start journey",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsRegular12.copyWith(
                          letterSpacing: getHorizontalSize(0.6),
                        ),
                      ),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgSignupTheme,
                      height: getVerticalSize(247),
                      width: getHorizontalSize(162),
                      margin: getMargin(left: 53, top: 27),
                    ),
                    Padding(
                      padding: getPadding(left: 2, top: 25),
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
                                style: AppStyle.txtPoppinsSemiBold12Gray800,
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
                                style: AppStyle.txtPoppinsSemiBold12Gray800,
                              ),
                              CustomTextFormField(
                                width: getHorizontalSize(150),
                                focusNode: FocusNode(),
                                autofocus: true,
                                controller: lastnameController,
                                hintText: "Last name",
                                margin: getMargin(top: 4),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: getPadding(left: 2, top: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsSemiBold12Gray800,
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
                      padding: getPadding(left: 2, top: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsSemiBold12Gray800,
                          ),
                          CustomTextFormField(
                            focusNode: FocusNode(),
                            autofocus: true,
                            controller: passwordController,
                            hintText: "Password here",
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
                      text: "Create Account",
                      margin: getMargin(left: 37, top: 30, right: 36),
                      onTap: () {
                        registerUser(
                          firstnameController.text,
                          lastnameController.text,
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: getPadding(top: 31, right: 75, bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account?",
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getVerticalSize(12),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getVerticalSize(12),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                ),
                                // Add navigation to the sign-in screen here
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, AppRoutes.loginScreen);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
