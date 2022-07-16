import 'package:finpro_max_admin/custom_widgets/card_photo.dart';
import 'package:finpro_max_admin/custom_widgets/image_pdf_screen.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileOverviewWidget extends StatelessWidget {
  const ProfileOverviewWidget({
    @required this.photo,
    @required this.name,
    @required this.jobPosition,
    @required this.uid,
  });

  final String photo;
  final String name;
  final String jobPosition;
  final String uid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary1, primary5],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            size.width * 0.07,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        DetailScreen(photoLink: photo),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.16,
                backgroundColor: white,
                child: ClipOval(
                  child: SizedBox(
                    height: size.height * 0.135,
                    width: size.height * 0.135,
                    child: CardPhotoWidget(photoLink: photo),
                  ),
                ),
              ),
            ),
          ),
          HeaderTwoText(
            text: name,
            color: white,
            overflow: TextOverflow.ellipsis,
          ),
          DescText(
            text: jobPosition,
            color: white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: MiniText(
              text: "admin-id: $uid",
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}
