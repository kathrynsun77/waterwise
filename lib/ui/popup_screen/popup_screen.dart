import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:WaterWise/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopupScreen extends StatefulWidget {
  const PopupScreen({Key? key}) : super(key: key);

  @override
  State<PopupScreen> createState() => _PopupScreenState();
}

class _PopupScreenState extends State<PopupScreen> {

  TextEditingController promocodeinputController = TextEditingController();
  String? selectedCard; // Selected card
  Map<String, dynamic> user = {};
  List allBill=[];

  getBill() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("bill_amount");
    if (userString != null) {
      allBill = jsonDecode(userString);
      fetchData();
      setState(() {
      });
    }
  }

  getInvoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? invoice = prefs.getString("invoice");
    setState(() {});
    return invoice;
  }


  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      fetchData();
      setState(() {});
    }
  }


  List<Map<String, dynamic>> allCard = [];

  fetchData() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.8/water_wise/payment_method.php'),
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

  @override
  void initState() {
    super.initState();
    getUser();
    getBill();
    getInvoice();
  }

  void handleCardSelection(String id) async {
    var url = 'http://192.168.1.8/water_wise/make_payment.php';
    var response = await http.post(Uri.parse(url), body: {
      'payment-id':id,
    });
    if (response.statusCode == 200) {
      print('success');
      print(response.body);
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }  }


  void addTransaction(String amount, String usage) async {
    String? savedInvoice = await getInvoice();
    var url = 'http://192.168.1.8/water_wise/make_payment.php';
    var response = await http.post(Uri.parse(url), body: {
      'cust-id': user['customer_id'],
      'usage': usage,
      'amount': amount,
      'invoice': savedInvoice,
    // 'payment-id':id.toString()
    });

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
    // selectedCard = user['default_payment_method_type'];
    int totalMeter = 0;
    for (var item in allBill) {
      totalMeter += int.parse(item['meter_value']);
    }
    double totalAmount = totalMeter * 1.19;
    double totalAll = totalAmount+2.5;
    var card = user['default_payment_method_type'];
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
              Text(
                "",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsSemiBold14.copyWith(
                  letterSpacing: getHorizontalSize(1.0),
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
                  },
                  items: allCard.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: (item['card_payment_id'].toString() == user['default_payment_method_type'].toString())
                          ? item['card_payment_id']
                          : '',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Promo Code",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold12,
                    ),
                    CustomTextFormField(
                      focusNode: FocusNode(),
                      autofocus: true,
                      controller: promocodeinputController,
                      hintText: "Enter your code",
                      margin: getMargin(top: 4),
                      textInputAction: TextInputAction.done,
                    ),
                  ],
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
                      "\$"+totalAmount.toStringAsFixed(2),
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
                      "\$"+totalAll.toStringAsFixed(2),
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
            addTransaction(totalAll.toStringAsFixed(2),totalMeter.toStringAsFixed(2));
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
