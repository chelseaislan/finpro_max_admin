// @dart=2.9
import 'package:finpro_max_admin/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max_admin/bloc/authentication/authentication_state.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:finpro_max_admin/ui/pages/onboarding_pages/complete_profile_page.dart';
import 'package:finpro_max_admin/ui/pages/onboarding_pages/login_page.dart';
import 'package:finpro_max_admin/ui/pages/onboarding_pages/splash.dart';
import 'package:finpro_max_admin/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final AdminRepository _adminRepository;

  Home({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "TTCommons"),
      debugShowCheckedModeBanner: false,
      // the auth bloc covers all the widget tree
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return Splash();
          }
          if (state is Authenticated) {
            return HomeTabs(
              adminId: state.adminId,
              selectedPage: 0,
            );
          }
          if (state is AuthenticatedButNotSet) {
            return CompleteProfilePage(
              adminRepository: _adminRepository,
              adminId: state.adminId,
            );
          }
          if (state is Unauthenticated) {
            return LoginPage(
              adminRepository: _adminRepository,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
