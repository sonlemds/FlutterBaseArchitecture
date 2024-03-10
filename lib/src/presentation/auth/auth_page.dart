import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/base/base.dart';

import 'auth_bloc.dart';
import 'sign_in/sign_in_page.dart';
import 'sign_up/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<StatefulWidget> createState() => AuthPageState();
}

class AuthPageState extends BaseState<AuthPage, AuthBloc>
    with TickerProviderStateMixin {
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.bgAuth.jpegImgPath),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: [
            Column(children: [
              const Expanded(child: SizedBox()),
              Container(color: AppColors.white, height: 100)
            ]),
            SafeArea(
                child: Column(children: [
              const SizedBox(height: 48),
              Text(AppLocalization.current.appTitle,
                  style: AppTextStyles.poppinsStyle.heading1
                      .copyWith(color: AppColors.whiteLilac)),
              const SizedBox(height: 48),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(36),
                              topRight: Radius.circular(36))),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                              decoration: const BoxDecoration(
                                  color: AppColors.eastSide,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              width: 72,
                              height: 2),
                          Expanded(
                              child: PageView(
                            controller: _pageViewController,
                            children: <Widget>[
                              SignInPage(
                                  onSignUp: () => _updateCurrentPageIndex(1)),
                              SignUpPage(
                                  onSignIn: () => _updateCurrentPageIndex(0)),
                            ],
                          ))
                        ],
                      ))),
            ]))
          ]),
        ));
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }
}
