import 'dart:convert';
import 'dart:io';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:WaterWise/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_bar/appbar_image.dart';
import '../../app_bar/appbar_title.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class ActivityTrendsScreen extends StatefulWidget {
  const ActivityTrendsScreen({Key? key}) : super(key: key);

  @override
  State<ActivityTrendsScreen> createState() => _ActivityTrendsScreenState();
}

class _ActivityTrendsScreenState extends State<ActivityTrendsScreen> {
  String API = "http://172.28.200.128/water_wise/";
  Map user = {};
  List<BarData> barDataList = [];
  List pipeData = [];
  String? pdfFlePath;

  void getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      fetchData();
      generatePdf();
      setState(() {});
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  generatePdf() async {
    final response = await http.post(Uri.parse(API + 'pipe_data.php'), body: {
      'cust-id': user['customer_id'],
    });
    print('fetched');
    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      // List list = jsonDecode(response.body);
      pipeData = json.decode(response.body);
      setState(() {});
    } else {
      throw Exception('Failed to fetch data');
    }

    final pdf = pw.Document();
    // Create a table
    final tableHeaders = ['Pipe Name', 'Meter Value', 'Leak Status'];
    final tableRows = pipeData.map((e) {
      final pipeName = e['pipe_name'].toString();
      final meterValue = e['meter_value'].toString();
      final leakStatus = e['leak_status'].toString();
      return [pipeName, meterValue, leakStatus];
    }).toList();


// Add table to the PDF
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.TableHelper.fromTextArray(
            context: context,
            headers: tableHeaders,
            data: tableRows,
            cellAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(),
            headerDecoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
              color: PdfColors.grey300,
            ),
            rowDecoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  color: PdfColors.grey,
                  width: 0.5,
                ),
              ),
            ),
            headerHeight: 25,
            cellHeight: 40,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.center,
              2: pw.Alignment.center,
            },
          ),
        ],
      ),
    );


    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/data.pdf");
    await file.writeAsBytes(await pdf.save());
    pdfFlePath = file.path;
    setState(() {});
    return pdfFlePath;
  }

  fetchData() async {
    final response = await http.post(
      Uri.parse(API + 'water_trends.php'),
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
                  margin: getMargin(top: 14, bottom: 2),
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
              text: "Generate Report",
              margin: getMargin(left: 18, top: 12, right: 18, bottom: 12),
              variant: ButtonVariant.OutlineBluegray40001,
              fontStyle: ButtonFontStyle.PoppinsMedium8,
              onTap: () {
                generatePdf();
                if (pdfFlePath != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PdfViewerScreen(pdfFilePath: pdfFlePath!),
                    ),
                  );
                }
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

class PdfViewerScreen extends StatelessWidget {
  final String pdfFilePath;

  const PdfViewerScreen({required this.pdfFilePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: getVerticalSize(50),
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
                  Navigator.maybePop(context); // Use Navigator.maybePop to handle back navigation
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
        title: Padding(
          padding: getPadding(left: 30, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppbarTitle(
                text: "Water Usage Report",
              ),
            ],
          ),
        ),
      ),
      body: PdfView(path: pdfFilePath),
    );
  }
}
