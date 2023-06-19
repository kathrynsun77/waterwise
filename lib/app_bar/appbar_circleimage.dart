import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../core/utils/size_utils.dart';
import '../theme/app_decoration.dart';
import '../widget/custom_image_view.dart';

class AppbarCircleimage extends StatelessWidget {
  final String? imagePath;
  final EdgeInsetsGeometry? margin;
  final Function? onTap;

  AppbarCircleimage({
    this.imagePath,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadiusStyle.circleBorder25,
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: FutureBuilder<Widget>(
          future: _getImageWidget(imagePath),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return snapshot.data!;
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<Widget> _getImageWidget(String? imagePath) async {
    if (imagePath == null) {
      return SizedBox(); // Return an empty container if imagePath is null
    }
    final file = File(imagePath);
    final imageBytes = await file.readAsBytes();
    final imageWidget = Image.memory(
      imageBytes,
      height: getSize(50),
      width: getSize(50),
      fit: BoxFit.contain,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Icon(Icons.error); // Show an error icon if image loading fails
      },
    );
    return imageWidget;
  }
}
