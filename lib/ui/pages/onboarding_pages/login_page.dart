// @dart=2.9
import 'package:finpro_max_admin/bloc/login/bloc.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:finpro_max_admin/ui/widgets/onboarding_widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final AdminRepository _adminRepository;

  LoginPage({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary4, primary5],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const AppBarSideButton(
          appBarTitle: Text(""),
          appBarColor: Colors.transparent,
        ),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            adminRepository: _adminRepository,
          ),
          child: LoginForm(
            adminRepository: _adminRepository,
          ),
        ),
      ),
    );
  }
}
