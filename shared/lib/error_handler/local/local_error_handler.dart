import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../error_handler.dart';
import 'local_error_listener.dart';

class LocalErrorHandler
    extends ErrorHandler<LocalException, LocalErrorListener> {
  @override
  void proceed(BuildContext context, LocalException exception,
      LocalErrorListener listener) {}
}
