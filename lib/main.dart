// @dart=2.9
import 'package:finpro_max_admin/bloc/authentication/bloc.dart';
import 'package:finpro_max_admin/bloc/bloc_delegate.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:finpro_max_admin/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AdminRepository _adminRepository = AdminRepository();

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(adminRepository: _adminRepository)
        ..add(AppStarted()),
      child: Home(adminRepository: _adminRepository)));
}
