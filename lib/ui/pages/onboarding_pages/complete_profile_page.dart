// @dart=2.9
import 'package:finpro_max_admin/bloc/complete_profile/complete_profile_bloc.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:finpro_max_admin/ui/widgets/onboarding_widgets/complete_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfilePage extends StatelessWidget {
  final _adminRepository;
  final adminId;

  CompleteProfilePage(
      {@required AdminRepository adminRepository, String adminId})
      : assert(adminRepository != null && adminId != null),
        _adminRepository = adminRepository,
        adminId = adminId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary1,
      appBar: AppBarSideButton(
        appBarTitle: const Text("Complete your Admin Profile"),
        appBarColor: primary1,
      ),
      body: BlocProvider<CompleteProfileBloc>(
        create: (context) =>
            CompleteProfileBloc(adminRepository: _adminRepository),
        child: CompleteProfileForm(adminRepository: _adminRepository),
      ),
    );
  }
}
