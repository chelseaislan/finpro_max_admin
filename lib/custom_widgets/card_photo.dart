// @dart=2.9
// 24/41
import 'package:extended_image/extended_image.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:flutter/material.dart';

class CardPhotoWidget extends StatelessWidget {
  final String photoLink;
  const CardPhotoWidget({this.photoLink});

  @override
  Widget build(BuildContext context) {
    // For caching the images if the internet went out
    return ExtendedImage.network(
      photoLink,
      fit: BoxFit.cover,
      cache: true,
      enableSlideOutPage: true,
      filterQuality: FilterQuality.high,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Center(child: CircularProgressIndicator(color: primary1));
            break;
          case LoadState.completed:
            return null;
            break;
          case LoadState.failed:
            return BigWideButton(
              labelText: "Reload Image",
              onPressedTo: () => state.reLoadImage(),
              textColor: white,
              btnColor: primary1,
            );
            break;
        }
        return Text("");
      },
    );
  }
}
