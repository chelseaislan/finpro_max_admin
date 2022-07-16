import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:flutter/material.dart';

class SettingsMenuButton extends StatelessWidget {
  const SettingsMenuButton({
    @required this.buttonTitle,
    @required this.buttonIcon,
    @required this.onTapTo,
  });

  final String buttonTitle;
  final IconData buttonIcon;
  final Function() onTapTo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Icon(
                    buttonIcon,
                    size: 30,
                    color: primary1,
                  ),
                  const SizedBox(width: 15),
                  DescText(
                    text: buttonTitle,
                    color: secondBlack,
                    align: TextAlign.left,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black12,
            ),
          ],
        ),
      ),
      onTap: onTapTo,
    );
  }
}
