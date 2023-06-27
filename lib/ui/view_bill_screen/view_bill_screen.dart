import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

class ViewBillScreen extends StatefulWidget {
  const ViewBillScreen({Key? key}) : super(key: key);

  @override
  State<ViewBillScreen> createState() => _ViewBillScreenState();
}

class _ViewBillScreenState extends State<ViewBillScreen> {
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

  fetchData() async {
    final response = await http.post(
      Uri.parse('http://172.28.200.128/water_wise/bill_detail.php'),
      body: {
        'id': user['id'],
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

  void saveBillSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonData = jsonEncode(allBill);
    await prefs.setString('bill_amount', jsonData);
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int totalMeter = 0;
    for (var item in allBill) {
      totalMeter += int.parse(item['meter_value']);
    }
    double totalAmount = totalMeter * 1.19;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray50,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView( // Added SingleChildScrollView
          child: Container(
            width: double.maxFinite,
            padding: getPadding(left: 16, top: 22, right: 16, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  svgPath: "assets/images/img_arrowleft_indigo_800.svg",
                  height: getVerticalSize(16),
                  width: getHorizontalSize(9),
                  alignment: Alignment.centerLeft,
                  margin: getMargin(left: 14),
                  onTap: () {
                    onTapImgArrowleft(context);
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(left: 98, top: 30),
                    child: Text(
                      "Bill Summary",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold18Bluegray700.copyWith(
                        letterSpacing: getHorizontalSize(1.0),
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
                      child: Container(
                        margin: getMargin(left: 14, top: 8, right: 14),
                        padding: getPadding(all: 16),
                        decoration: AppDecoration.outlineBlack9003f.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder12,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: getHorizontalSize(64),
                              child: Text(
                                item['pipe_name'],
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                  letterSpacing: getHorizontalSize(1.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: getPadding(top: 5),
                              child: Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.blueGray40001,
                              ),
                            ),
                            Padding(
                              padding: getPadding(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: getPadding(top: 1),
                                    child: Text(
                                      "Usage",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                        letterSpacing: getHorizontalSize(1.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: getPadding(bottom: 1),
                                    child: Text(
                                      "${item['meter_value']}L",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtPoppinsRegular12Bluegray700.copyWith(
                                        letterSpacing: getHorizontalSize(1.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getPadding(top: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rate",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                      letterSpacing: getHorizontalSize(1.0),
                                    ),
                                  ),
                                  Text(
                                    "1.19",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsRegular12Bluegray700.copyWith(
                                      letterSpacing: getHorizontalSize(1.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getPadding(top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Amount",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                      letterSpacing: getHorizontalSize(1.0),
                                    ),
                                  ),
                                  Text(
                                    "${(int.parse(item['meter_value']) * 1.19).toStringAsFixed(2)}",                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsRegular12Bluegray700.copyWith(
                                      letterSpacing: getHorizontalSize(1.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: getMargin(left: 1, top: 35, bottom: 5),
                  padding: getPadding(left: 10, top: 1, right: 10, bottom: 1),
                  decoration: AppDecoration.outlineBlack9003f.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: getPadding(bottom: 1),
                        child: Text(
                          "Total(Include GST)",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsSemiBold14Bluegray700.copyWith(
                            letterSpacing: getHorizontalSize(1.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(right: 7),
                        child: Text(
                          "\$"+totalAmount.toStringAsFixed(2),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsSemiBold14Bluegray700.copyWith(
                            letterSpacing: getHorizontalSize(1.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  height: getVerticalSize(50),
                  width: getHorizontalSize(145),
                  text: "Pay",
                  onTap: () { onTapPay(context);
                  },
                  margin: getMargin(top: 40, bottom: 6),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapImgArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
  onTapPay(BuildContext context) {
    saveBillSharedPreferences();
    Navigator.pushNamed(context, AppRoutes.popUpScreen);
  }
}
