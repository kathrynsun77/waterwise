import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/app_bar/appbar_image.dart';
import 'package:WaterWise/widget/app_bar/custom_app_bar.dart';
import 'package:WaterWise/widget/custom_button2.dart';
import 'package:WaterWise/widget/custom_switch.dart';
import '../../API.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalAmount = 0;
  bool isSelectedSwitch = false;
  // String API = "http://172.28.200.128/water_wise/";
  // String API= "http://10.33.133.168/water_wise/";
  // String API= "http://192.168.1.12/water_wise/";

  Map user = {};
  int quantity = 1;

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      fetchProducts();
      fetchTotal();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    fetchProducts();
    fetchTotal();
  }

  List cart = [];
  fetchProducts() async {
    final response = await http.post(
        Uri.parse(API+'cart.php'),
        body: {
          'cust-id': user['customer_id'],
        });
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      cart = json.decode(response.body);
      setState(() {
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  List total = [];
  fetchTotal() async {
    final response = await http.post(
        Uri.parse(API+'total_price.php'),
        body: {
          'cust-id': user['customer_id'],
        });
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

  removeCart(String id) async {
    final response = await http.post(
        Uri.parse(API+'delete_cart.php'),
        body: {
          'cust-id': user['customer_id'],
          'product': id,
        });
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      setState(() {
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }


  @override
  Widget build(BuildContext context) {
    for (var item in cart) {
      totalAmount += (double.parse(item['product_price'])*quantity);
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: getVerticalSize(68),
                leadingWidth: 375,
                leading: Container(
                    height: getVerticalSize(30),
                    width: getHorizontalSize(24),
                    margin:
                    getMargin(left: 19, top: 13, right: 332, bottom: 13),
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      AppbarImage(
                          height: getVerticalSize(14),
                          width: getHorizontalSize(7),
                          svgPath:  ImageConstant.imgArrowleftIndigo800,
                          margin: getMargin(left: 8, right: 9, bottom: 16),
                          onTap: () {
                            onTapArrowleft2(context);
                          }),
                      AppbarImage(
                          height: getSize(24),
                          width: getSize(24),
                          svgPath:  ImageConstant.imgArrowleftIndigo800,
                          margin: getMargin(top: 6),
                          onTap: () {
                            onTapArrowleftone1(context);
                          })
                    ]))),
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left:15,top: 8, right: 40, bottom: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("My cart",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsSemiBold20),
                        Padding(
                            padding: getPadding(top: 31),
                            child: ListView.builder(
                                itemCount: cart.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Map item = cart[index];
                                  quantity = int.parse(item['qty']);
                                  return Padding(
                                    padding: getPadding(top: 25, bottom: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                          removeCart(item['product_id'].toString());
                                          setState(() {
                                            fetchProducts();
                                            fetchTotal();
                                          });
                                          },
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgChopardperfume,
                                          height: getVerticalSize(84,),
                                          width: getHorizontalSize(40,),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            left: 32,
                                            bottom: 12,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: getHorizontalSize(
                                                  72,
                                                ),
                                                child: Text(
                                                  "${item['product_name']}",
                                                  maxLines: null,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle.txtPoppinsRegular1633,
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  top: 3,
                                                ),
                                                child: Text(
                                                  "\$${item['product_price']}",
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle.txtPoppinsSemiBold1143Gray600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: getHorizontalSize(40),
                                          height: getVerticalSize(20),
                                          margin: getMargin(left: 10, top: 31, bottom: 31,right:70),
                                          padding: getPadding(top: 1, right: 15, bottom: 1,),
                                          decoration: AppDecoration.txtOutlineBluegray100.copyWith(
                                            borderRadius: BorderRadiusStyle.txtCircleBorder11,
                                          ),
                                          child: Text( "${quantity.toString()}",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtPoppinsSemiBold1143Gray900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                        Padding(
                            padding: getPadding(top: 104),
                            child: Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.blueGray100,
                                indent: getHorizontalSize(4),
                                endIndent: getHorizontalSize(8))),
                        Padding(
                            padding: getPadding(left: 10, top: 10, right: 5),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: getPadding(bottom: 1),
                                      child: Text("Total Amount+GST(8%)",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtPoppinsSemiBold1143Gray900)),
                                  Text(
                                      total.isNotEmpty ? total[0]['total'].toString() : '0',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtPoppinsSemiBold1306)
                                ])),
                        Padding(
                            padding: getPadding(top: 7, left:10),
                            child: Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.blueGray100,
                                indent: getHorizontalSize(4),
                                endIndent: getHorizontalSize(8))),
                        CustomButton(
                            height: getVerticalSize(45),
                            text: "Checkout",
                            margin: getMargin(left: 6, top: 41, right: 6, bottom: 5),
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.popUpMarketplaceScreen);
                            },
                            padding: ButtonPadding.PaddingAll13,
                            fontStyle: ButtonFontStyle.PoppinsSemiBold1143)
                      ])),
            )));
  }

  onTapArrowleft2(BuildContext context) {
    Navigator.pop(context);
  }

  onTapArrowleftone1(BuildContext context) {
    Navigator.pop(context);
  }
}
