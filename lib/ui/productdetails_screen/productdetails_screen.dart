import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/app_bar/appbar_image.dart';
import 'package:WaterWise/widget/app_bar/custom_app_bar.dart';
import 'package:WaterWise/widget/custom_button2.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductdetailsScreen extends StatefulWidget {
  final int productId;

  const ProductdetailsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductdetailsScreen> createState() => _ProductdetailsScreenState();
}

class _ProductdetailsScreenState extends State<ProductdetailsScreen> {
  late int productId;
  // String API = "http://172.28.200.128/water_wise/";
  String API= "http://10.33.133.168/water_wise/";
  int quantity = 1;
  Map user = {};

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      addToCart();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    productId = widget.productId;
    getUser();
    fetchProducts();
  }


  List products = [];
  fetchProducts() async {
    final response = await http.post(
        Uri.parse(API+'product_details.php'),
        body: {
          'product': productId.toString(),
        });
    // print('fetched');
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      products = json.decode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  addToCart() async {
    final response = await http.post(
        Uri.parse(API+'add_cart.php'),
        body: {
          'product': productId.toString(),
          'cust-id': user['customer_id'].toString(),
          'qty':quantity.toString(),
        });
    // print('fetched');
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(56),
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
                            onTapArrowleft1(context);
                          }),
                      AppbarImage(
                          height: getSize(24),
                          width: getSize(24),
                          svgPath:  ImageConstant.imgArrowleftIndigo800,
                          margin: getMargin(top: 6),
                          onTap: () {
                            onTapArrowleftone(context);
                          })
                    ]))),
            body: SingleChildScrollView(
              child: ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
              Map item = products[index];
              return Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 15, top: 25, right: 15, bottom: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomImageView(
                            svgPath: ImageConstant.imgIonbagoutline,
                            height: getVerticalSize(24),
                            width: getHorizontalSize(23),
                            margin: getMargin(left: 300, top: 5),
                            onTap: () {
                              onTapImgIonbagoutline(context);
                            }),
                        Padding(
                            padding: getPadding(left: 9, top: 20),
                            child: Text(item['product_name'],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsRegular32)
                        ),
                        Padding(
                            padding: getPadding(left: 9, top: 5),
                            child: Text("\$${item['product_price']}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsSemiBold16)),
                        CustomImageView(
                            imagePath: ImageConstant.imgImage1,
                            height: getVerticalSize(220),
                            width: getHorizontalSize(285),
                            margin: getMargin(left: 10, top: 38)),
                        Padding(
                            padding: getPadding(top: 25),
                            child: Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.blueGray100)),
                        Padding(
                            padding: getPadding(top: 15),
                            child: Row(children: [
                              CustomImageView(
                                  svgPath: ImageConstant.imgIcbaselineplus,
                                  height: getSize(24),
                                  width: getSize(24),
                                  onTap: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        quantity--;  // Decrement the quantity value, but ensure it doesn't go below 1
                                      }
                                    });
                                  },
                                  margin: getMargin(top: 2, bottom: 2)),
                              CustomButton(
                                height: getVerticalSize(28),
                                width: getHorizontalSize(46),
                                text: quantity.toString(),  // Display the current quantity value
                                margin: getMargin(left: 8),
                                variant: ButtonVariant.OutlineBluegray100,
                                shape: ButtonShape.CircleBorder14,
                                onTap: () {
                                  setState(() {
                                    quantity.toString();
                                  });
                                },
                              ),
                              CustomImageView(
                                  svgPath:
                                  ImageConstant.imgIcbaselineplusGray90001,
                                  height: getSize(24),
                                  width: getSize(24),
                                onTap: () {
                                  setState(() {
                                    if (quantity >= 1) {
                                      quantity++;
                                    }
                                  });
                                },
                                  margin: getMargin(left: 8, top: 2, bottom: 2))
                            ])),
                        Padding(
                            padding: getPadding(top: 16),
                            child: Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.blueGray100)),
                        Container(
                            width: getHorizontalSize(329),
                            margin: getMargin(top: 15, right: 15),
                            child: Text(
                                "${item['product_description']}",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsRegular14Gray500)),
                        Container(
                            width: getHorizontalSize(329),
                            margin: getMargin(top: 15, right: 15),
                            child: Text(
                                "Seller: ${item['fname']}",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsRegular14Gray500)),
                        Container(
                            width: getHorizontalSize(329),
                            margin: getMargin(top: 15, right: 15),
                            child: Text(
                                "Seller Email: ${item['email']}",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsRegular14Gray500)),
                        Container(
                            width: getHorizontalSize(329),
                            margin: getMargin(top: 15, right: 15),
                            child: Text(
                                "Seller Phone: ${item['mobile']}",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtPoppinsRegular14Gray500)),
                        CustomButton(
                          text: "Add to cart",
                          fontStyle: ButtonFontStyle.PoppinsSemiBold14WhiteA700,
                          height: 40,
                          prefixWidget: Container(
                            margin: EdgeInsets.only(right: 8),
                            child: CustomImageView(
                              svgPath: ImageConstant.imgIcbaselineplusWhiteA700,
                            ),
                          ),
                          onTap: () {
                          addToCart();
                          },
                        ),
                      ]));
            }
            ),
            )
        )
    );
  }

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }
  onTapImgIonbagoutline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cartScreen);
  }

  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
