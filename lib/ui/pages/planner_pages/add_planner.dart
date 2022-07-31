import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finpro_max_admin/bloc/planner/planner_bloc.dart';
import 'package:finpro_max_admin/bloc/planner/planner_state.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max_admin/custom_widgets/modal_popup.dart';
import 'package:finpro_max_admin/custom_widgets/text_radio_field.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/repositories/planner_repository.dart';
import 'package:finpro_max_admin/ui/widgets/onboarding_widgets/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlannerPage extends StatefulWidget {
  final String adminId;
  AddPlannerPage({this.adminId});

  @override
  State<AddPlannerPage> createState() => _AddPlannerPageState();
}

class _AddPlannerPageState extends State<AddPlannerPage>
    with TickerProviderStateMixin {
  final PlannerRepository _plannerRepository = PlannerRepository();
  AnimationController _animationController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _mapUrlController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  File photo;
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
      "Google Maps URL",
      "City",
      "Province",
    ];
    final List txtControllers = [
      _titleController,
      _descController,
      _websiteController,
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
    ];

    return Scaffold(
      backgroundColor: lightGrey1,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Add Planner",
          color: lightGrey1,
        ),
        appBarColor: primary1,
      ),
      body: BlocBuilder<PlannerBloc, PlannerState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      width: size.width * 0.9,
                      height: size.width * 0.6,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(size.width * 0.03),
                      ),
                      child: photo == null
                          ? const UploadPlaceholder(
                              iconData: Icons.account_circle_outlined,
                              text: "Upload Planner Photo",
                            )
                          : Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: size.width * 0.6,
                                  height: size.width * 0.6,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(photo),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.03),
                                  ),
                                ),
                                MiniPill(size: size, text: "Change Photo"),
                              ],
                            ),
                    ),
                    onTap: () async {
                      try {
                        FilePickerResult getPhoto = await FilePicker.platform
                            .pickFiles(type: FileType.image);
                        if (getPhoto != null) {
                          File file = File(getPhoto.files.single.path);
                          setState(() {
                            photo = file;
                          });
                        }
                      } catch (e) {
                        showModalBottomSheet(
                          transitionAnimationController: _animationController,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          builder: (context) {
                            return ModalPopupOneButton(
                              size: size,
                              title: "Storage Permission Denied",
                              image: "assets/images/empty-container.png",
                              description:
                                  "To upload pictures and documents, please enable permission to read external storage.",
                              onPressed: () => AppSettings.openAppSettings(),
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 40),
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
                  const SizedBox(height: 10),
                  BigWideButton(
                      labelText: "Add Planner",
                      btnColor: primary1,
                      textColor: white,
                      onPressedTo: () {}),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
