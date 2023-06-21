import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widget/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}
class _ActivityScreenState extends State<ActivityScreen> {

  bool isButtonPressed = false;
  Map user = {};
  List allBill = [];

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      fetchData();
      setState(() {});
    }
  }

  void requestTech() async {
    if (isButtonPressed) {
      return; // Exit early if button is already pressed
    }
    setState(() {
      isButtonPressed = true; // Set the button pressed state to true
    });
    var url = 'http://192.168.1.8/water_wise/request_tech.php';
    var response = await http.post(Uri.parse(url), body: {
      'cust-id': user['customer_id'],
    });
    if (response.statusCode == 200) {
      print('success bro');
      print(response.body);
      // Disable the button after it has been pressed once
      setState(() {
        isButtonPressed = true;
      });
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }

  fetchData() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.8/water_wise/bill_detail.php'),
      body: {
        'id': user['id']
      },
    );

    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      allBill = json.decode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }



  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int totalMeter = 0;
    for (var item in allBill) {
      totalMeter += int.parse(item['meter_value']);
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: getPadding(left: 30, top: 16, right: 18),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomImageView(
                                    svgPath:
                                    ImageConstant.imgArrowleftIndigo800,
                                    height: getVerticalSize(16),
                                    width: getHorizontalSize(9),
                                    margin: getMargin(top: 14, bottom: 2),
                                    onTap: () {
                                      onTapImgArrowleft(context);
                                    }),
                                CustomButton(
                                    height: getVerticalSize(32),
                                    width: getHorizontalSize(90),
                                    text: "Download Report",
                                    variant: ButtonVariant.OutlineBluegray40001,
                                    fontStyle: ButtonFontStyle.PoppinsMedium8)
                              ])),
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              margin: getMargin(top: 13),
                              padding: getPadding(left: 30, right: 30),
                              decoration: AppDecoration.fillGray50,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: getPadding(top: 34),
                                        child: Text("Water Usage",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtPoppinsSemiBold18Bluegray700
                                                .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(
                                                    1.0)))),
                                    Padding(
                                        padding: getPadding(top: 9),
                                        child: Row(children: [
                                          CustomButton(
                                              height: getVerticalSize(38),
                                              width: getHorizontalSize(59),
                                              text: "Usage",
                                              variant: ButtonVariant
                                                  .OutlineBluegray400,
                                              fontStyle: ButtonFontStyle
                                                  .PoppinsMedium12),
                                          CustomButton(
                                              height: getVerticalSize(38),
                                              width: getHorizontalSize(62),
                                              text: "Trends",
                                              margin: getMargin(left: 16),
                                              variant:
                                              ButtonVariant.OutlineGray300,
                                              fontStyle: ButtonFontStyle
                                                  .PoppinsMedium12Gray400,
                                              onTap: () {
                                                onTapTrends(context);
                                              })
                                        ])),
                                    Padding(
                                        padding: getPadding(top: 11),
                                        child: Text("Water Meter : "+totalMeter.toStringAsFixed(4),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtPoppinsRegular12Bluegray900
                                                .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(
                                                    1.0)))),
                                    ListView.builder(
                                    itemCount: allBill.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                    Map item = allBill[index];
                                    return Container(
                                    width: double.maxFinite,
                                        child: Container(
                                          margin: getMargin(top: 13),
                                          padding: getPadding(all: 16),
                                          decoration: AppDecoration.white
                                              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible: int.parse(item['leak_status']) == 2,
                                                child: CustomButton(
                                                  height: getVerticalSize(32),
                                                  width: getHorizontalSize(100),
                                                  text: isButtonPressed ? "Technician Requested" : "Request Technician",
                                                  onTap: isButtonPressed
                                                      ? null
                                                      : () {
                                                    setState(() {
                                                      isButtonPressed = true;
                                                    });
                                                    onTapRequestTech(context);
                                                  },
                                                  variant: ButtonVariant.OutlineRed400,
                                                  fontStyle: ButtonFontStyle.PoppinsMedium8Red400,
                                                ),
                                              ),


                                              Text(
                                                item['pipe_name'],
                                                maxLines: null,
                                                textAlign: TextAlign.left,
                                                style: (int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2)
                                                    ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                  letterSpacing: getHorizontalSize(1.0),
                                                )
                                                    : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                  letterSpacing: getHorizontalSize(1.0),
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(top: 12),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '${int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2 ? "High" : "Low"} Usage',
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.left,
                                                          style: (int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2)
                                                              ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                            letterSpacing: getHorizontalSize(1.0),
                                                          )
                                                              : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                            letterSpacing: getHorizontalSize(1.0),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(top: 2),
                                                          child: Text(
                                                            '${int.parse(item['leak_status']) == 2 ? "Pipe Leaking" : "No Leak"}',
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.left,
                                                            style: (int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2)
                                                                ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                              letterSpacing: getHorizontalSize(1.0),
                                                            )
                                                                : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                              letterSpacing: getHorizontalSize(1.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: getPadding(top: 9, bottom: 11),
                                                      child: Text(
                                                        item['meter_value'],
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,
                                                        style: (int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2)
                                                            ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                          letterSpacing: getHorizontalSize(1.0),
                                                        )
                                                            : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                          letterSpacing: getHorizontalSize(1.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    );})])))
                    ]))));
  }

  onTapImgArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
  onTapRequestTech(BuildContext context) {
    requestTech();
  }
  onTapTrends(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.activityTrendsScreen);
  }
}
