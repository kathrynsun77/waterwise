import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../widget/custom_button_small.dart';

class ReceiptMarketplaceScreen extends StatefulWidget {
  final int orderId;

  const ReceiptMarketplaceScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<ReceiptMarketplaceScreen> createState() => _ReceiptMarketplaceScreenState();
}

class _ReceiptMarketplaceScreenState extends State<ReceiptMarketplaceScreen> {
  late int orderId;
  Map user = {};
  // String API = "http://172.28.200.128/water_wise/";
  // String API= "http://10.33.133.168/water_wise/";
  String API= "http://192.168.1.12/water_wise/";

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      setState(() {
        user = jsonDecode(userString);
      });
      fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    orderId = widget.orderId;
    getUser();
  }

  List<Map<String, dynamic>> allData = []; // Update the data type

  fetchData() async {
    final response = await http.post(
      Uri.parse(API + 'receipt_marketplace.php'),
      body: {
        'cust-id': user['customer_id'].toString(), // Convert to string
        'orderId': orderId.toString(), // Convert to string
      },
    );
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      final decodedData = json.decode(response.body);
      if (decodedData is List<dynamic>) {
        setState(() {
          allData = decodedData.cast<Map<String, dynamic>>(); // Cast the list elements to the desired type
        });
      } else if (decodedData is Map<String, dynamic>) {
        setState(() {
          allData = [decodedData]; // Wrap the map inside a list
        });
      } else {
        throw Exception('Invalid data type received');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray50,
        body: Container(
          width: double.maxFinite,
          padding: getPadding(all: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImageView(
                svgPath: ImageConstant.imgArrowleftIndigo800,
                height: getVerticalSize(16),
                width: getHorizontalSize(9),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: getPadding(left: 113, top: 34),
                child: Text(
                  "Order Details",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtPoppinsSemiBold18.copyWith(
                    letterSpacing: getHorizontalSize(1.0),
                  ),
                ),
              ),
              Expanded(
                // Added Expanded widget to make the ListView take available space
                child: ListView.builder(
                  itemCount: allData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = allData[index];
                    return Container(
                      width: double.maxFinite,
                      margin: getMargin(top: 39),
                      padding: getPadding(
                        left: 16,
                        top: 27,
                        right: 16,
                        bottom: 27,
                      ),
                      decoration: AppDecoration.white.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: getPadding(top: 1),
                                  child: Text(
                                    "${item['product_name']} \(\$${item['product_price']}\)",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsRegular12.copyWith(
                                      letterSpacing: getHorizontalSize(1.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(bottom: 1),
                                  child: Text(
                                    "Qty: "+item['qty'],
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
                            padding: getPadding(top: 10, bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Price",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsBold12.copyWith(
                                    letterSpacing: getHorizontalSize(1.0),
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(top: 10, bottom: 10),
                                  child: Text(
                                    "\$" + "${(double.parse(item['product_price'])*double.parse(item['qty'])).toString()}",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtPoppinsBold12.copyWith(
                                      letterSpacing: getHorizontalSize(1.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              CustomButton(
                height: getVerticalSize(29),
                width: getHorizontalSize(133),
                text: "Report a problem",
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.contactUsScreen);
                },
                margin: getMargin(left: 2, top: 35, bottom: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
