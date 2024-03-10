import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:shared/base/base.dart';

@injectable
class HomeBloc extends BaseBloc {
  late VoidCallback funcSubmit;

  HomeBloc() {
    funcSubmit = () {};
  }
}
