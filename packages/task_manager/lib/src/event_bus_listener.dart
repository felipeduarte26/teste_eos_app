import 'package:commons/commons.dart';
import 'package:core/core.dart';

import 'route.dart';

void tasksCreateEventBusListener() {
  EventBusController().on<EventBusStates>().listen(
    (event) {
      if (event is ShowTasksManagerState) {
        navigatorKey.currentState?.pushNamed(TasksManagerRouter.home);
      }
    },
  );
}
