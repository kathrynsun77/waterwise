import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map user = {};

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
    final response = await http.post(
        Uri.parse('http://172.28.200.128/water_wise/show_notification.php'),
        body: {
          'cust-id': user['customer_id'],
        });
    // print('fethced notif');
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      allBill = json.decode(response.body);
      setState(() {
      });
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
        body: SingleChildScrollView(
        child:Container(
          width: double.maxFinite,
          padding: getPadding(
            left: 23,
            top: 29,
            right: 23,
            bottom: 29,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  left: 7,
                ),
                child: Text(
                  "Notifications",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                    letterSpacing: getHorizontalSize(
                      1.0,
                    ),
                  ),
                ),
              ),
                ListView.builder(
                itemCount: allBill.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Map item = allBill[index];
                  return Container(
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
                    decoration: AppDecoration.outlineBlack90019.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                            item['message'],
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsRegular12Gray800.copyWith(
                    letterSpacing: getHorizontalSize(1.0),
                  ),
                          ),
                        Text(
                          item['notification_date'].toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsRegular12Gray400.copyWith(
                            letterSpacing: getHorizontalSize(1.0),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                )]
          ),
    ))));
  }
}
