import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared/base/base.dart';
import 'package:shared/extensions/define.dart';

import 'menu_item.dart';

@injectable
class HomeBloc extends BaseBloc {
  // Input
  late void Function(MenuItem menuItem) menuSelect;

  // Output
  late Stream<MenuItem> streamMenuSelected;

  HomeBloc() {
    final menuController = BehaviorSubject<MenuItem>()..disposeBy(disposeBag);

    menuSelect = menuController.add;
    streamMenuSelected = menuController.stream;
  }
}
