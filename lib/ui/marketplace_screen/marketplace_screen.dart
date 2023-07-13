import 'dart:convert';
import 'package:WaterWise/ui/productdetails_screen/productdetails_screen.dart';
import 'package:http/http.dart' as http;
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
  // String API = "http://172.28.200.128/water_wise/";
  String API= "http://10.33.133.168/water_wise/";
  List<Product> products = [];
  List<Product> searchProducts = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    final response = await http.get(Uri.parse(API+'marketplace.php'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      products = responseData.map((json) => Product.fromJson(json)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to fetch products');
    }
  }


  searchProduct() async {
    final response = await http.post(
        Uri.parse(API+'search_product.php'),
        body: {
          'keyword': searchController.text,
        });
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      searchProducts = responseData.map((json) => Product.fromJson(json)).toList();
      setState(() {
        products = searchProducts;
      });
    } else {
      throw Exception('Failed to fetch products');
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
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context, AppRoutes.ordersScreen);
                                          },
                                          child: Padding(
                                            padding: getPadding(right: 14),
                                            child: Icon(
                                              Icons.access_time_filled_outlined,
                                              size: getVerticalSize(24),
                                              color: Color(0xFF6F9C95),
                                              // Add any additional properties for customization
                                            ),
                                          ),
                                        ),
                                        CustomImageView(
                                            svgPath: ImageConstant.imgIonbagoutline,
                                            height: getVerticalSize(24),
                                            width: getHorizontalSize(23),
                                            margin: getMargin(left: 0, top: 10, bottom: 10),
                                            onTap: () {
                                              onTapImgIonbagoutline(context);
                                            }),
                                        Padding(
                                          padding: getPadding(left:10),
                                          child:
                                          SearchBarAnimation(
                                            textEditingController: searchController,
                                            isOriginalAnimation: true,
                                            enableKeyboardFocus: true,
                                            searchBoxWidth: 250,
                                            onExpansionComplete: () {
                                              debugPrint(
                                                  'Search Product');
                                            },
                                            onCollapseComplete: () {
                                              debugPrint('Collapsed');
                                              fetchProducts();
                                            },
                                            onPressButton: (isSearchBarOpens) {
                                              debugPrint(
                                                  'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');},
                                            onEditingComplete:(){

                                            },
                                            onFieldSubmitted:(){

                                            },
                                            trailingWidget: GestureDetector(
                                              onTap: () {
                                                print('tapped');
                                                searchProduct();
                                              },
                                              child: Icon(
                                                Icons.search,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                            secondaryButtonWidget: GestureDetector(
                                              onTap: () {
                                                print('tapped');
                                                searchProduct();
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                            buttonWidget: GestureDetector(
                                              child: Icon(
                                                Icons.search,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
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
                                                        width: getHorizontalSize(281),
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
                                              leading: Image(
                                                image: AssetImage('assets/images/img_girl.png'),
                                          ),

                                          // Image.network(product.photoUrl),
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
      id: int.parse(json['product_id']),
      name: json['product_name'],
      price: double.parse(json['product_price']),
      photoUrl: json['filenames'],
    );
  }
}

