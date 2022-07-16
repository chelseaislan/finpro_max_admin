// @dart=2.9
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finpro_max_admin/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max_admin/bloc/authentication/authentication_event.dart';
import 'package:finpro_max_admin/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:finpro_max_admin/bloc/complete_profile/complete_profile_event.dart';
import 'package:finpro_max_admin/bloc/complete_profile/complete_profile_state.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max_admin/custom_widgets/modal_popup.dart';
import 'package:finpro_max_admin/custom_widgets/my_snackbar.dart';
import 'package:finpro_max_admin/custom_widgets/text_radio_field.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:finpro_max_admin/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// START OF PROFILE SETUP 05 19/41 //
class CompleteProfileForm extends StatefulWidget {
  final AdminRepository _adminRepository;

  CompleteProfileForm({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository;
  // required as usual

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

// total 33 properties
class _CompleteProfileFormState extends State<CompleteProfileForm>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final TextEditingController _nameAdminController = TextEditingController();
  final TextEditingController _jobPositionAdminController =
      TextEditingController();
  File photoAdmin;
  CompleteProfileBloc _completeProfileBloc;

  // check if all the field is filled 6+3+9
  bool get isFilled =>
      _nameAdminController.text.isNotEmpty &&
      photoAdmin != null &&
      _jobPositionAdminController.text.isNotEmpty;

  bool isCompleteButtonEnabled(CompleteProfileState state) {
    return isFilled && !state.isSubmitting;
  }

  // 6+3+9
  _onSubmitted() {
    _completeProfileBloc.add(
      Submitted(
        nameAdmin: _nameAdminController.text,
        photoAdmin: photoAdmin,
        jobPositionAdmin: _jobPositionAdminController.text,
      ),
    );
  }

  @override
  void initState() {
    _completeProfileBloc = BlocProvider.of<CompleteProfileBloc>(context);
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
  }

  @override
  void dispose() {
    _nameAdminController.dispose();
    _jobPositionAdminController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final List txtHeaders = [
      "Full Name",
      "Job Position",
    ];
    final List txtControllers = [
      _nameAdminController,
      _jobPositionAdminController,
    ];

    final List txtIcons = [
      const Icon(Icons.person_add_alt_outlined),
      const Icon(Icons.work_outline_outlined),
    ];

    return BlocListener<CompleteProfileBloc, CompleteProfileState>(
      listener: (context, state) {
        if (state.isFailure) {
          debugPrint("Complete Profile Failed");
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar(
              text: "Failed to complete profile. (404)",
              duration: 3,
              background: primary2,
            ),
          );
        }
        if (state.isSubmitting) {
          debugPrint("Completing Profile");
          ScaffoldMessenger.of(context).showSnackBar(
            myLoadingSnackbar(
              text: "Completing profile...",
              duration: 10,
              background: primaryBlack,
            ),
          );
        }
        if (state.isSuccess) {
          debugPrint("Success!");
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar(
              text: "Profile has been completed!",
              duration: 3,
              background: primaryBlack,
            ),
          );
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(size.width * 0.03),
                      ),
                      child: photoAdmin == null
                          ? const UploadPlaceholder(
                              iconData: Icons.account_circle_outlined,
                              text: "Upload Avatar",
                            )
                          : Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: size.width * 0.6,
                                  height: size.width * 0.6,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(photoAdmin),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        size.width * 0.03),
                                  ),
                                ),
                                MiniPill(size: size, text: "Avatar"),
                              ],
                            ),
                    ),
                    onTap: () async {
                      try {
                        FilePickerResult getAvatar = await FilePicker.platform
                            .pickFiles(type: FileType.image);
                        if (getAvatar != null) {
                          File file = File(getAvatar.files.single.path);
                          setState(() {
                            photoAdmin = file;
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BigWideButton(
                        labelText: "Complete Profile",
                        onPressedTo: isCompleteButtonEnabled(state)
                            ? _onSubmitted
                            : null,
                        textColor: isCompleteButtonEnabled(state)
                            ? secondBlack
                            : white,
                        btnColor: isCompleteButtonEnabled(state)
                            ? Colors.amber
                            : Colors.black54,
                      ),
                      const SizedBox(height: 10),
                      BigWideButton(
                        labelText: "Log Out",
                        onPressedTo: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Confirmation"),
                              content: const Text(
                                  "Are you sure you want to log out?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(LoggedOut());
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation1,
                                                animation2) =>
                                            Home(
                                                adminRepository:
                                                    widget._adminRepository),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },
                        textColor: white,
                        btnColor: primary2,
                      ),
                    ],
                  ),
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

class MiniPill extends StatelessWidget {
  const MiniPill({
    Key key,
    @required this.size,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(size.width * 0.03),
        ),
        child: MiniText(text: "Change $text", color: secondBlack),
      ),
    );
  }
}

class UploadPlaceholder extends StatelessWidget {
  final IconData iconData;
  final String text;
  const UploadPlaceholder({
    Key key,
    @required this.iconData,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, color: secondBlack),
        const SizedBox(height: 5),
        ChatText(text: text, color: secondBlack),
      ],
    );
  }
}

// END OF PROFILE SETUP 05 19/41 //
