import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
// import 'package:WaterWise/ui/home/home__screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_bar/appbar_circleimage.dart';
import '../../app_bar/appbar_image.dart';
import 'package:http/http.dart' as http;
import '../../app_bar/appbar_subtitle.dart';
import '../../app_bar/appbar_title.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
// import '../../widget/custom_text_form_field.dart';
// import '../update_account_screen/update_account_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Map user = {};
  getUser() async{
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if(userString!=null){
      user = jsonDecode(userString);
      // pickAndSaveImage();
      setState(() {
      });
    }
  }
  String fileName="";

  Future<void> pickAndSaveImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick image from gallery
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      // No image selected
      return;
    }
    // Get the app's document directory
    final Directory appDir = await getApplicationDocumentsDirectory();
    // Generate a unique file name
    String fileName = path.basename(image.path);
    // Define the destination path
    final String destination = path.join(appDir.path, 'assets', 'images', fileName);
    try {
      // Save the image to the destination path
      final File savedImage = await File(image.path).copy(destination);

      // Display a success message
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Image Saved'),
          content: Text('The image has been updated'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      // Display an error message
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to save the image.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
    var url = 'http://192.168.1.12/water_wise/register_config.php';
    var response = await http.post(Uri.parse(url), body: {
      'id': user['id'],
      'photo': fileName,
    });

    if (response.statusCode == 200) {
      print('success');
      print(response.body);
      Map responseBody = jsonDecode(response.body);
      Map user = responseBody['data'];
      final pref = await SharedPreferences.getInstance();
      pref.setString('user', jsonEncode(user));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Update Photo Success'),
            backgroundColor: Color(0xFF6F9C95),
          ),
      );
    } else {
      print('failed bye');
    }

  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  TextEditingController dateController = TextEditingController();

  TextEditingController paymentmethodsController = TextEditingController();

  TextEditingController vouchersController = TextEditingController();

  TextEditingController contactusController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          height: getVerticalSize(
            83,
          ),
          title: Padding(
            padding: getPadding(
              left: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppbarTitle(
                  text: "Hi, "+user['fname'],
                ),
                AppbarSubtitle(
                  text: "Welcome!",
                  margin: getMargin(
                    right: 34,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            AppbarCircleimage(
              imagePath: "assets/images/"+user['photo'],
              margin: getMargin(
                left: 30,
                top: 3,
                right: 3,
              ),
            ),
            GestureDetector(
              onTap: pickAndSaveImage, // Replace with your desired method for handling the tap event
              child: AppbarImage(
                height: getSize(10),
                width: getSize(10),
                onTap: () {
                  onTapEditPhoto(context);
                },
                svgPath: "assets/images/img_edit.svg",
                margin: getMargin(left: 10, top: 22, right: 33, bottom: 20),
              ),
            ),

          ],
        ),
        body: Container(
          width: double.maxFinite,
          padding: getPadding(
            left: 20,
            top: 50,
            right: 20,
            bottom: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Button
              CustomButton(
                height: 50 ,
                width: 300,
                // width: getHorizontalSize(
                //   95,
                // ),
                text: "Update Account",

                onTap: () {
                    onTapUpdateAcc(context);
                },

                margin: getMargin(
                  left: 25,
                  bottom: 10
                ),

              ),

              CustomButton(
                height: 50 ,
                width: 300,
                // width: getHorizontalSize(
                //   95,
                // ),
                text: "Payment Methods",
                onTap: () {
                  onTapPayments(context);
                },
                margin: getMargin(
                  left: 25,
                    bottom: 10
                ),
              ),
              CustomButton(
                height: 50 ,
                width: 300,
                text: "Vouchers",
                onTap: () {
                  onTapVouchers(context);

                },
                margin: getMargin(
                  left: 25,
                    bottom: 10
                ),
              ),
              CustomButton(
                height: 50 ,
                width: 300,
                // width: getHorizontalSize(
                //   95,
                // ),
                text: "Contact Us",
                onTap: () {
                  onTapContactUs(context);
                },
                margin: getMargin(
                  left: 25,
                    bottom: 10
                ),
              ),
              CustomButton(
                height: getVerticalSize(
                  43,
                ),
                width: getHorizontalSize(
                  72,
                ),
                text: "Logout",
                margin: getMargin(
                  left: 122,
                  top: 45,
                  bottom: 5,
                ),
                variant: ButtonVariant.OutlineBluegray700,
                fontStyle: ButtonFontStyle.PoppinsMedium15,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.loginScreen);
                  if (mounted) {
                    setState(() {
                      // _isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Logged Out",
                          ),
                        ),
                      );
                    });
                  }
                },
              ),
            ],
          ),
        ),
        // bottomNavigationBar: CustomBottomBar(
        //   onChanged: (BottomBarEnum type) {
        //     Navigator.pushNamed(
        //         navigatorKey.currentContext!, getCurrentRoute(type));
        //   },
        // ),
      ),
    );
  }

  ///Handling route based on bottom click actions
  // String getCurrentRoute(BottomBarEnum type) {
  //   switch (type) {
  //     case BottomBarEnum.Home1:
  //       return AppRoutes.homeScreen;
  //     case BottomBarEnum.History1:
  //       return AppRoutes.billingScreen;
  //     case BottomBarEnum.Notification1:
  //       return "/";
  //     case BottomBarEnum.Profile1:
  //       return AppRoutes.profileScreen;
  //     default:
  //       return "/";
  //   }
  // }

  ///Handling page based on route
  // Widget getCurrentPage(String currentRoute) {
  //   switch (currentRoute) {
  //     case AppRoutes.profileScreen:
  //     default:
  //       return DefaultWidget();
  //   }
  // }
  onTapUpdateAcc(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.updateAccountScreen);
  }
  onTapContactUs(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.contactUsScreen);
  }
  onTapVouchers(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.vouchersScreen);
  }
  onTapPayments(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.paymentMethodsScreen);
  }
  onTapEditPhoto(BuildContext context) {
    pickAndSaveImage();
  }
}
