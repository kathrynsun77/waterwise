import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:WaterWise/core/app_export.dart';
import 'package:WaterWise/widget/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import '../../app_bar/appbar_image.dart';
import '../../app_bar/appbar_title.dart';
import '../../app_bar/custom_app_bar.dart';
import '../../API.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}
class _ActivityScreenState extends State<ActivityScreen> {

  bool isButtonPressed = false;
  Map user = {};
  List allBill = [];
  // String API= "http://172.28.200.128/water_wise/";
  // String API= "http://10.33.133.168/water_wise/";
  // String API= "http://192.168.1.12/water_wise/";

  List pipeData = [];
  String? pdfFlePath;

  getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? userString = pref.getString("user");
    if (userString != null) {
      user = jsonDecode(userString);
      fetchData();
      setState(() {});
    }
  }

  void requestTech(int id) async {
    var url = API+'request_tech.php';
    var response = await http.post(Uri.parse(url), body: {
      'cust-id': user['customer_id'],
      'pipe': id.toString(),
    });
    if (response.statusCode == 200) {
      print(response.body);
      // Disable the button after it has been pressed once
      setState(() {
        isButtonPressed = true;
      });
    } else {
      print('failed bye');
      // Handle the HTTP request failure here
    }
  }

  bool _isRefreshing = false;
  fetchData() async {
    final response = await http.post(
      Uri.parse(API+'bill_detail.php'),
      body: {
        'id': user['id']
      },
    );

    if (response.statusCode == 200) {
      // Decode the JSON response
      print(response.body);
      allBill = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      final encodedList = jsonEncode(allBill);
      await prefs.setString('pipeData', encodedList);
      setState(() {
      });
    } else {
      throw Exception('Failed to fetch data');
    }
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
    final tableHeaders = ['Pipe Name', 'Meter Value', 'Leak Status', 'Usage Status'];
    final tableRows = pipeData.map((e) {
      final pipeName = e['pipe_name'].toString();
      final meterValue = e['meter_value'].toString();
      final leakStatus = int.parse(e['leak_status']) > 1 ? "Pipe Leaking" : "No Leak";
      final usageStatus = int.parse(e['meter_value']) > 100 ? "High Usage" : "Low Usage";
      return [pipeName, meterValue, leakStatus, usageStatus];
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

  Future<void> _refreshData() async {
    fetchData();
    // Simulating a delay of 2 seconds for demonstration purposes
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // Update your data variables here

      _isRefreshing = false;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalMeter = 0;
    for (var item in allBill) {
      totalMeter += int.parse(item['meter_value']);
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            resizeToAvoidBottomInset: false,
            body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
                width: double.maxFinite,
                child: Column(
                    children: [
                      Padding(
                          padding: getPadding(left: 30, top: 16, right: 18),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomImageView(
                                    svgPath:
                                    ImageConstant.imgArrowleftIndigo800,
                                    height: getVerticalSize(16),
                                    width: getHorizontalSize(9),
                                    margin: getMargin(top: 14, bottom: 2),
                                    onTap: () {
                                      onTapImgArrowleft(context);
                                    }),
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
                              ])),
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              margin: getMargin(top: 13),
                              padding: getPadding(left: 30, right: 30),
                              decoration: AppDecoration.fillGray50,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: getPadding(top: 34),
                                        child: Text("Water Usage",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtPoppinsSemiBold18Bluegray700
                                                .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(
                                                    1.0)))),
                                    Padding(
                                        padding: getPadding(top: 9),
                                        child: Row(children: [
                                          CustomButton(
                                              height: getVerticalSize(38),
                                              width: getHorizontalSize(59),
                                              text: "Usage",
                                              variant: ButtonVariant
                                                  .OutlineBluegray400,
                                              fontStyle: ButtonFontStyle
                                                  .PoppinsMedium12),
                                          CustomButton(
                                              height: getVerticalSize(38),
                                              width: getHorizontalSize(62),
                                              text: "Trends",
                                              margin: getMargin(left: 16),
                                              variant:
                                              ButtonVariant.OutlineGray300,
                                              fontStyle: ButtonFontStyle
                                                  .PoppinsMedium12Gray400,
                                              onTap: () {
                                                onTapTrends(context);
                                              })
                                        ])),
                                    Padding(
                                        padding: getPadding(top: 11),
                                        child: Text("Water Meter : "+totalMeter.toStringAsFixed(4),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtPoppinsRegular12Bluegray900
                                                .copyWith(
                                                letterSpacing:
                                                getHorizontalSize(
                                                    1.0)))),

                                    ListView.builder(
                                    itemCount: allBill.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                    Map item = allBill[index];
                                    return Container(
                                    width: double.maxFinite,
                                        child: Container(
                                          margin: getMargin(top: 13),
                                          padding: getPadding(all: 16),
                                          decoration: AppDecoration.white
                                              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible: int.parse(item['leak_status']) == 2,
                                                child: CustomButton(
                                                  height: getVerticalSize(32),
                                                  width: getHorizontalSize(100),
                                                  text: isButtonPressed || int.parse(item['pending']) > 0 ? "Help is on the way" : "Request Technician",
                                                  onTap: isButtonPressed
                                                      ? null
                                                      : () {
                                                    setState(() {
                                                      isButtonPressed = true;
                                                    });
                                                    // onTapRequestTech(context);
                                                    print('Button tapped'); // Test statement
                                                    requestTech(int.parse(item['pipe_id']));
                                                  },
                                                  variant: ButtonVariant.OutlineRed400,
                                                  fontStyle: ButtonFontStyle.PoppinsMedium8Red400,
                                                ),
                                              ),


                                              Text(
                                                item['pipe_name'],
                                                maxLines: null,
                                                textAlign: TextAlign.left,
                                                style: (int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2)
                                                    ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                  letterSpacing: getHorizontalSize(1.0),
                                                )
                                                    : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                  letterSpacing: getHorizontalSize(1.0),
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(top: 12),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '${int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2 ? "High" : "Low"} Usage',
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.left,
                                                          style: (int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2)
                                                              ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                            letterSpacing: getHorizontalSize(1.0),
                                                          )
                                                              : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                            letterSpacing: getHorizontalSize(1.0),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(top: 2),
                                                          child: Text(
                                                            '${int.parse(item['leak_status']) == 2 ? "Pipe Leaking" : "No Leak"}',
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.left,
                                                            style: (int.parse(item['meter_value']) >= 100 || int.parse(item['leak_status']) == 2)
                                                                ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                              letterSpacing: getHorizontalSize(1.0),
                                                            )
                                                                : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                              letterSpacing: getHorizontalSize(1.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: getPadding(top: 9, bottom: 11),
                                                      child: Text(
                                                        item['meter_value'],
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,
                                                        style: (int.parse(item['meter_value']) >= 100 || item['leak_status'] == 2)
                                                            ? AppStyle.txtPoppinsRegular12RedA400.copyWith(
                                                          letterSpacing: getHorizontalSize(1.0),
                                                        )
                                                            : AppStyle.txtPoppinsRegular12Gray800.copyWith(
                                                          letterSpacing: getHorizontalSize(1.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    );})])))
                    ]))))));
  }

  onTapImgArrowleft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bottomBarMenu);
  }

  onTapTrends(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.activityTrendsScreen);
  }
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
