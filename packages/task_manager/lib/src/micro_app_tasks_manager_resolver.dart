import 'package:core/core.dart';

import 'event_bus_listener.dart';
import 'injection.dart';
import 'route.dart';

final class MicroAppTasksManagerResolver implements MicroApp {
  @override
  String get microAppName => 'microAppTasksManager';

  @override
  Map<String, WidgetBuilderArgs> get routes => TasksManagerRouter.router;

  @override
  void Function() get injectionsRegister => taskManagerInitialize;

  @override
  void Function() get listenerRegister => tasksCreateEventBusListener;
}
