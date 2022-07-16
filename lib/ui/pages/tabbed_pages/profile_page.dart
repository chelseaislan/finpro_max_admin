// @dart=2.9
import 'package:finpro_max_admin/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max_admin/bloc/authentication/authentication_event.dart';
import 'package:finpro_max_admin/bloc/profile/bloc.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/settings_button.dart';
import 'package:finpro_max_admin/custom_widgets/profile_overview.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/models/user.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:finpro_max_admin/ui/pages/home.dart';
import 'package:finpro_max_admin/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String adminId;
  ProfilePage({this.adminId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AdminRepository _adminRepository = AdminRepository();
  ProfileBloc _adminBloc;
  Admin _currentAdmin;

  @override
  void initState() {
    _adminBloc = ProfileBloc(adminRepository: _adminRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List titles = [
      "About Application",
      "Log Out",
    ];

    final List icons = [
      Icons.info_outlined,
      Icons.logout_outlined,
    ];

    final List onTap = [
      () {
        showAboutDialog(
          applicationLegalese:
              "“Under his eye,” she says. The right farewell. “Under his eye,” I reply, and she gives a little nod.\n\n(The Handmaid's Tale by Margaret Atwood - 1985)\n\n",
          applicationIcon:
              CircleAvatar(child: Image.asset("assets/images/1024.png")),
          applicationName: "MusliMatch Admin",
          applicationVersion: "0.0.1-NTBC",
          children: [
            HeaderThreeText(
                text: "Rifqi Rachmanda Eryawan", color: secondBlack),
            SmallText(text: "001201700004", color: thirdBlack),
          ],
          context: context,
        );
      },
      () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Are you sure you want to log out?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          Home(adminRepository: _adminRepository),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
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
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBarSideButton(
        appBarTitle: const Text("My Profile"),
        appBarColor: primary1,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  HomeTabs(adminId: widget.adminId, selectedPage: 1),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _adminBloc,
          builder: (context, state) {
            if (state is ProfileInitialState) {
              _adminBloc.add(ProfileLoadedEvent(adminId: widget.adminId));
            }
            if (state is ProfileLoadingState) {
              return Center(child: CircularProgressIndicator(color: primary1));
            }
            if (state is ProfileLoadedState) {
              _currentAdmin = state.currentAdmin;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileOverviewWidget(
                      photo: _currentAdmin.photoAdmin,
                      name: _currentAdmin.nameAdmin,
                      uid: _currentAdmin.uidAdmin,
                      jobPosition:
                          "${_currentAdmin.jobPositionAdmin} at MusliMatch",
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: titles.length,
                      itemBuilder: (context, index) {
                        return SettingsMenuButton(
                          buttonTitle: titles[index],
                          buttonIcon: icons[index],
                          onTapTo: onTap[index],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
