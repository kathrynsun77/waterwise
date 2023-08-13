import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_button2.dart';
import 'package:WaterWise/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_style.dart';
import '../../widget/custom_image_view.dart';
import '../../API.dart';
import '../sign_up_screen/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  loginUser(String email, String password) async {
    var url = API+'login_config1.php';
    var response = await http.post(Uri.parse(url), body: {
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
            content: Text('Login Success!'),
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



  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            width: double.maxFinite,
            padding: getPadding(
              left: 29,
              top: 31,
              right: 29,
              bottom: 31,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(
                      left: 1,
                    ),
                    child: Text(
                      "Welcome Back,",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                        letterSpacing: getHorizontalSize(
                          1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(
                      left: 1,
                    ),
                    child: Text(
                      "Login to continue your journey",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsRegular12.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.6,
                        ),
                      ),
                    ),
                  ),
                ),
                CustomImageView(
                  svgPath: ImageConstant.imgLoginillustration,
                  height: getVerticalSize(
                    229,
                  ),
                  width: getHorizontalSize(
                    185,
                  ),
                  margin: getMargin(
                    top: 53,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 2,
                    top: 73,
                  ),
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
                        margin: getMargin(
                          top: 4,
                        ),
                        textInputType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 2,
                    top: 19,
                  ),
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
                        hintText: "Password here",
                        margin: getMargin(
                          top: 4,
                        ),
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        isObscureText: true,
                      ),
                    ],
                  ),
                ),
                // Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
                CustomButton(
                  height: getVerticalSize(
                    51,
                  ),
                  text: "Login",
                  margin: getMargin(
                    left: 42,
                    top: 28,
                    right: 40,
                  ),
                  onTap: () {
                      loginUser(emailController.text, passwordController.text);
                  },
                ),
                Padding(
                  padding: getPadding(
                    top: 31,
                    bottom: 5,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don’t have account?",
                          style: TextStyle(
                            color: ColorConstant.indigo100,
                            fontSize: getFontSize(
                              10,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: " Sign Up ",
                          style: TextStyle(
                            color: ColorConstant.blueGray400,
                            fontSize: getFontSize(
                              10,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Perform the action when "Sign Up" is tapped
                        // For example, navigate to the sign-up screen
                        Navigator.pushNamed(context, AppRoutes.registerScreen);
                      },
                  ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
              ],
            ),
          ),
        ),
        ),
  );
  }
}




