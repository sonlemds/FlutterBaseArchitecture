import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:resources/resources.dart';
import 'package:shared/base/base.dart';
import 'package:shared/component/input_box.dart';
import 'package:shared/component/primary_button.dart';
import 'package:shared/component/social_network_box.dart';

import 'sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.onSignUp});

  final VoidCallback onSignUp;

  @override
  State<StatefulWidget> createState() => SignInPageState();
}

class SignInPageState extends BaseState<SignInPage, SignInBloc> {
  @override
  void initState() {
    super.initState();
    bloc.streamLoginSuccess.listen((event) {
      context.go('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => bloc,
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(children: [
                  const SizedBox(height: 24),
                  Text(AppLocalization.current.signIn,
                      style: AppTextStyles.poppinsStyle.heading4
                          .copyWith(color: AppColors.blueMarguerite)),
                  const SizedBox(height: 40),
                  InputBox(
                    title: AppLocalization.current.email,
                    placeholder: AppLocalization.current.emailPlaceholder,
                    prefix: Iconsax.sms,
                    onChanged: bloc.funcEmailChanged,
                  ),
                  const SizedBox(height: 8),
                  InputBox(
                      title: AppLocalization.current.password,
                      placeholder: AppLocalization.current.passwordPlaceholder,
                      obscureText: true,
                      prefix: Iconsax.password_check,
                      onChanged: bloc.funcPasswordChanged),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      child: Text(AppLocalization.current.forgotYourPassword,
                          style: AppTextStyles.poppinsStyle.body2
                              .copyWith(color: AppColors.royalBlue)),
                    )
                  ]),
                  const SizedBox(height: 36),
                  StreamBuilder<bool?>(
                      stream: bloc.streamIsButtonLoginEnable,
                      builder: (context, snapshot) {
                        return PrimaryButton(
                          onPressed: () {
                            hideKeyboard();
                            bloc.funcSubmit();
                          },
                          text: AppLocalization.current.signIn,
                          status: snapshot.data ?? false
                              ? PrimaryButtonStatus.def
                              : PrimaryButtonStatus.disabled,
                        );
                      }),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    onPressed: widget.onSignUp,
                    text: AppLocalization.current.signUp,
                    style: PrimaryButtonStyle.outline,
                    status: PrimaryButtonStatus.def,
                  ),
                  const SizedBox(height: 36),
                  const SocialNetworkBox()
                ]))));
  }
}
