import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

// ignore_for_file: must_be_immutable
class _BillingScreenState extends State<BillingScreen> {
  String API= "http://172.28.200.128/water_wise/";
  Map user = {};

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      fetchData();
      fetchPoints();
      setState(() {});
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
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  List allBill = [];

  fetchData() async {
    final response = await http.post(
        Uri.parse(API+'billing_config.php'),
        body: {
          'id': user['id'],
        });

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

  saveInvoice(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("invoice", value);
    print('String saved to SharedPreferences: $value');
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
    fetchPoints();
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
            body: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: ListView.builder(
                          itemCount: points.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Map balance = points[index];
                            return Container(
                                width: double.maxFinite,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: getPadding(left: 160, top: 20),
                                          child: Text("Points",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtPoppinsRegular14Gray400
                                                  .copyWith(
                                                      letterSpacing:
                                                          getHorizontalSize(
                                                              1.0)))),
                                      Padding(
                                          padding: getPadding(left: 160, top: 4),
                                          child: Text(balance['total_point'],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtPoppinsSemiBold30Gray800
                                                  .copyWith(
                                                      letterSpacing:
                                                          getHorizontalSize(
                                                              0.3)))),
                                      Container(
                                          width: double.maxFinite,
                                          child: Container(
                                              margin: getMargin(top: 20),
                                              padding: getPadding(
                                                  left: 30,
                                                  top: 16,
                                                  right: 30,
                                                  bottom: 16),
                                              decoration:
                                                  AppDecoration.fillGray50,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("Your Billing",
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,
                                                        style: AppStyle
                                                            .txtPoppinsSemiBold18Gray800
                                                            .copyWith(
                                                                letterSpacing:
                                                                    getHorizontalSize(
                                                                        1.0))),
                                                    ListView.builder(
                                                      itemCount: allBill.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        Map item = allBill[index];
                                                        return Container(
                                                          width: double.maxFinite,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              if (int.parse(item[
                                                                      'bill_status']) ==
                                                                  2) {
                                                                saveInvoice(item[
                                                                    'inovice_number']);
                                                                onTapListdue(
                                                                    context);
                                                              } else {
                                                                saveInvoice(item[
                                                                    'inovice_number']);
                                                                onTapListPaid(
                                                                    context);
                                                              }
                                                            },
                                                            child: Container(
                                                              margin: getMargin(
                                                                  top: 10),
                                                              padding: getPadding(
                                                                  left: 16,
                                                                  top: 15,
                                                                  right: 16,
                                                                  bottom: 15),
                                                              decoration: AppDecoration
                                                                  .white
                                                                  .copyWith(
                                                                      borderRadius:
                                                                          BorderRadiusStyle
                                                                              .roundedBorder12),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    item[
                                                                        'bill_date'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: int.parse(item[
                                                                                'bill_status']) ==
                                                                            2
                                                                        ? AppStyle
                                                                            .txtPoppinsRegular12RedA400
                                                                            .copyWith(
                                                                                letterSpacing: getHorizontalSize(
                                                                                    1.0))
                                                                        : AppStyle
                                                                            .txtPoppinsRegular12Gray800
                                                                            .copyWith(
                                                                                letterSpacing: getHorizontalSize(1.0)),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        getPadding(
                                                                            top:
                                                                                10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                .start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "Invoice: " + item['inovice_number'],
                                                                                overflow: TextOverflow.ellipsis,
                                                                                textAlign: TextAlign.left,
                                                                                style: DateTime.parse(item['bill_date']).isAfter(DateTime.now()) && int.parse(item['bill_status']) == 2 ? AppStyle.txtPoppinsRegular12RedA400.copyWith(letterSpacing: getHorizontalSize(1.0)) : AppStyle.txtPoppinsRegular12Gray800.copyWith(letterSpacing: getHorizontalSize(1.0)),
                                                                              ),
                                                                              Padding(
                                                                                  padding: getPadding(top: 4),
                                                                                  child: Text(
                                                                                    int.parse(item['bill_status']) == 1 ? "Paid" : "Outstanding",
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    textAlign: TextAlign.left,
                                                                                    style: DateTime.parse(item['bill_date']).isAfter(DateTime.now()) && int.parse(item['bill_status']) == 2 ? AppStyle.txtPoppinsRegular12RedA400.copyWith(letterSpacing: getHorizontalSize(1.0)) : AppStyle.txtPoppinsRegular12Gray800.copyWith(letterSpacing: getHorizontalSize(1.0)),
                                                                                  ))
                                                                            ]),
                                                                        Padding(
                                                                            padding: getPadding(
                                                                                top:
                                                                                    11,
                                                                                bottom:
                                                                                    11),
                                                                            child:
                                                                                Text(
                                                                              "\$" +
                                                                                  item['amount'],
                                                                              overflow:
                                                                                  TextOverflow.ellipsis,
                                                                              textAlign:
                                                                                  TextAlign.left,
                                                                              style: DateTime.parse(item['bill_date']).isAfter(DateTime.now()) && int.parse(item['bill_status']) == 2
                                                                                  ? AppStyle.txtPoppinsRegular12RedA400.copyWith(letterSpacing: getHorizontalSize(1.0))
                                                                                  : AppStyle.txtPoppinsRegular12Gray800.copyWith(letterSpacing: getHorizontalSize(1.0)),
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
                                                  ])))
                                    ]));
                          })))),
        );
  }

  onTapListdue(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.viewBillScreen);
  }

  onTapListPaid(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.receiptScreen);
  }
}
