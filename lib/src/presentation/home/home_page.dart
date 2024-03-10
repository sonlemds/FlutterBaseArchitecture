import 'package:flutter/material.dart';
import 'package:mini_app/mini_app.dart';
import 'package:provider/provider.dart';
import 'package:resources/resources.dart';
import 'package:shared/base/base.dart';

import 'home_bloc.dart';
import 'menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends BaseState<HomePage, HomeBloc> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    bloc.streamMenuSelected.listen((menu) {
      _pageController.jumpToPage(MenuItem.values.indexOf(menu));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => bloc,
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Positioned.fill(
                  bottom: 70,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        bloc.menuSelect(MenuItem.values.elementAt(index)),
                    children: <Widget>[
                      SafeArea(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.horizontalPadding,
                                  vertical: Dimens.verticalPadding),
                              child: Column(
                                children: [
                                  Center(
                                      child: Text(
                                    AppLocalization.current.home,
                                    style: AppTextStyles.poppinsStyle.heading4,
                                  )),
                                  Expanded(
                                      child: GridView.count(
                                    crossAxisCount: 3,
                                    children: List.generate(3, (index) {
                                      return ActionChip(
                                          label: const Text('Mini App'),
                                          onPressed: () {
                                            const MiniAppRoute().push(context);
                                          });
                                    }),
                                  ))
                                ],
                              ))),
                      Center(
                          child: Text('First Page',
                              style: AppTextStyles.poppinsStyle.heading4)),
                      Center(
                          child: Text('Second Page',
                              style: AppTextStyles.poppinsStyle.heading4)),
                    ],
                  )),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SafeArea(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.bigStone.withAlpha(20),
                                  spreadRadius: 0,
                                  blurRadius: 16),
                            ],
                          ),
                          margin: const EdgeInsets.all(24),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            child: StreamBuilder(
                              stream: bloc.streamMenuSelected,
                              initialData: MenuItem.values.first,
                              builder: (BuildContext context,
                                  AsyncSnapshot<MenuItem> snapshot) {
                                return NavigationBar(
                                  height: 69,
                                  selectedIndex: snapshot.data!.index,
                                  onDestinationSelected: (index) =>
                                      bloc.menuSelect(
                                          MenuItem.values.elementAt(index)),
                                  destinations: [
                                    ...MenuItem.values.map((menu) =>
                                        NavigationDestination(
                                            icon: menu.icon,
                                            label: menu.name.toUpperCase()))
                                  ],
                                  labelBehavior:
                                      NavigationDestinationLabelBehavior
                                          .alwaysHide,
                                );
                              },
                            ),
                          ))))
            ],
          )),
    );
  }
}
