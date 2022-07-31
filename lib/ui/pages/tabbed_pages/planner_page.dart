import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max_admin/bloc/planner/bloc.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max_admin/custom_widgets/divider.dart';
import 'package:finpro_max_admin/custom_widgets/empty_content.dart';
import 'package:finpro_max_admin/custom_widgets/text_radio_field.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/models/planner_detail.dart';
import 'package:finpro_max_admin/repositories/planner_repository.dart';
import 'package:finpro_max_admin/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PlannerPage extends StatefulWidget {
  final String adminId;
  const PlannerPage({this.adminId});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage>
    with TickerProviderStateMixin {
  PlannerRepository _plannerRepository = PlannerRepository();
  AnimationController _animationController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _mapUrlController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  PlannerBloc _plannerBloc;

  @override
  void initState() {
    _plannerBloc = PlannerBloc(plannerRepository: _plannerRepository);
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _websiteController.dispose();
    _phoneController.dispose();
    _mapUrlController.dispose();
    _provinceController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List txtHeaders = [
      "Planner Name",
      "Planner Description",
      "Planner Website",
      "Planner WhatsApp",
      "Google Maps URL",
      "City",
      "Province",
    ];
    final List txtControllers = [
      _titleController,
      _descController,
      _websiteController,
      _phoneController,
      _mapUrlController,
      _locationController,
      _provinceController,
    ];

    final List txtIcons = [
      const Icon(Icons.text_fields_outlined),
      const Icon(Icons.text_fields_outlined),
      const Icon(Icons.text_fields_outlined),
      const Icon(Icons.text_fields_outlined),
      const Icon(Icons.text_fields_outlined),
      const Icon(Icons.text_fields_outlined),
      const Icon(Icons.text_fields_outlined),
    ];

    return Scaffold(
      backgroundColor: lightGrey1,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Planners",
          color: lightGrey1,
        ),
        appBarColor: primary1,
      ),
      body: BlocBuilder<PlannerBloc, PlannerState>(
        bloc: _plannerBloc,
        builder: (BuildContext context, PlannerState state) {
          if (state is PlannerInitialState) {
            _plannerBloc.add(PlannerStreamEvent());
          }
          if (state is PlannerLoadingState) {
            return Center(child: CircularProgressIndicator(color: white));
          }
          if (state is PlannerLoadedState) {
            Stream<QuerySnapshot> plannerStream = state.plannerStream;
            return StreamBuilder<QuerySnapshot>(
              stream: plannerStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                if (snapshot.data.documents.isNotEmpty) {
                  final planners = snapshot.data.documents;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(color: primary1));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.builder(
                        itemCount: planners.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  maxRadius: 35,
                                  child: Text(
                                      planners[index].data['title']
                                          [0], // ambil karakter pertama text
                                      style: const TextStyle(fontSize: 24)),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: HeaderThreeText(
                                    text: planners[index].data['title'],
                                    color: primaryBlack,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ChatText(
                                        text: planners[index].data['desc'],
                                        color: thirdBlack,
                                      ),
                                      const SizedBox(height: 5),
                                      SmallText(
                                        text:
                                            "${planners[index].data['location']}, ${planners[index].data['province']}",
                                        color: thirdBlack,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                transitionAnimationController:
                                    _animationController,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          HeaderThreeText(
                                            text: planners[index].data['title'],
                                            color: primaryBlack,
                                          ),
                                          const SizedBox(height: 10),
                                          SmallText(
                                            text: "Planner Description",
                                            color: thirdBlack,
                                          ),
                                          DescText(
                                            text: planners[index].data['desc'],
                                            color: primaryBlack,
                                          ),
                                          const SizedBox(height: 10),
                                          SmallText(
                                            text: "Location",
                                            color: thirdBlack,
                                          ),
                                          DescText(
                                            text:
                                                "${planners[index].data['location']}, ${planners[index].data['province']}",
                                            color: primaryBlack,
                                          ),
                                          const SizedBox(height: 20),
                                          BigWideButton(
                                            labelText: "Visit Website",
                                            onPressedTo: () async {
                                              var url =
                                                  "https://${planners[index].data['website']}";
                                              if (await canLaunch(url) !=
                                                  null) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch website!';
                                              }
                                            },
                                            textColor: white,
                                            btnColor: primary1,
                                          ),
                                          const SizedBox(height: 10),
                                          BigWideButton(
                                            labelText: "Chat via WhatsApp",
                                            onPressedTo: () async {
                                              var url =
                                                  "https://wa.me/${planners[index].data['phone']}";
                                              if (await canLaunch(url) !=
                                                  null) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch website!';
                                              }
                                            },
                                            textColor: white,
                                            btnColor: primary1,
                                          ),
                                          const SizedBox(height: 10),
                                          BigWideButton(
                                            labelText: "View Directions",
                                            onPressedTo: () async {
                                              var url =
                                                  "https://www.google.com/maps/search/${planners[index].data['title']}/";
                                              if (await canLaunch(url) !=
                                                  null) {
                                                await launch(url);
                                              } else {
                                                throw 'Could not launch website!';
                                              }
                                            },
                                            textColor: white,
                                            btnColor: primary1,
                                          ),
                                          const SizedBox(height: 10),
                                          BigWideButton(
                                            labelText: "Delete Entry",
                                            onPressedTo: () async {
                                              await Firestore.instance
                                                  .runTransaction((Transaction
                                                      myTransaction) async {
                                                await myTransaction.delete(
                                                    planners[index].reference);
                                              });
                                              Navigator.pop(context);
                                            },
                                            textColor: white,
                                            btnColor: primary2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return EmptyContent(
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
                              HomeTabs(
                                  adminId: widget.adminId, selectedPage: 2),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                        ((route) => false),
                      );
                    },
                  );
                }
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary5,
        tooltip: "Add Planner",
        child: Icon(Icons.add_outlined, color: white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          showModalBottomSheet(
            transitionAnimationController: _animationController,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.95,
                child: Container(
                  color: primary1,
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50,
                          height: 10,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: txtHeaders.length,
                          itemBuilder: (context, index) {
                            return LoginTextFieldWidget(
                              text: txtHeaders[index],
                              controller: txtControllers[index],
                              color: white,
                              obscureText: false,
                              prefixIcon: txtIcons[index],
                              textInputType: TextInputType.name,
                              textAction: TextInputAction.next,
                            );
                          },
                        ),
                        PaddingDivider(color: white),
                        BigWideButton(
                          labelText: "Add Planner",
                          textColor: primaryBlack,
                          btnColor: gold,
                          onPressedTo: () {
                            _plannerBloc.add(
                              UploadPlannerEvent(
                                plannerDetail: PlannerDetail(
                                  adminId: widget.adminId,
                                  plannerTitle: _titleController.text,
                                  plannerDesc: _descController.text,
                                  plannerWebsite: _websiteController.text,
                                  plannerPhone: _phoneController.text,
                                  plannerMapUrl: _mapUrlController.text,
                                  plannerLocation: _locationController.text,
                                  province: _provinceController.text,
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     pageBuilder: (context, animation1, animation2) =>
          //         AddPlannerPage(adminId: widget.adminId),
          //     transitionDuration: Duration.zero,
          //     reverseTransitionDuration: Duration.zero,
          //   ),
          // );
        },
      ),
    );
  }
}
