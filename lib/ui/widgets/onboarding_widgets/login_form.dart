// @dart=2.9
import 'package:finpro_max_admin/bloc/authentication/authentication_bloc.dart';
import 'package:finpro_max_admin/bloc/authentication/authentication_event.dart';
import 'package:finpro_max_admin/bloc/login/bloc.dart';
import 'package:finpro_max_admin/custom_widgets/my_snackbar.dart';
import 'package:finpro_max_admin/models/colors.dart';
import 'package:finpro_max_admin/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max_admin/custom_widgets/text_radio_field.dart';
import 'package:finpro_max_admin/custom_widgets/text_styles.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final AdminRepository _adminRepository;

  LoginForm({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  AdminRepository get _adminRepository => widget._adminRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _emailController.text.contains("@mm.id") &&
      _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar(
              text: "Login failed, please try again. (404)",
              duration: 3,
              background: primary2,
            ),
          );
        }

        if (state.isSubmitting) {
          debugPrint("isSubmitting");
          ScaffoldMessenger.of(context).showSnackBar(
            myLoadingSnackbar(
              text: "Logging in...",
              duration: 3,
              background: primaryBlack,
            ),
          );
        }

        if (state.isSuccess) {
          debugPrint("Success!");
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackbar(
              text: "Login successful!",
              duration: 3,
              background: primaryBlack,
            ),
          );
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo_login.png",
                      width: size.width * 0.7,
                      height: size.width * 0.7,
                    ),
                  ),
                  const SizedBox(height: 30),
                  HeaderTwoText(
                    text: "Welcome back!",
                    color: white,
                    align: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  DescText(
                    text:
                        "“You don't know what you're capable of until you have to do it.” - June Osborne",
                    color: white,
                    align: TextAlign.left,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
                    child: Divider(
                      color: white,
                      height: 1,
                      thickness: 0.2,
                    ),
                  ),
                  LoginTextFieldWidget(
                    textAction: TextInputAction.next,
                    text: "Email Address",
                    controller: _emailController,
                    color: white,
                    obscureText: false,
                    prefixIcon: Icon(Icons.email_outlined),
                    textInputType: TextInputType.emailAddress,
                    textValidator: (_) {
                      return !state.isEmailValid
                          ? "Email must end with '@mm.id'."
                          : null;
                    },
                  ),
                  LoginTextFieldWidget(
                    textAction: TextInputAction.done,
                    text: "Password",
                    controller: _passwordController,
                    color: white,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.vpn_key_outlined),
                    textInputType: TextInputType.visiblePassword,
                    textValidator: (_) {
                      return !state.isPasswordValid ? "Invalid Password" : null;
                    },
                  ),
                  Divider(
                    color: white,
                    height: 1,
                    thickness: 0.2,
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      BigWideButton(
                        labelText: "Log In",
                        onPressedTo: isLoginButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                        textColor:
                            isLoginButtonEnabled(state) ? secondBlack : white,
                        btnColor: isLoginButtonEnabled(state)
                            ? Colors.amber
                            : Colors.black54,
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
