import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_checkbox.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({Key? key}) : super(key: key);

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

// ignore_for_file: must_be_immutable
class _ManageAddressScreenState extends State<ManageAddressScreen> {
  // String API= "http://172.28.200.128/water_wise/";
  // String API= "http://10.33.133.168/water_wise/";
  String API= "http://192.168.1.12/water_wise/";
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
      Uri.parse(API+'address.php'),
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

  deleteAddress(String address) async {
    final response = await http.post(
      Uri.parse(API+'delete_address.php'),
      body: {
        'address': address,
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

  void addAddress() async {
    var url = API+'add_address.php';
    var response = await http.post(Uri.parse(url), body: {
      'cust-id': user['customer_id'],
      'building_street': frameoneController.text,
      'postal_code': frameoneoneController.text,
      'unit_no': frameonetwoController.text,
      'phone_number': bankNameController.text
    });

    if (response.statusCode == 200) {
      print('success');
      print(response.body);
        Navigator.pushNamed(context, AppRoutes.manageAddressScreen);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Card Added'),
            backgroundColor: Color(0xFF6F9C95),
          ),
        );
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }

  void setDefaultAddress(String id) async {
    var url = API+'set_default_address.php';
    var response = await http.post(Uri.parse(url), body: {
      'address_id': id,
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
        Navigator.pushNamed(context, AppRoutes.manageAddressScreen);
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
                "Delivery Address",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                  letterSpacing: getHorizontalSize(
                    1.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: getPadding(top: 20, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
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
                    "Building Street",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    autofocus: true,
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
                    "Postal Code",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold12,
                  ),
                  CustomTextFormField(
                    focusNode: FocusNode(),
                    autofocus: true,
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
                      "Unit Number (optional)",
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
                addAddress();
              },
              margin: getMargin(top: 20, bottom: 5),
              alignment: Alignment.center,
            ),
            Padding(
              padding: getPadding(top: 16, left: 30),
              child: Divider(
                height: getVerticalSize(1),
                thickness: getVerticalSize(1),
                color: ColorConstant.gray300,
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
                          Padding(
                            padding: getPadding(left: 16, top: 2, bottom: 4),
                            child: Text(
                              item['building_street'] + " " + item['postal_code'] + " " + item['unit_no']+
                                  "\n Phone Number:"+item['phone_number'],
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
                                 "Default",
                                  style: AppStyle.txtPoppinsSemiBold12.copyWith(
                                    letterSpacing: getHorizontalSize(1.0),
                                  ),
                                ),
                                CustomCheckbox(
                                  value: item['address_id'] == user['address_id'],
                                  onChange: (value) {
                                    setState(() {
                                      setDefaultAddress(item['address_id'].toString());
                                    });
                                  },
                                  fontStyle: CheckboxFontStyle.PoppinsRegular8,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    deleteAddress(item['address_id'].toString());
                                    Navigator.pushNamed(context, AppRoutes.manageAddressScreen);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Address Deleted'),
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
          ],
        ),
      ),
    );
  }

  onTapPaymentmethods(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profileScreen);
  }

  void onTapImgArrowleft(BuildContext context) {
    Navigator.maybePop(context);
  }
}
