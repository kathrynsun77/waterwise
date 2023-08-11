import 'dart:async';
import 'dart:convert';
import 'package:WaterWise/main.dart';
import 'package:flutter/material.dart';
import 'package:WaterWise/widgets/custom_button2.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../widget/custom_image_view.dart';
import 'package:http/http.dart' as http;
import '../../API.dart';

class IntroController extends GetxController{
  final _listMeter = [].obs;
  List get listMeter => _listMeter;
  set listMeter(List n) => _listMeter.value = n;
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

// ignore_for_file: must_be_immutable
class _IntroScreenState extends State<IntroScreen> {
  Map user = {};
  bool notificationSent = false; // Add this boolean flag
  final introController = Get.put(IntroController());
  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      checkLeakStatus();
      setState(() {});
    }
  }

  Timer? _timer;
  void checkLeakStatus() async {
    const Duration updateInterval = Duration(seconds: 7);

    _timer = Timer.periodic(updateInterval, (timer) async {
      // Make the HTTP POST request to get the leak_status
      final response = await http.post(
        Uri.parse(API + 'pipe_data.php'),
        body: {'cust-id': user['customer_id'].toString()},
      );
      print('request ke -'+ timer.tick.toString());
      print(response.body);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonData = json.decode(response.body);
        bool newNotificationRequired = false; // Flag to track if a new notification is required

        // Check if leak_status is 2 in any of the rounds and set the flag accordingly
        List newlistMeter = jsonData.where((item)=> int.parse(item['meter_value'])>100).toList();
        print('listMeter:');
        print(newlistMeter);
        if (newlistMeter.length > 0){
          for (var data in introController.listMeter) {
            int index = newlistMeter.indexWhere((e)=> e['pipe_id'] == data['pipe_id']);
            if (index<0) continue;
            if (data['meter_value']!=newlistMeter[index]['meter_value']){
              print("notif tampil");
              highUsage(); // Send the notification if required
              // newNotificationRequired = true;
              break;
            }
            print('notif tidak tampil');
            print(data['meter_value']);
            print (newlistMeter[index]['meter_value']);
          }
            introController.listMeter = newlistMeter;
          }
      } else {
        // Handle API error or non-200 response here
        print('Error: Unable to fetch leak_status');
      }
    });
  }

  void scheduleWeeklyWaterSaving() {
    const oneWeek = Duration(days: 7);
    // Create a periodic timer with a duration of one week
    Timer.periodic(oneWeek, (timer) {
      // Call the waterSaving() function at the beginning of each week
      waterSaving();
    });
  }

  void serviceNotif() {
    const midYear = Duration(days: 182); // Approximately 6 months (considering 30 days/month)
    // Create a timer for the mid-year notification
    Timer(midYear, () {
      // Call the waterSaving() function for the mid-year notification
      serviceNot();
    });
  }

  void initState() {
    getUser();
    scheduleWeeklyWaterSaving();
    serviceNotif();
    checkLeakStatus();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.blueGray4003d,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //script text on pressed
              // TextButton(
              //     onPressed: () {
              //       waterSaving();
              //     }, child: Text('Notif tests')),
              SizedBox(
                height: getVerticalSize(
                  20,
                ),
              ),
              Spacer(),
              CustomImageView(
                svgPath: ImageConstant.imgBeforeloginicon,
                height: getVerticalSize(
                  293,
                ),
                width: getHorizontalSize(
                  247,
                ),
              ),
              Container(
                width: double.maxFinite,
                child: Container(
                  width: double.maxFinite,
                  margin: getMargin(
                    top: 92,
                  ),
                  padding: getPadding(
                    left: 44,
                    top: 31,
                    right: 44,
                    bottom: 31,
                  ),
                  decoration: AppDecoration.white.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderTL25,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enjoy Everyday!",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsSemiBold18.copyWith(
                          letterSpacing: getHorizontalSize(
                            1.0,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: getHorizontalSize(
                            271,
                          ),
                          margin: getMargin(
                            left: 16,
                            top: 18,
                          ),
                          child: Text(
                            "Be wise, and discover your best water usage\nexperience with us. Everything is in\nyour hands!",
                            maxLines: null,
                            textAlign: TextAlign.center,
                            style: AppStyle.txtPoppinsRegular12.copyWith(
                              letterSpacing: getHorizontalSize(
                                0.12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                          height: getVerticalSize(
                            51,
                          ),
                          width: getHorizontalSize(
                            149,
                          ),
                          text: "Login",
                          margin: getMargin(
                            top: 35,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.loginScreen,
                            );
                          }
                      ),
                      CustomButton(
                        height: getVerticalSize(
                          51,
                        ),
                        width: getHorizontalSize(
                          174,
                        ),
                        text: "Register",
                        margin: getMargin(
                          top: 13,
                        ),
                        onTap: (){
                          Navigator.pushNamed(
                            context,
                            AppRoutes.registerScreen,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}