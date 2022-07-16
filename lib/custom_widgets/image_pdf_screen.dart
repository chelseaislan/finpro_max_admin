import 'package:finpro_max_admin/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max_admin/custom_widgets/card_photo.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key key, this.photoLink}) : super(key: key);
  final String photoLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const AppBarSideButton(
        appBarTitle: Text("Image Detail"),
        appBarColor: Colors.black,
      ),
      body: PinchZoom(
        maxScale: 3.5,
        resetDuration: const Duration(milliseconds: 200),
        child: Center(
          child: CardPhotoWidget(photoLink: photoLink),
        ),
      ),
    );
  }
}
