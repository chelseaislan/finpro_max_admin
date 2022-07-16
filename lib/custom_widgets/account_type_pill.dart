import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:flutter/material.dart';

class AccountTypePill extends StatelessWidget {
  const AccountTypePill({@required this.pillStatus, @required this.pillColor});

  final String pillStatus;
  final Color pillColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 9, 10, 6),
        decoration: BoxDecoration(
          color: pillColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SmallText(
          text: pillStatus,
          color: secondBlack,
          align: TextAlign.center,
        ),
      ),
    );
  }
}
