import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';

class EstimateScreen extends StatefulWidget {
  const EstimateScreen({Key? key}) : super(key: key);

  @override
  State<EstimateScreen> createState() => _EstimateScreenState();
}
// ignore_for_file: must_be_immutable
class _EstimateScreenState extends State<EstimateScreen> {
  // String API= "http://172.28.200.128/water_wise/";
  String API= "http://192.168.1.12/water_wise/";
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
      Uri.parse(API+'bill_detail.php'),
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

  @override
  void initState() {
    getUser();
    super.initState();
  }

  TextEditingController userInputController = TextEditingController();

  String result = '';

  void calculateValue() {
    double userInput = double.tryParse(userInputController.text) ?? 0;
    double calculatedValue = userInput * 1.19;
    setState(() {
      result = calculatedValue.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    userInputController.dispose();
    super.dispose();
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
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
        child: Container(
                width: double.maxFinite,
                padding: getPadding(left: 14, top: 30, right: 14, bottom: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath: ImageConstant.imgArrowleft,
                          height: getVerticalSize(16),
                          width: getHorizontalSize(9),
                          margin: getMargin(left: 16),
                          onTap: () {
                            onTapImgArrowleft(context);
                          }),
                      Padding(
                          padding: getPadding(left: 16, top: 31),
                          child: Text("Your Usage Estimation",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsSemiBold18Gray800
                                  .copyWith(
                                  letterSpacing: getHorizontalSize(1.0)))),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              height: getVerticalSize(39),
                              width: getHorizontalSize(316),
                              margin: getMargin(top: 27),
                              child:
                              Stack(alignment: Alignment.center, children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(totalMeter.toStringAsFixed(2),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtPoppinsSemiBold18Indigo100
                                            .copyWith(
                                            letterSpacing:
                                            getHorizontalSize(1.0)))),
                                Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text("\$"+totalAmount.toStringAsFixed(2),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtPoppinsSemiBold18Gray800
                                                  .copyWith(
                                                  letterSpacing:
                                                  getHorizontalSize(
                                                      1.0))),
                                          Padding(
                                              padding: getPadding(top: 10),
                                              child: Divider(
                                                  height: getVerticalSize(1),
                                                  thickness: getVerticalSize(1),
                                                  color: ColorConstant.gray300,
                                                  endIndent:
                                                  getHorizontalSize(1)))
                                        ]))
                              ]))),
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              margin: getMargin(top: 64, bottom: 5),
                              padding: getPadding(
                                  left: 15, top: 13, right: 15, bottom: 13),
                              decoration: AppDecoration.fillBluegray400
                                  .copyWith(
                                  borderRadius:
                                  BorderRadiusStyle.roundedBorder20),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: getHorizontalSize(107),
                                        height: getVerticalSize(50),
                                        margin: getMargin(left: 1),
                                        child: Text("Manual \nEstimation",
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtPoppinsSemiBold18WhiteA700
                                                .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(
                                                    1.0)))),
                                    Container(
                                        height: getVerticalSize(200),
                                        width: getHorizontalSize(316),
                                        margin: getMargin(
                                            left: 1, top: 26, bottom: 20),
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                      padding:
                                                      getPadding(top: 1, right:100),
                                                      child:
                                                      CustomTextFormField(
                                                        maxLines: null,
                                                        hintText: "Insert Usage in L",
                                                        controller: userInputController,
                                                      ),)),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(result,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                            TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsSemiBold18WhiteA700
                                                                .copyWith(
                                                                letterSpacing:
                                                                getHorizontalSize(
                                                                    1.0))),
                                                        Padding(
                                                            padding: getPadding(
                                                                top: 10),
                                                            child: Divider(
                                                                height:
                                                                getVerticalSize(
                                                                    1),
                                                                thickness:
                                                                getVerticalSize(
                                                                    1),
                                                                color:
                                                                ColorConstant
                                                                    .gray300,
                                                                endIndent:
                                                                getHorizontalSize(
                                                                    0.5))),
                                                        CustomButton(
                                                            height: getVerticalSize(51),
                                                            width: getHorizontalSize(184),
                                                            text: "Estimate",
                                                            margin: getMargin(left: 95, right: 96, top:100),
                                                            onTap: () { estimate(context);
                                                            })
                                                      ]))
                                            ]))
                                  ])))
                    ])))));
  }

  onTapImgArrowleft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
  }

  estimate(BuildContext context) {
    calculateValue();
  }
}
