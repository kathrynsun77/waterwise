import 'dart:convert';
import 'package:WaterWise/ui/productdetails_screen/productdetails_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/app_bar/appbar_image.dart';
import 'package:WaterWise/widget/app_bar/custom_app_bar.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  TextEditingController searchController = TextEditingController();

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://your-api-url/products'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<void> fetchProductData() async {
    try {
      final productList = await fetchProducts();
      setState(() {
        products = productList;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                height: getVerticalSize(62),
                leadingWidth: 34,
                leading: AppbarImage(
                    height: getVerticalSize(14),
                    width: getHorizontalSize(7),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 27, top: 25, bottom: 23),
                    onTap: () {
                      onTapArrowleft(context);
                    }),
                title: Padding(
                    padding: getPadding(left: 22),
                    child: Text("Marketplace",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtPoppinsSemiBold2000.copyWith(letterSpacing: getHorizontalSize(1.0))
                    )
                ),
                styleType: Style.bgFillBluegray400),
            body: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                    padding: getPadding(top: 39),
                    child: Padding(
                        padding: getPadding(left: 27, right: 38),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: getPadding(left: 0),
                                  child: Row(
                                      // mainAxisAlignment:
                                      // MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomImageView(
                                            svgPath: ImageConstant.imgIonbagoutline,
                                            height: getVerticalSize(24),
                                            width: getHorizontalSize(23),
                                            margin: getMargin(left: 0, top: 10, bottom: 10),
                                            onTap: () {
                                              onTapImgIonbagoutline(context);
                                            }),
                                        Padding(
                                          padding: getPadding(left:0),
                                          child:
                                          SearchBarAnimation(
                                            textEditingController: searchController,
                                            isOriginalAnimation: true,
                                            enableKeyboardFocus: true,
                                            searchBoxWidth: 250, // Adjust the collapsed width as per your requirements
                                            onExpansionComplete: () {
                                              debugPrint(
                                                  'Search Product');
                                            },
                                            onCollapseComplete: () {
                                              debugPrint(
                                                  'Nothing');
                                            },
                                            onPressButton: (isSearchBarOpens) {
                                              debugPrint(
                                                  'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
                                            },
                                            trailingWidget: const Icon(
                                              Icons.search,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            secondaryButtonWidget: const Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            buttonWidget: const Icon(
                                              Icons.search,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ])),
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: getPadding(
                                          left: 23, top: 23, right: 13),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding: getPadding(top: 1),
                                                child: Text("Pipe",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsSemiBold1143)),
                                            Spacer(flex: 52),
                                            Padding(
                                                padding: getPadding(bottom: 1),
                                                child: Text("Tools",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsRegular1143)),
                                            Spacer(flex: 47),
                                            Padding(
                                                padding: getPadding(bottom: 1),
                                                child: Text("Others",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsRegular1143))
                                          ]))),
                              SizedBox(
                                  width: getHorizontalSize(90),
                                  child: Divider(
                                      height: getVerticalSize(3),
                                      thickness: getVerticalSize(3),
                                      color: ColorConstant.blueGray700,
                                      indent: getHorizontalSize(17))),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      height: getVerticalSize(670),
                                      width: getHorizontalSize(291),
                                      child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Align(
                                                alignment: Alignment.topCenter,
                                                child: SizedBox(
                                                    height:
                                                    getVerticalSize(635),
                                                )),
                                            Align(
                                                alignment: Alignment.topCenter,
                                                child: Padding(
                                                    padding:
                                                    getPadding(top: 155),
                                                    child: SizedBox(
                                                        width:
                                                        getHorizontalSize(
                                                            281),
                                                       ))),
                                            Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                    width:
                                                    getHorizontalSize(281),
                                                )
                                            ),
                                            Align(
                                                alignment:
                                                Alignment.bottomCenter,
                                                child: Padding(
                                                    padding:
                                                    getPadding(bottom: 142),
                                                    child: SizedBox(
                                                        width:
                                                        getHorizontalSize(
                                                            281),
                                                    )
                                                )
                                            ),
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: SizedBox(
                                                    width:
                                                    getHorizontalSize(281),
                                                )
                                            ),
                                        // Add the product list here
                                        ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: products.length,
                                        itemBuilder: (context, index) {
                                          final product = products[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProductdetailsScreen(productId: product.id),
                                                ),
                                              );
                                            },
                                            child: ListTile(
                                              title: Text(product.name),
                                              subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
                                              leading: Image.network(product.photoUrl),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                      )
                                  )
                              )
                            ]
                        )
                    )
                )
            )
        )
    );
  }

  onTapImgIonbagoutline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cartScreen);
  }

  onTapColumnpipaabuab(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productdetailsScreen);
  }

  onTapColumnpipaabuab1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productdetailsScreen);
  }

  onTapColumnpipaabuab2(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productdetailsScreen);
  }

  onTapColumnpipaabuab3(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productdetailsScreen);
  }

  onTapColumnpipaabuab4(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productdetailsScreen);
  }

  onTapColumnpipaabuab5(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productdetailsScreen);
  }

  onTapColumnpipaabuab6(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productdetailsScreen);
  }

  onTapColumnpipaabuab7(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productdetailsScreen);
  }

  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String photoUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.photoUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      photoUrl: json['photoUrl'],
    );
  }
}

