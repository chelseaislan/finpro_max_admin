// @dart=2.9
import 'package:finpro_max_admin/models/colors.dart';
import 'package:flutter/material.dart';

class PaddingDivider extends StatelessWidget {
  final Color color;

  const PaddingDivider({this.color});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: primary1,
      padding: EdgeInsets.only(
        bottom: size.width * 0.07,
      ),
      child: Divider(
        color: color,
        height: 1,
        thickness: 0.2,
      ),
    );
  }
}
