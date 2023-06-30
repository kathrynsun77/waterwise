import 'dart:convert';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:WaterWise/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_bar/appbar_image.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class ActivityTrendsScreen extends StatefulWidget {
  const ActivityTrendsScreen({Key? key}) : super(key: key);

  @override
  State<ActivityTrendsScreen> createState() => _ActivityTrendsScreenState();
}

class _ActivityTrendsScreenState extends State<ActivityTrendsScreen> {
  Map user = {};
  List<BarData> barDataList = [];

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      fetchData();
      downloadAndOpenPDF();
      setState(() {});
    }
  }

  downloadAndOpenPDF() async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'http://172.28.200.128:8000/api/pdf',
        data: {
          'cust-id': user['customer_id'],
        },
      );
      print('data sent');

      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/report.pdf';
        await dio.download("http://172.28.200.128:8000/api/pdf", filePath);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PDFView(
              filePath: filePath,
            ),
          ),
        );
        print('success');
      } else {
        // Handle error
        print('Failed to download PDF: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Failed to download PDF: $e');
    }
  }

  fetchData() async {
    final response = await http.post(
      Uri.parse('http://172.28.200.128/water_wise/water_trends.php'),
      body: {
        'cust-id': user['customer_id'],
      },
    );
    print('fetch data trends');
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the response data
      final jsonData = jsonDecode(response.body);
      List<BarData> data = [];
      for (var item in jsonData) {
        final barData = BarData(
          label: item['transaction_date'],
          value: int.parse(item['usage_amount']),
        );
        data.add(barData);
      }
      setState(() {
        barDataList = data;
      });
      print('bar data list: ${barDataList.length}');
    } else {
      // Error handling
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        appBar: CustomAppBar(
          height: getVerticalSize(60),
          leadingWidth: 39,
          leading: Container(
            height: getVerticalSize(16),
            width: getHorizontalSize(9),
            margin: getMargin(left: 30, top: 26, bottom: 14),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AppbarImage(
                  height: getVerticalSize(16),
                  width: getHorizontalSize(9),
                  svgPath: ImageConstant.imgArrowleftIndigo800,
                  onTap: () {
                    onTapArrowleft(context);
                  },
                ),
                AppbarImage(
                  height: getVerticalSize(16),
                  width: getHorizontalSize(9),
                  svgPath: ImageConstant.imgArrowleftIndigo800,
                ),
              ],
            ),
          ),
          actions: [
            CustomButton(
              height: getVerticalSize(32),
              width: getHorizontalSize(90),
              text: "Download Report",
              margin: getMargin(left: 18, top: 12, right: 18, bottom: 12),
              variant: ButtonVariant.OutlineBluegray40001,
              fontStyle: ButtonFontStyle.PoppinsMedium8,
              onTap: () {
                downloadAndOpenPDF();
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            fetchData();
          },
          child: Container(
            width: double.maxFinite,
            child: Container(
              width: double.maxFinite,
              margin: getMargin(top: 1),
              padding: getPadding(
                left: 30,
                top: 34,
                right: 30,
                bottom: 34,
              ),
              decoration: AppDecoration.fillGray50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Water Usage",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtPoppinsSemiBold18Bluegray700.copyWith(
                      letterSpacing: getHorizontalSize(1.0),
                    ),
                  ),
                  Padding(
                    padding: getPadding(top: 9),
                    child: Row(
                      children: [
                        CustomButton(
                          height: getVerticalSize(38),
                          width: getHorizontalSize(59),
                          text: "Usage",
                          variant: ButtonVariant.OutlineGray300,
                          fontStyle: ButtonFontStyle.PoppinsMedium12Gray400,
                          onTap: () {
                            onTapUsage(context);
                          },
                        ),
                        CustomButton(
                          height: getVerticalSize(38),
                          width: getHorizontalSize(62),
                          text: "Trends",
                          margin: getMargin(left: 16),
                          variant: ButtonVariant.OutlineBluegray400,
                          fontStyle: ButtonFontStyle.PoppinsMedium12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: getMargin(
                      left: 1,
                      top: 30,
                      right: 7,
                      bottom: 5,
                    ),
                    padding: getPadding(
                      left: 24,
                      top: 25,
                      right: 24,
                      bottom: 25,
                    ),
                    decoration: AppDecoration.outlineBlack9003f1.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: DChartBar(
                        data: [
                          {
                            'id': 'Bar',
                            'data': barDataList.map(
                              (e) {
                                return {
                                  'domain': e.label,
                                  'measure': e.value,
                                };
                              },
                            ).toList(),
                          },
                        ],
                        domainLabelPaddingToAxisLine: 16,
                        axisLineTick: 2,
                        axisLinePointTick: 2,
                        axisLinePointWidth: 10,
                        axisLineColor: Color(0xFF6F9C95),
                        measureLabelPaddingToAxisLine: 16,
                        barColor: (barData, index, id) => Color(0xFF6F9C95),
                        showBarValue: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapUsage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.activityScreen);
  }

  void onTapArrowleft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
  }
}

class BarData {
  final String label;
  final int value;

  BarData({
    required this.label,
    required this.value,
  });
}
