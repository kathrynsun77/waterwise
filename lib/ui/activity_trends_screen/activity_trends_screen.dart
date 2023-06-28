import 'dart:convert';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:WaterWise/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_bar/appbar_image.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';


class ActivityTrendsScreen extends StatefulWidget {
  const ActivityTrendsScreen({Key? key}) : super(key: key);

  @override
  State<ActivityTrendsScreen> createState() => _ActivityTrendsScreenState();
}
class _ActivityTrendsScreenState extends State<ActivityTrendsScreen> {

  Map user = {};
  getUser() async{
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if(userString!=null){
      user = jsonDecode(userString);
      fetchData();
      sendData();
      setState(() {
      });
    }
  }

  sendData() async {
    final response = await http.post(
        Uri.parse('http://172.28.200.128:8000/api/pdf'),
        body: {
          'cust-id': user['customer_id'],
        });
    print('send data:');
    print(response.body);
    if (response.statusCode == 200) {
     print('bisa');
    } else {
      print('Failed to download PDF. Status code: ${response.statusCode}');
    }
  }

  static var httpClient = new HttpClient();
  downloadPdf(String url, String filename) async{
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file;
  }


  List<BarData> barDataList = [];
  @override
  void initState() {
    getUser();
    super.initState();
  }

  fetchData() async {
    final response = await http.post(
      Uri.parse('http://172.28.200.128/water_wise/show_transaction.php'),
      body: {
        'cust-id': user['customer_id']
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
                    child: Stack(alignment: Alignment.center, children: [
                      AppbarImage(
                          height: getVerticalSize(16),
                          width: getHorizontalSize(9),
                          svgPath: ImageConstant.imgArrowleftIndigo800,
                          onTap: () {
                            onTapArrowleft(context);
                          }),
                      AppbarImage(
                          height: getVerticalSize(16),
                          width: getHorizontalSize(9),
                          svgPath: ImageConstant.imgArrowleftIndigo800)
                    ])),
                actions: [
                  CustomButton(
                      height: getVerticalSize(32),
                      width: getHorizontalSize(90),
                      text: "Download Report",
                      margin:
                      getMargin(left: 18, top: 12, right: 18, bottom: 12),
                      variant: ButtonVariant.OutlineBluegray40001,
                      fontStyle: ButtonFontStyle.PoppinsMedium8,
                    onTap: () {
                        downloadPdf('http://172.28.200.128:8000/api/pdf', 'water_usage');
                    },
                  )
                ]
            ),
            body: Container(
                width: double.maxFinite,
                child: Container(
                    width: double.maxFinite,
                    margin: getMargin(top: 1),
                    padding:
                    getPadding(left: 30, top: 34, right: 30, bottom: 34),
                    decoration: AppDecoration.fillGray50,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              "Water Usage",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsSemiBold18Bluegray700
                                  .copyWith(
                                  letterSpacing: getHorizontalSize(1.0))
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
                                    fontStyle:
                                    ButtonFontStyle.PoppinsMedium12Gray400,
                                    onTap: () {
                                      onTapUsage(context);
                                    }
                                    ),
                                CustomButton(
                                    height: getVerticalSize(38),
                                    width: getHorizontalSize(62),
                                    text: "Trends",
                                    margin: getMargin(left: 16),
                                    variant: ButtonVariant.OutlineBluegray400,
                                    fontStyle: ButtonFontStyle.PoppinsMedium12
                                )
                              ])),
                          Container(
                              margin: getMargin(
                                  left: 1, top: 30, right: 7, bottom: 5),
                              padding: getPadding(
                                  left: 24, top: 25, right: 24, bottom: 25),
                              decoration: AppDecoration.outlineBlack9003f1.copyWith(
                                  borderRadius: BorderRadiusStyle.roundedBorder8),
                            child: AspectRatio(
                              aspectRatio: 16/9,
                              child: DChartBar(
                                data: [
                                  {
                                    'id': 'Bar',
                                    'data': barDataList.map((e){
                                      return {'domain': e.label, 'measure': e.value};
                                    }).toList(),
                                  },
                                ],
                                domainLabelPaddingToAxisLine: 16,
                                axisLineTick: 2,
                                axisLinePointTick: 2,
                                axisLinePointWidth: 10,
                                axisLineColor: Colors.green,
                                measureLabelPaddingToAxisLine: 16,
                                barColor: (barData, index, id) => Colors.green,
                                showBarValue: true,
                              ),
                            ),
                          ),

                        ])))));
  }

  onTapUsage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.activityScreen);
  }

  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}

class BarData {
  final String label;
  final int value;

  BarData({required this.label, required this.value});
}
