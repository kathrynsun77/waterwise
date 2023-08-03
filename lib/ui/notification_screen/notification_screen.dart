import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_bar/appbar_title.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../core/app_export.dart';
import 'package:http/http.dart' as http;
import '../../API.dart';
import '../../fcm_handler.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map user = {};
  // String API= "http://172.28.200.128/water_wise/";
  // String API = "http://192.168.137.107/water_wise/";
  // String API= "http://192.168.1.12/water_wise/";


  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      fetchData();
      setState(() {});
    }
  }

  List allBill = [];

  fetchData() async {
    final response =
    await http.post(Uri.parse(API + 'show_notification.php'), body: {
      'cust-id': user['customer_id'],
    });
    // print('fethced notif');
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      allBill = json.decode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              height: getVerticalSize(50),
              title: Padding(
                padding: getPadding(left: 30, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppbarTitle(
                      text: "Notification",
                    ),
                  ],
                ),
              ),
            ),
            body: RefreshIndicator(
                onRefresh: () async {
                  fetchData();
                },
                child: SingleChildScrollView(
                    child: Container(
                      width: double.maxFinite,
                      padding: getPadding(
                        left: 23,
                        top: 0,
                        right: 23,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListView.builder(
                                itemCount: allBill.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Map item = allBill[index];
                                  return GestureDetector(
                                      onTap: () {
                                        // Navigator.pushNamed(context, item['url']);
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        margin: getMargin(
                                          top: 38,
                                          right: 5,
                                          left: 10,
                                        ),
                                        padding: getPadding(
                                          left: 16,
                                          top: 15,
                                          right: 50,
                                          bottom: 15,
                                        ),
                                        decoration: AppDecoration.outlineBlack90019
                                            .copyWith(
                                          borderRadius:
                                          BorderRadiusStyle.roundedBorder12,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              item['notification_name'],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtPoppinsRegular12Gray800
                                                  .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(1.0),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.grey[300],
                                              thickness: 1,
                                            ),
                                            Text(
                                              item['message'].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtPoppinsRegular12Gray400
                                                  .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(1.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                })
                          ]),
                    )))));
  }
}
