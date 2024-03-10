import 'package:app_name/src/presentation/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:resources/resources.dart';
import 'package:shared/base/base.dart';
import 'package:shared/component/input_box.dart';
import 'package:shared/component/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends BaseState<SignUpPage, AuthBloc> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(children: [
              const SizedBox(height: 24),
              Text(AppLocalization.current.signUp,
                  style: AppTextStyles.poppinsStyle.heading4
                      .copyWith(color: AppColors.blueMarguerite)),
              const SizedBox(height: 40),
              InputBox(
                  title: AppLocalization.current.email,
                  placeholder: AppLocalization.current.emailPlaceholder,
                  prefix: Iconsax.sms),
              const SizedBox(height: 8),
              InputBox(
                  title: AppLocalization.current.password,
                  placeholder: AppLocalization.current.passwordPlaceholder,
                  obscureText: true,
                  prefix: Iconsax.password_check),
              const SizedBox(height: 8),
              InputBox(
                  title: AppLocalization.current.confirmPassword,
                  placeholder:
                      AppLocalization.current.confirmPasswordPlaceholder,
                  obscureText: true,
                  prefix: Iconsax.password_check),
              const SizedBox(height: 36),
              PrimaryButton(
                onPressed: () {},
                text: AppLocalization.current.submit,
                status: PrimaryButtonStatus.disabled,
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                onPressed: widget.onSignIn,
                text: AppLocalization.current.signIn,
                style: PrimaryButtonStyle.outline,
                status: PrimaryButtonStatus.def,
              )
            ])));
  }
}
