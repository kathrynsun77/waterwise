import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopupMarketplaceScreen extends StatefulWidget {
  const PopupMarketplaceScreen({Key? key}) : super(key: key);

  @override
  State<PopupMarketplaceScreen> createState() => _PopupMarketplaceScreenState();
}

class _PopupMarketplaceScreenState extends State<PopupMarketplaceScreen> {
  String API= "http://172.28.200.128/water_wise/";
  String? selectedCard; // Selected card
  Map<String, dynamic> user = {};
  bool isSwitched = false;
  var card;
  var point_value;
  var address;

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      card = user['default_payment_method_type'];
      address = user['address_id'];
      fetchData();
      fetchPoints();
      fetchTotal();
      fetchAddress();
      setState(() {});
    }
  }

  List total = [];
  fetchTotal() async {
    final response = await http.post(
        Uri.parse(API+'total_price.php'),
        body: {
          'cust-id': user['customer_id'].toString(),
        });
    print(response.body);
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      total = json.decode(response.body);
      setState(() {
      });
    } else {
      throw Exception('Failed to fetch data');
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

  List<Map<String, dynamic>> allCard = [];

  fetchData() async {
    final response = await http.post(
      Uri.parse(API+'payment_method.php'),
      body: {
        'cust-id': user['customer_id'],
      },
    );

    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      allCard = List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  List<Map<String, dynamic>> allAddress = [];
  fetchAddress() async {
    final response = await http.post(
      Uri.parse(API+'address.php'),
      body: {
        'cust-id': user['customer_id'],
      },
    );
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      allAddress = List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    fetchTotal();
    fetchAddress();
  }

  void addTransaction(String amount, String point) async {
    var url = API+'make_payment_marketplace.php';
    var response = await http.post(Uri.parse(url), body: {
      'cust-id': user['customer_id'],
      'amount': amount,
      'payment-id': card,
      'point': point,
      'address':address,
    });
    // print('transaction added');
    // print(card);
    print(response.body);
    if (response.statusCode == 200) {
      print('success');
      print(response.body);
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalAll = total.isNotEmpty ? double.parse(total[0]['total']) : 0.00;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: 375, // Set the desired width
          height: 500, // Set the desired height
          alignment: Alignment.centerLeft, // Adjust the alignment as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(top: 20, left: 20),
                child: DropdownButtonFormField<String>(
                  value: address != null ? address.toString() : null,
                  onChanged: (String? newValue) {
                    setState(() {
                      address = newValue!;
                    });
                    print('dropdown: $address');
                    if (newValue == 'manage_address') {
                      // Navigate to the address management page
                      Navigator.pushNamed(context, AppRoutes.cartScreen);
                    }
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'manage_address',
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Text(
                            'Manage Address',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsSemiBold14.copyWith(
                              letterSpacing: getHorizontalSize(1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...allAddress.map<DropdownMenuItem<String>>((item) {
                      return DropdownMenuItem<String>(
                        value: item['address_id'].toString(),
                        child: Row(
                          children: [
                            SizedBox(width: 16),
                            Text(
                              item['building_street'] + " " + item['postal_code'] + " " + item['unit_no'],
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsSemiBold14.copyWith(
                                letterSpacing: getHorizontalSize(1.0),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),

              ),
              Padding(
                padding: getPadding(top: 20, left: 20),
                child: DropdownButtonFormField<String>(
                  value: card.toString(),
                  onChanged: (String? newValue) {
                    setState(() {
                      card = newValue!;
                    });
                    print('dropdown: $card');
                  },
                  items: allCard.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item['card_payment_id'].toString(),
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: int.parse(item['card_type']) == 1 ? "assets/images/img_visa1.png" : "assets/images/master.png",
                            height: getVerticalSize(28),
                            width: getHorizontalSize(45),
                                       ),
                          SizedBox(width: 16),
                          Text(
                            "••••  ••••  ••••  ${item['card_name'].substring(item['card_name'].length - 4)}",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsSemiBold14.copyWith(
                              letterSpacing: getHorizontalSize(1.0),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: getPadding(top: 16, left: 20),
                child: Divider(
                  height: getVerticalSize(1),
                  thickness: getVerticalSize(1),
                  color: ColorConstant.gray300,
                ),
              ),
              Padding(
                padding: getPadding(top: 16, left: 20),
                child: Text(
                  "Payment Summary",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtPoppinsSemiBold14.copyWith(
                    letterSpacing: getHorizontalSize(1.0),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(top: 16, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: getPadding(top: 3),
                      child: Text(
                        "Amount+GST(8%)",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsRegular12Gray400.copyWith(
                          letterSpacing: getHorizontalSize(0.6),
                        ),
                      ),
                    ),
                    Text(
                      "\$"+totalAll.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold14.copyWith(
                        letterSpacing: getHorizontalSize(1.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: getPadding(top: 16, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: getPadding(top: 1, bottom: 1),
                      child: Text(
                        "Admin Fee",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsRegular12Gray400.copyWith(
                          letterSpacing: getHorizontalSize(0.6),
                        ),
                      ),
                    ),
                    Text(
                      "\$"+"2.5",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold14.copyWith(
                        letterSpacing: getHorizontalSize(1.0),
                      ),
                    ),
                  ],
                ),
              ),
                ListView.builder(
                itemCount: points.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                Map balance = points[index];
                return Padding(
                padding: getPadding(top: 16, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Redeem Points: "+balance['total_point'],
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold14Bluegray700.copyWith(
                        letterSpacing: getHorizontalSize(1.0),
                      ),
                    ),
                    Switch(
                      value: isSwitched, // Replace isSwitched with your own variable controlling the switch state
                      onChanged: (value) {
                        setState(() {
                          point_value= double.parse(balance['total_point']);
                          isSwitched = value; // Replace isSwitched with your own variable controlling the switch state
                        });
                      },
                    ),
                  ],
                ),
              );
                }
                ),

              Padding(
                padding: getPadding(top: 16, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold14Bluegray700.copyWith(
                        letterSpacing: getHorizontalSize(1.0),
                      ),
                    ),
                    Text(
                      isSwitched ? "\$" + (totalAll+2.5 - point_value).toStringAsFixed(2) : "\$" + (totalAll+2.5).toStringAsFixed(2),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold14Bluegray700.copyWith(
                        letterSpacing: getHorizontalSize(1.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomButton(
          height: getVerticalSize(51),
          width: getHorizontalSize(208),
          text: "Make Payment",
          margin: getMargin(left: 83, right: 83, bottom: 350),
          onTap: () {
            double fin_total = isSwitched ? totalAll - point_value : totalAll;
            var point_red = isSwitched ? point_value : 0;
            addTransaction(fin_total.toStringAsFixed(2), point_red.toString());
            onTapTopupnow(context);
          },
        ),
      ),
    );
  }

  onTapTopupnow(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.successTransactionsScreen);
  }
}
