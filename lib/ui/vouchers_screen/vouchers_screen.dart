import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({Key? key}) : super(key: key);

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  bool checkInClicked = false;

  Map user = {};

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
        Uri.parse('http://172.28.200.128/water_wise/get_points.php'),
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

  List allBill = [];
  fetchData() async {
    final response = await http.post(
        Uri.parse('http://172.28.200.128/water_wise/points_page.php'),
        body: {
          'cust-id': user['customer_id'],
        });

    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      allBill = json.decode(response.body);
      setState(() {
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void onStepChanged(int currentStep) async {
    String data = currentStep == 7 ? '0.4' : '0.1';

    final response = await http.post(
      Uri.parse('YOUR_API_URL'),
      body: {
        'data': data,
      },
    );

    if (response.statusCode == 200) {
      // Data sent successfully
      print('Data sent to API: $data');
    } else {
      // Failed to send data
      print('Failed to send data to API');
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: RefreshIndicator(
        onRefresh: () async {
      fetchData();
    },
    child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  top: 25,
                  left: 30,
                ),
                child: Text(
                  "Points",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                    letterSpacing: getHorizontalSize(
                      1.0,
                    ),
                  ),
                ),
              ),
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
                          top: 30,
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
                                  'Total Points: '+item['total_point'],
                                  textAlign: TextAlign.left,
                                  style:
                                  AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
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
                                  // variant: ButtonVariant.OutlineBluegray40001,
                                  onTap: () {
                                    setState(() {
                                      checkInClicked = true;
                                    });
                                    if (onStepChanged != null) {
                                      onStepChanged(7); // Pass the current step as an argument
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
                              return
                              Container(
                              color: Colors.white,
                              padding: getPadding(top: 16, right: 100,left: 30),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              PointHistoryItem(
                              text: int.parse(item['transaction_type'])==3 ? "Points Earned" : "Point Used",
                              points: int.parse(item['transaction_amount']),
                              date: item['transaction_date'],
                              ),
                              ],
                              ),
                              );
                              })],
                              );
                },
                ),
            ],
          ),
        ),
      ),
    )
    );
  }
}


  onTapMyvouchers(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
  }


class ProgressBarSteppers extends StatelessWidget {
  final bool checkInClicked;
  final Function(int) onStepChanged; // New callback function

  ProgressBarSteppers({
    required this.checkInClicked,
    required this.onStepChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 1; i <= 7; i++)
          CircleAvatar(
            backgroundColor:
            checkInClicked && i <= 7 ? Color(0xFF6F9C95) : Colors.grey,
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
  final int points;
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