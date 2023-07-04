import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_bar/appbar_title.dart';
import '../../app_bar/custom_app_bar.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({Key? key}) : super(key: key);

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  String API= "http://10.33.133.168/water_wise/";
  bool checkInClicked = false;
  Map user = {};
  DateTime lastCheckInDate = DateTime.now();

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      setState(() {
        user = jsonDecode(userString);
      });
      fetchData();
      fetchPoints();
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
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
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  List allBill = [];

  fetchData() async {
    final response = await http.post(
        Uri.parse(API+'points_page.php'),
        body: {
          'cust-id': user['customer_id'],
        });

    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      allBill = json.decode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void onStepChanged(int currentStep) async {
    DateTime currentDate = DateTime.now();
    // Check if the current date is different from the last check-in date
    if (currentDate.day != lastCheckInDate.day) {
      String data = currentStep == 7 ? '0.4' : '0.1';

      final response = await http.post(
        Uri.parse(API+'check_in.php'),
        body: {
          'cust-id': user['customer_id'],
          'value': data,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Data sent to API: $data');
        setState(() {
          lastCheckInDate = currentDate; // Update the last check-in date
        });
      } else {
        // Failed to send data
        print('Failed to send data to API');
      }
    } else {
      // Check-in already done today, show a message or perform any desired action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check-in already done today'),
          backgroundColor: Color(0xFF6F9C95),
        ),
      );
      print('Check-in already done today');
    }
  }

  bool _isRefreshing = false;

  Future<void> _refreshData() async {
    fetchData();
    fetchPoints();
    // Simulating a delay of 2 seconds for demonstration purposes
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Update your data variables here

      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        height: getVerticalSize(83),
        title: Padding(
          padding: getPadding(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppbarTitle(
                text: "Points",
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: points.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Map item = points[index];
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: getPadding(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: 20,
                        ),
                        child: Column(
                          children: [
                            ProgressBarSteppers(
                              checkInClicked: checkInClicked,
                              onStepChanged: onStepChanged,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.account_balance_wallet,
                                  size: 35,
                                  color: Color(0xFF6F9C95),
                                ),
                                Text(
                                  'Total Points: ' + item['total_point'],
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtPoppinsSemiBold18Gray800
                                      .copyWith(
                                    letterSpacing: getHorizontalSize(
                                      1.0,
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  height: getVerticalSize(40),
                                  width: getHorizontalSize(80),
                                  text: "Check In",
                                  fontStyle: ButtonFontStyle.PoppinsWhite800,
                                  onTap: () {
                                    setState(() {
                                      checkInClicked = true;
                                    });
                                    if (onStepChanged != null) {
                                      onStepChanged(
                                          7); // Pass the current step as an argument
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        child: Text(
                          'Points History',
                          style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                            letterSpacing: getHorizontalSize(
                              1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ListView.builder(
                          itemCount: allBill.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Map item = allBill[index];
                            return Container(
                              color: Colors.white,
                              padding:
                                  getPadding(top: 16, right: 100, left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PointHistoryItem(
                                    text:
                                        int.parse(item['transaction_type']) == 3
                                            ? "Points Earned"
                                            : "Point Used",
                                    points: double.parse(
                                        item['transaction_amount']),
                                    date: item['transaction_date'],
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

onTapMyvouchers(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
}

class ProgressBarSteppers extends StatelessWidget {
  final bool checkInClicked;
  final Function(int) onStepChanged;

  ProgressBarSteppers({
    required this.checkInClicked,
    required this.onStepChanged,
  });

  @override
  Widget build(BuildContext context) {
    DateTime lastCheckInDate = DateTime.now();
    DateTime currentDate = DateTime.now();
    int currentStep = currentDate.difference(lastCheckInDate).inDays + 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 1; i <= 7; i++)
          CircleAvatar(
            backgroundColor: i <= currentStep ? Color(0xFF6F9C95) : Colors.grey,
            child: Text(
              i == 7 ? '+0.4' : '+0.1',
              style: TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }
}

class PointHistoryItem extends StatelessWidget {
  final String text;
  final double points;
  final String date;

  const PointHistoryItem({
    required this.text,
    required this.points,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppStyle.txtPoppinsRegular12Gray800.copyWith(
            letterSpacing: getHorizontalSize(1.0),
          ),
        ),
        SizedBox(height: 8),
        Text(
          '$points points',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 4),
        Text(
          'Earned on $date',
          style: AppStyle.txtPoppinsRegular12Gray800.copyWith(
            letterSpacing: getHorizontalSize(1.0),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
