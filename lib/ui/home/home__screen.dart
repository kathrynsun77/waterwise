import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_bar/appbar_circleimage.dart';
import '../../app_bar/appbar_subtitle.dart';
import '../../app_bar/appbar_title.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/app_style.dart';
import '../../widget/custom_icon_button.dart';
import '../../widget/custom_image_view.dart';
import '../../API.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String API= "http://172.28.200.128/water_wise/";
  // String API= "http://10.33.133.168/water_wise/";
  // String API= "http://192.168.1.12/water_wise/";
  Map user = {};
  getUser() async{
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if(userString!=null){
      user = jsonDecode(userString);
      fetchData();
      fetchPoints();
      setState(() {
      });
    }
  }

  List points = [];
  fetchPoints() async {
    final response = await http.post(
        Uri.parse(API+'get_points.php'),
        body: {
          'cust-id': user['customer_id'],
        });
    // print('fetched');
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      points = json.decode(response.body);
      setState(() {
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  List allBill = [];
  fetchData() async {
    final response = await http.post(
        Uri.parse(API+'show_transaction.php'),
        body: {
          'cust-id': user['customer_id'],
        });
    print('fetched');
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
            height: getVerticalSize(83),
            title: Padding(
                padding: getPadding(left: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppbarTitle(
                        text: 'Hi, ${user.isEmpty?'':user['fname']}',
                      ),
                      AppbarSubtitle(
                          text: "Welcome!", margin: getMargin(right: 20))
                    ])),
            actions: [
              AppbarCircleimage(
                  imagePath: user['photo'],
                  margin: getMargin(left: 30, top: 3, right: 30, bottom: 3),
              )
            ]),
        body: RefreshIndicator(
          onRefresh: () async {
          fetchData();
          },
          child: SingleChildScrollView(
            child:Container(
              width: double.maxFinite,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      ListView.builder(
                      itemCount: points.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                      Map item = points[index];
                      return Container(
                        margin: getMargin(left: 30, top: 22, right: 30),
                        padding: getPadding(
                            left: 119, top: 25, right: 119, bottom: 25),
                        decoration: AppDecoration.green.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder12),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  "Points",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsSemiBold2000.copyWith(letterSpacing: getHorizontalSize(1.0))                              ),
                              Text(
                                  "1 Point = \$1",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsRegular12.copyWith(letterSpacing: getHorizontalSize(1.0)),
                              ),
                              Padding(
                                  padding: getPadding(top: 4),
                                  child: Text(
                                      item['total_point'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtPoppinsSemiBold30
                                          .copyWith(
                                          letterSpacing:
                                          getHorizontalSize(0.3))),
                              ),
                            ]
                          )
                      );
                      }
                        )
                    ,Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: getPadding(left: 30, top: 21),
                            child: Text("Menu",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsSemiBold18.copyWith(
                                    letterSpacing: getHorizontalSize(1.0))))),
                    Padding(
                        padding: getPadding(left: 30, top: 10, right: 30),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    onTapWater(context);
                                  },
                                  child: Padding(
                                      padding: getPadding(bottom: 1),
                                      child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            CustomIconButton(
                                                height: 45,
                                                width: 45,
                                                child: CustomImageView(
                                                    svgPath: ImageConstant
                                                        .imgAir1)),
                                            Padding(
                                                padding: getPadding(top: 11),
                                                child: Text("Estimate",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsRegular12Gray800
                                                        .copyWith(
                                                        letterSpacing:
                                                        getHorizontalSize(
                                                            0.6))))
                                          ]))),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin:
                                        getMargin(left: 18, right: 18),
                                        padding: getPadding(
                                            left: 13,
                                            top: 11,
                                            right: 13,
                                            bottom: 11),
                                        decoration: AppDecoration
                                            .fillBluegray40001
                                            .copyWith(
                                            borderRadius:
                                            BorderRadiusStyle
                                                .roundedBorder12),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Card(
                                                  clipBehavior:
                                                  Clip.antiAlias,
                                                  elevation: 0,
                                                  margin: EdgeInsets.all(0),
                                                  color:
                                                  ColorConstant.indigo800,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder5),
                                                  child: Container(
                                                      height:
                                                      getVerticalSize(23),
                                                      width:
                                                      getHorizontalSize(
                                                          18),
                                                      decoration: AppDecoration
                                                          .fillIndigo800
                                                          .copyWith(
                                                          borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder5),
                                                      child: Stack(
                                                          children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pushNamed(context, AppRoutes.marketplaceScreen);
                                                          },
                                                          child: CustomImageView(
                                                              svgPath:
                                                              ImageConstant.imgMobile,
                                                              height:
                                                              getVerticalSize(
                                                                  23),
                                                              width:
                                                              getHorizontalSize(
                                                                  18),
                                                              alignment:
                                                              Alignment
                                                                  .center),
                                                        )
                                                      ])))
                                            ])),
                                    Padding(
                                        padding: getPadding(top: 13),
                                        child: Text("Marketplace",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                letterSpacing: getHorizontalSize(0.6))))
                                  ]),
                              GestureDetector(
                                  onTap: () {
                                    onTapInvest(context);
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        CustomIconButton(
                                            height: 45,
                                            width: 45,
                                            child: CustomImageView(
                                                svgPath: ImageConstant.imgLamp)),
                                        Padding(
                                            padding: getPadding(top: 13),
                                            child: Text("Usage",
                                                overflow:
                                                TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtPoppinsRegular12Gray800
                                                    .copyWith(
                                                    letterSpacing:
                                                    getHorizontalSize(
                                                        0.6))))
                                      ]))
                            ])),
                    Container(
                        width: double.maxFinite,
                        child: Container(
                            margin: getMargin(top: 18),
                            padding: getPadding(
                                left: 30, top: 14, right: 30, bottom: 14),
                            decoration: AppDecoration.fillGray50,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Last Transaction",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtPoppinsSemiBold18.copyWith
                                              (letterSpacing: getHorizontalSize(1.0))),
                                        GestureDetector(
                                            onTap: () {
                                              onTapTxtSmalllabelheavy(
                                                  context);
                                            },
                                            child: Padding(
                                                padding: getPadding(
                                                    top: 4, bottom: 4),
                                                ))
                                      ]),
                                      ListView.builder(
                                      itemCount: allBill.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        Map item = allBill[index];
                                        return Container(
                                            width: double.maxFinite,
                                            child: Container(
                                                margin:
                                                getMargin(top: 5, bottom: 5),
                                                padding: getPadding(
                                                    left: 16,
                                                    top: 5,
                                                    right: 16,
                                                    bottom: 5),
                                                decoration: AppDecoration.white
                                                    .copyWith(
                                                    borderRadius:
                                                    BorderRadiusStyle
                                                        .roundedBorder12),
                                                child: Column(
                                                    mainAxisSize: MainAxisSize
                                                        .min,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        getPadding(top:0),
                                                        child:
                                                        Text(
                                                          int.parse(item['transaction_type']) == 1
                                                              ? "Payment/Purchase       \$${item['transaction_amount']}    ${item['transaction_date']}"
                                                              : int.parse(item['transaction_type']) == 2
                                                              ? "Point Redeem         -${item['transaction_amount']}    ${item['transaction_date']}"
                                                              : "Point Earned         +${item['transaction_amount']}    ${item['transaction_date']}",
                                                          style: int.parse(item['transaction_type']) == 2
                                                              ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                            letterSpacing: getHorizontalSize(1.0),
                                                          )
                                                              : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                            letterSpacing: getHorizontalSize(1.0),
                                                          ),
                                                        )
                                                      ),
                                                    ])));
                                      })])))
                  ]))),
        )));
  }

  onTapWater(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.estimateScreen);
  }

  onTapInvest(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.activityScreen);
  }

  onTapTxtSmalllabelheavy(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.activityScreen);
  }
}
