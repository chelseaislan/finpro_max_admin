import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max_admin/custom_widgets/account_type_pill.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max_admin/custom_widgets/card_photo.dart';
import 'package:finpro_max_admin/custom_widgets/empty_content.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  final String adminId;
  HomePage({this.adminId});

  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarSideButton(
        appBarTitle: Image.asset(
          "assets/images/header_logo.png",
          width: size.width * 0.4,
        ),
        appBarColor: Colors.grey[50],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  HomeTabs(adminId: adminId, selectedPage: 0),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
            ((route) => false),
          );
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('users')
              .where('accountType', isEqualTo: 'verifying document')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(color: primary1));
            }
            if (snapshot.data.documents.isNotEmpty) {
              final user = snapshot.data.documents;
              // Fluttertoast.showToast(msg: adminId);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context, index) {
                    Timestamp timestamp = user[index].data['dob'];
                    String date =
                        "${timestamp.toDate().day}/${timestamp.toDate().month}/${timestamp.toDate().year}";
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                  height: size.height * 0.85,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 5),
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                color: white,
                                                width: size.width * 0.9,
                                                height: size.width * 0.6,
                                                child: CardPhotoWidget(
                                                  photoLink: user[index]
                                                      .data['photoKtp'],
                                                ),
                                              ),
                                            ),
                                            AccountTypePill(
                                              pillStatus: "Submitted KTP",
                                              pillColor: white,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                color: white,
                                                width: size.width * 0.9,
                                                height: size.width * 0.6,
                                                child: CardPhotoWidget(
                                                  photoLink: user[index]
                                                      .data['photoOtherID'],
                                                ),
                                              ),
                                            ),
                                            AccountTypePill(
                                              pillStatus: "Additional Document",
                                              pillColor: white,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 25),
                                        HeaderThreeText(
                                          text:
                                              "Verify ${user[index].data['nickname']}?",
                                          color: secondBlack,
                                        ),
                                        const SizedBox(height: 5),
                                        InkWell(
                                          onTap: () async {
                                            await db
                                                .collection('users')
                                                .document(
                                                    user[index].data['uid'])
                                                .updateData({
                                              'accountType': "verified",
                                              'verifiedBy': adminId,
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.check_outlined,
                                              color: appBarColor,
                                            ),
                                            title: HeaderThreeText(
                                              text: "Verify",
                                              color: appBarColor,
                                            ),
                                            subtitle: DescText(
                                              text:
                                                  "${user[index].data['nickname']} will be verified",
                                              color: secondBlack,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await db
                                                .collection('users')
                                                .document(
                                                    user[index].data['uid'])
                                                .updateData({
                                              'accountType': "invalid-ktp"
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.clear_outlined,
                                              color: primary2,
                                            ),
                                            title: HeaderThreeText(
                                              text: "Invalid KTP",
                                              color: primary2,
                                            ),
                                            subtitle: DescText(
                                              text:
                                                  "${user[index].data['nickname']} must re-upload KTP",
                                              color: secondBlack,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await db
                                                .collection('users')
                                                .document(
                                                    user[index].data['uid'])
                                                .updateData({
                                              'accountType': "invalid-otherid"
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.clear_outlined,
                                              color: primary2,
                                            ),
                                            title: HeaderThreeText(
                                              text:
                                                  "Invalid Additional Document",
                                              color: primary2,
                                            ),
                                            subtitle: DescText(
                                              text:
                                                  "${user[index].data['nickname']} must re-upload document",
                                              color: secondBlack,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            color: primary5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 8),
                                  leading: ClipOval(
                                    child: SizedBox(
                                      height: size.height * 0.1,
                                      width: size.width * 0.14,
                                      child: CardPhotoWidget(
                                          photoLink:
                                              user[index].data['photoUrl']),
                                    ),
                                  ),
                                  title: HeaderFourText(
                                    text:
                                        "${user[index].data['name']}, ${user[index].data['age']}",
                                    color: white,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SmallText(
                                        text: "Date of Birth: $date",
                                        color: white,
                                      ),
                                      SmallText(
                                        text:
                                            "${user[index].data['jobPosition']} at ${user[index].data['currentJob']}",
                                        color: white,
                                      ),
                                      SmallText(
                                        text:
                                            "${user[index].data['location']}, ${user[index].data['province']}",
                                        color: white,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: primary1,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                    ),
                                  ),
                                  child: HeaderFourText(
                                    text: "Decide",
                                    color: white,
                                    align: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    );
                  },
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    EmptyContent(
                      size: size,
                      asset: "assets/images/discover-tab.png",
                      header: "Uh-oh...",
                      description:
                          "Looks like there is no one around. Please come back later.",
                      buttonText: "Refresh",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                HomeTabs(adminId: adminId, selectedPage: 0),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                          ((route) => false),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
