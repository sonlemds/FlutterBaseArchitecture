import 'package:flutter/material.dart';
import 'package:mini_app/src/presentation/home/home_bloc.dart';
import 'package:mini_app/src/routes/router.dart';
import 'package:resources/resources.dart';
import 'package:shared/base/base.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomPageState();
}

class HomPageState extends BaseState<HomePage, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.horizontalPadding,
                    vertical: Dimens.verticalPadding),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Home Mini App',
                      style: AppTextStyles.poppinsStyle.heading4,
                    )),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(3, (index) {
                        return ActionChip(
                            label: Text('Item $index'),
                            onPressed: () {
                              ItemRoute().push(context);
                              // bloc.funcSubmit();
                            });
                      }),
                    ))
                  ],
                ))));
  }
}
