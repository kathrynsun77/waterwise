import 'package:WaterWise/ui/orders_screen/orders_screen.dart';
import 'package:flutter/material.dart';
import '../ui/app_navigation_screen/app_navigation_screen.dart';
import '../ui/bottom_bar/bottom_bar_menu.dart';
import '../ui/home/home__screen.dart';
import '../ui/intro_screen/intro_screen.dart';
import '../ui/login_screen/login_screen.dart';
import '../ui/manage_address_screen/manage_address_screen.dart';
import '../ui/notification_screen/notification_screen.dart';
import '../ui/receipt_marketplace_screen/receipt_marketplace_screen.dart';
import '../ui/sign_up_screen/sign_up_screen.dart';
import '../ui/splash_screen/starting_splash_screen.dart';
import '../ui/profile_screen/profile_screen.dart';
import '../ui/update_account_screen/update_account_screen.dart';
import '../ui/billing_screen/billing_screen.dart';
import '../ui/view_bill_screen/view_bill_screen.dart';
import '../ui/success_transactions_screen/success_transactions_screen.dart';
import '../ui/activity_trends_screen/activity_trends_screen.dart';
import '../ui/activity_screen/activity_screen.dart';
import '../ui/payment_methods_screen/payment_methods_screen.dart';
import '../ui/contact_us_screen/contact_us_screen.dart';
import '../ui/estimate_screen/estimate_screen.dart';
import '../ui/popup_screen/popup_screen.dart';
import '../ui/popup_marketplace_screen/popup_marketplace_screen.dart';
import '../ui/vouchers_screen/vouchers_screen.dart';
import '../ui/receipt_screen/receipt_screen.dart';
import '../ui/marketplace_screen/marketplace_screen.dart';
import '../ui/cart_screen/cart_screen.dart';
import '../ui/productdetails_screen/productdetails_screen.dart';


class AppRoutes {
  static const String activityScreen = '/activity_screen';
  static const String estimateScreen = '/estimate_screen';
  static const String introScreen = '/intro_screen';
  static const String loginScreen = '/login_screen';
  static const String splashScreen = '/starting_splash_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String registerScreen = '/register_screen';
  static const String homeScreen = '/home_screen';
  static const String profileScreen = '/profile_screen';
  static const String updateAccountScreen = '/update_account_screen';
  static const String billingScreen = '/billing_screen';
  static const String viewBillScreen = '/view_bill_screen';
  static const String notificationScreen = '/notification_screen';
  static const String successTransactionsScreen = '/success_transactions_screen';
  static const String activityTrendsScreen = '/activity_trends_screen';
  static const String paymentMethodsScreen = '/payment_methods_screen';
  static const String contactUsScreen = '/contact_us_screen';
  static const String popUpScreen = '/pop_up_screen';
  static const String popUpMarketplaceScreen = '/pop_up_marketplace_screen';
  static const String bottomBarMenu = '/bottom_bar_menu';
  static const String vouchersScreen = '/vouchers_screen';
  static const String receiptScreen = '/receipt_screen';
  static const String productdetailsScreen = '/productdetails_screen';
  static const String marketplaceScreen = '/marketplace_screen';
  static const String cartScreen = '/cart_screen';
  static const String manageAddressScreen = '/manage_address_screen';
  static const String receiptMarketplaceScreen = '/receipt_marketplace_screen';
  static const String ordersScreen = '/orders_screen';



  static Map<String, WidgetBuilder> routes = {
    introScreen: (context) => IntroScreen(),
    loginScreen: (context) => LoginScreen(),
    splashScreen: (context) => SplashScreenPage(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    registerScreen: (context) => SignUpScreen(),
    homeScreen: (context) => HomeScreen(),
    profileScreen: (context) => ProfileScreen(),
    updateAccountScreen: (context) => UpdateAccountScreen(),
    billingScreen: (context) => BillingScreen(),
    viewBillScreen: (context) => ViewBillScreen(),
    notificationScreen: (context) => NotificationScreen(),
    successTransactionsScreen: (context) => SuccessTransactionsScreen(),
    activityScreen: (context) => ActivityScreen(),
    activityTrendsScreen: (context) => ActivityTrendsScreen(),
    paymentMethodsScreen: (context) => PaymentMethodsScreen(),
    contactUsScreen: (context) => ContactUsScreen(),
    estimateScreen: (context) => EstimateScreen(),
    popUpScreen: (context) => PopupScreen(),
    popUpMarketplaceScreen: (context) => PopupMarketplaceScreen(),
    bottomBarMenu: (context) => BottomBarMenu(),
    vouchersScreen: (context) => VouchersScreen(),
    receiptScreen: (context) => ReceiptScreen(),
    marketplaceScreen: (context) => MarketplaceScreen(),
    productdetailsScreen: (context) => ProductdetailsScreen(productId: 1,),
    cartScreen: (context) => CartScreen(),
    manageAddressScreen: (context) => ManageAddressScreen(),
    receiptMarketplaceScreen: (context) => ReceiptMarketplaceScreen(orderId: 1,),
    ordersScreen: (context) => OrdersScreen(),



  };
}
