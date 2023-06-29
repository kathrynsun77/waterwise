import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/custom_button.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({Key? key}) : super(key: key);

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}
// ignore_for_file: must_be_immutable
class _VouchersScreenState extends State<VouchersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: SingleChildScrollView(
        child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(
                      top:25,
                      left:30,
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
      Column(
        children: [
          Container(
            color: Colors.white,
            padding: getPadding(top: 30, left:10, right: 10,bottom: 20),
            child: Column(
              children: [
                ProgressBarSteppers(),
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
                      'Total Points: 500',
                      textAlign: TextAlign.left,
                      style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
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
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Align(
            // alignment: Alignment.centerLeft,
            child: Text(
              'Points History',
              style: AppStyle.txtPoppinsSemiBold18Gray800.copyWith(
                letterSpacing: getHorizontalSize(
                  1.0,
                )
              )
            ),
          ),
          SizedBox(height: 8),
          Container(
            color: Colors.white,
            padding:getPadding(top: 16, right: 130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PointHistoryItem(
                  text: 'Points Earned',
                  points: 50,
                  date: 'June 28, 2023',
                ),
              ],
            ),
          ),
        ],
      ),
    ]
        )
            )
        )
    );
  }
}

  onTapMyvouchers(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
  }


class ProgressBarSteppers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 1; i <= 7; i++)
          CircleAvatar(
            backgroundColor: i <= 3 ? Color(0xFF6F9C95) : Colors.grey,
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