import 'package:WaterWise/ui/receipt_marketplace_screen/receipt_marketplace_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:WaterWise/widget/app_bar/appbar_image.dart';
import 'package:WaterWise/widget/app_bar/custom_app_bar.dart';
import '../../core/app_export.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

// ignore_for_file: must_be_immutable
class _OrdersScreenState extends State<OrdersScreen> {
  // String API = "http://172.28.200.128/water_wise/";
  String API= "http://10.33.133.168/water_wise/";
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


  List allOrders = [];
  fetchData() async {
    final response =
        await http.post(Uri.parse(API +'orders_page.php'), body: {
      'cust-id': user['customer_id'],
    });

    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      allOrders = json.decode(response.body);
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

  bool _isRefreshing = false;

  Future<void> _refreshData() async {
    fetchData();
    // Simulating a delay of 2 seconds for demonstration purposes
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Update your data variables here

      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: getVerticalSize(62),
                leadingWidth: 34,
                leading: AppbarImage(
                    height: getVerticalSize(14),
                    width: getHorizontalSize(7),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 27, top: 25, bottom: 23),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                title: Padding(
                    padding: getPadding(left: 22),
                    child: Text("My Orders",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsSemiBold2000
                            .copyWith(letterSpacing: getHorizontalSize(1.0)))),
                styleType: Style.bgFillBluegray400),
            body: RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                            child: Container(
                            margin: getMargin(top: 20),
                            padding: getPadding(
                            left: 10,
                            top: 16,
                            right: 10,
                            bottom: 16),
                            decoration: AppDecoration.fillGray50,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListView.builder(
                              itemCount: allOrders.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Map item = allOrders[index];
                                return Container(
                                  width: double.maxFinite,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ReceiptMarketplaceScreen
                                            (orderId: int.parse(item['order_id'])),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: getMargin(top: 10),
                                      padding: getPadding(
                                          left: 16,
                                          top: 15,
                                          right: 16,
                                          bottom: 15),
                                      decoration: AppDecoration.white.copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['tracking_number'],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtPoppinsRegular12Gray800
                                                .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(
                                                    1.0)),
                                          ),
                                          Text(
                                            item['transaction_date'],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                    .txtPoppinsRegular12Gray800
                                                    .copyWith(
                                                        letterSpacing:
                                                            getHorizontalSize(
                                                                1.0)),
                                          ),
                                          Padding(
                                            padding: getPadding(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Order Number: " + item['order_number'],
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,
                                                        style: AppStyle
                                                                .txtPoppinsRegular12Gray800
                                                                .copyWith(
                                                                    letterSpacing:
                                                                        getHorizontalSize(
                                                                            1.0)),
                                                      ),
                                                      Padding(
                                                        padding: getPadding(top: 4),
                                                        child: Text(
                                                          "Tracking Number: " + item['tracking_number'],
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          textAlign: TextAlign.left,
                                                          style: AppStyle
                                                              .txtPoppinsRegular12Gray800
                                                              .copyWith(
                                                              letterSpacing:
                                                              getHorizontalSize(
                                                                  1.0)),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              getPadding(top: 4),
                                                          child: Text(
                                                            "Card: ••••  ••••  ••••  ${item['card_name'].substring(item['card_name'].length - 4)}",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                    .txtPoppinsRegular12Gray800
                                                                    .copyWith(
                                                                        letterSpacing:
                                                                            getHorizontalSize(1.0)),
                                                          ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                          getPadding(top: 4),
                                                          child: Text(
                                                            "Delivery Address: "+item['building_street'] + " " + item['postal_code'] + " " + item['unit_no']+
                                                                "\n Phone Number:"+item['phone_number'],
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                            TextAlign.left,
                                                            style: AppStyle
                                                                .txtPoppinsRegular12Gray800
                                                                .copyWith(
                                                                letterSpacing:
                                                                getHorizontalSize(1.0)),
                                                          ))
                                                    ]),
                                                Padding(
                                                    padding: getPadding(
                                                        top: 11, bottom: 11),
                                                    child: Text(
                                                      "\$" + item['transaction_amount'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle
                                                              .txtPoppinsRegular12Gray800
                                                              .copyWith(
                                                                  letterSpacing:
                                                                      getHorizontalSize(1.0)),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]),
                    )))));
  }
}
