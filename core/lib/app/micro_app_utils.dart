import 'package:flutter/widgets.dart';

import 'arguments.dart';

typedef WidgetBuilderArgs = Widget Function(
  BuildContext context,
  Arguments? args,
);
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
