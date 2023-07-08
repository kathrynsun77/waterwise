import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../core/app_export.dart';

class CustomSwitch extends StatelessWidget {
  CustomSwitch({this.alignment, this.margin, this.value, this.onChanged});

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  bool? value;

  Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: _buildSwitchWidget(),
    )
        : _buildSwitchWidget();
  }

  _buildSwitchWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: FlutterSwitch(
        value: value ?? false,
        height: getHorizontalSize(24),
        width: getHorizontalSize(47),
        toggleSize: 20,
        borderRadius: getHorizontalSize(
          12.00,
        ),
        activeColor: ColorConstant.blueGray400,
        activeToggleColor: ColorConstant.whiteA700,
        inactiveColor: ColorConstant.blueGray400,
        inactiveToggleColor: ColorConstant.whiteA700,
        onToggle: (value) {
          onChanged!(value);
        },
      ),
    );
  }
}
