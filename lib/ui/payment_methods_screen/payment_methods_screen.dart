import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_checkbox.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

// ignore_for_file: must_be_immutable
class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String API= "http://172.28.200.128/water_wise/";
  bool isCheckbox = false;
  bool isCheckbox1 = false;
  bool isCheckbox2 = false;
  TextEditingController bankNameController = TextEditingController();
  TextEditingController frameoneController = TextEditingController();
  TextEditingController frameoneoneController = TextEditingController();
  TextEditingController frameonetwoController = TextEditingController();
  TextEditingController getIdController = TextEditingController();

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

  List allCard = [];
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
      allCard = json.decode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  deleteCard(String cardID) async {
    final response = await http.post(
      Uri.parse(API+'delete_card.php'),
      body: {
        'card-id': cardID,
        'cust-id': user['customer_id'],
      },
    );

    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      allCard = json.decode(response.body);
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

  String getCardType(String cardNumber) {
    cardNumber = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    if (RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$').hasMatch(cardNumber)) {
      return '1';
    } else if (RegExp(r'^5[1-5][0-9]{14}$').hasMatch(cardNumber)) {
      return '2';
    } else {
      return '0';
    }
  }

  void addPayment() async {
    var url = API+'add_payment.php';
    var response = await http.post(Uri.parse(url), body: {
      'cust-id': user['customer_id'],
      'number': frameoneController.text,
      'month': frameoneoneController.text,
      'cvv': frameonetwoController.text,
      'type':getCardType(frameoneController.text),
      'bank_name': bankNameController.text
    });

    if (response.statusCode == 200) {
      print('success');
      print(response.body);
      try {
        Map responseBody = jsonDecode(response.body);
        Map payment_method = responseBody['data'];
        final pref = await SharedPreferences.getInstance();
        pref.setString('payment_method', jsonEncode(payment_method));
        Navigator.pushNamed(context, AppRoutes.paymentMethodsScreen);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Card Added'),
            backgroundColor: Color(0xFF6F9C95),
          ),
        );
      } catch (e) {
        print('Error decoding JSON: $e');
        // Handle the JSON decoding error here
      }
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }

  void setDefaultCard(String cardID) async {
    var url = API+'set_default_card.php';
    var response = await http.post(Uri.parse(url), body: {
      'card-id': cardID,
      'cust-id': user['customer_id'],
    });

    if (response.statusCode == 200) {
      print('success');
      print(response.body);
      try {
        Map responseBody = jsonDecode(response.body);
        Map user = responseBody['data'];
        final pref = await SharedPreferences.getInstance();
        pref.setString('user', jsonEncode(user));
        Navigator.pushNamed(context, AppRoutes.paymentMethodsScreen);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Default Card Changed!'),
            backgroundColor: Color(0xFF6F9C95),
          ),
        );
      } catch (e) {
        print('Error decoding JSON: $e');
        // Handle the JSON decoding error here
      }
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImageView(
                svgPath: ImageConstant.imgArrowleft,
                height: getVerticalSize(16),
                width: getHorizontalSize(9),
                margin: getMargin(left: 16,top:20),
                onTap: () {
                  onTapImgArrowleft(context);
                }),
            Padding(
              padding: getPadding(
                top: 25,
                left: 40,
              ),
              child: Text(
                "Payment Methods",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                  letterSpacing: getHorizontalSize(
                    1.0,
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: allCard.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Map item = allCard[index];
                  return Container(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                    Padding(
                      padding: getPadding(top: 42, left: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: int.parse(item['card_type']) == 1 ? "assets/images/img_visa1.png" : "assets/images/master.png",
                            height: getVerticalSize(28),
                            width: getHorizontalSize(45),
                          ),
                          Padding(
                            padding: getPadding(left: 16, top: 2, bottom: 4),
                            child: Text(
                              "••••  ••••  ••••  ${item['card_name'].substring(item['card_name'].length - 4)}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsSemiBold14.copyWith(
                                letterSpacing: getHorizontalSize(1.0),
                              ),
                            ),

                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  item['bank_name'],
                                  style: AppStyle.txtPoppinsSemiBold12.copyWith(
                                    letterSpacing: getHorizontalSize(1.0),
                                  ),
                                ),
                                CustomCheckbox(
                                  value: item['card_payment_id'] == user['default_payment_method_type'],
                                  onChange: (value) {
                                    setState(() {
                                      setDefaultCard(item['card_payment_id']);
                                    });
                                  },
                                  fontStyle: CheckboxFontStyle.PoppinsRegular8,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    deleteCard(item['card_payment_id']);
                                    Navigator.pushNamed(context, AppRoutes.paymentMethodsScreen);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Card Deleted'),
                                        backgroundColor: Color(0xFF6F9C95),
                                      ),
                                    );
                                  },
                                ),
                              ],

                            ),
                          ),
                        ],
                      ),
                    ),
                  ])));
                },
              ),
            ),
            Padding(
              padding: getPadding(top: 16, left: 30),
              child: Divider(
                height: getVerticalSize(1),
                thickness: getVerticalSize(1),
                color: ColorConstant.gray300,
              ),
            ),
            Padding(
              padding: getPadding(top: 20, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bank Name",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    autofocus: true,
                    controller: bankNameController,
                    margin: getMargin(top: 4),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(top: 10, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Card Number",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    controller: frameoneController,
                    margin: getMargin(top: 4),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(top: 20, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Expiry Date",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    autofocus: true,
                    hintText: "mm/yy",
                    controller: frameoneoneController,
                    margin: getMargin(top: 3),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: getPadding(top: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "CVV",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold12,
                    ),
                    CustomTextFormField(
                      width: getHorizontalSize(150),
                      focusNode: FocusNode(),
                      autofocus: true,
                      controller: frameonetwoController,
                      margin: getMargin(top: 4),
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
              height: getVerticalSize(51),
              width: getHorizontalSize(137),
              text: "Add",
              onTap: () {
                addPayment();
              },
              margin: getMargin(top: 20, bottom: 5),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }

  onTapPaymentmethods(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profileScreen);
  }

  void onTapImgArrowleft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
  }
}
