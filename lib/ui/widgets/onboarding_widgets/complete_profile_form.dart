// @dart=2.9
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finpro_max_admin/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max_admin/bloc/authentication/authentication_event.dart';
import 'package:finpro_max_admin/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:finpro_max_admin/bloc/complete_profile/complete_profile_event.dart';
import 'package:finpro_max_admin/bloc/complete_profile/complete_profile_state.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max_admin/custom_widgets/text_radio_field.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
class _CompleteProfileFormState extends State<CompleteProfileForm> {
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
    // implement initState
    _completeProfileBloc = BlocProvider.of<CompleteProfileBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _nameAdminController.dispose();
    _jobPositionAdminController.dispose();
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
          print("Complete Admin Profile Failed");
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Error completing your profile."),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          print("Completing Profile");
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 35),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderFourText(text: "Completing profile...", color: white),
                    CircularProgressIndicator(color: white),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          print("Success!");
          Fluttertoast.showToast(msg: "Profile has been completed!");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<CompleteProfileBloc, CompleteProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      // File getAvatar =
                      //     await FilePicker.getFile(type: FileType.image);
                      // if (getAvatar != null) {
                      //   setState(() {
                      //     photoAdmin = getAvatar;
                      //   });
                      // }
                      FilePickerResult getAvatar = await FilePicker.platform
                          .pickFiles(type: FileType.image);
                      if (getAvatar != null) {
                        File file = File(getAvatar.files.single.path);
                        setState(() {
                          photoAdmin = file;
                        });
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
                  SizedBox(
                    width: size.width,
                    child: BigWideButton(
                      labelText: "Complete Profile",
                      onPressedTo:
                          isCompleteButtonEnabled(state) ? _onSubmitted : null,
                      textColor:
                          isCompleteButtonEnabled(state) ? secondBlack : white,
                      btnColor: isCompleteButtonEnabled(state)
                          ? Colors.amber
                          : Colors.black54,
                    ),
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
