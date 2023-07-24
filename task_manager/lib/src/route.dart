import 'package:core/app/micro_app_utils.dart';

import 'tasks/presentation/create_task/create_task.dart';
import 'tasks/presentation/home/home.dart';

final class TasksManagerRouter {
  static const String _tasksRoute = 'microAppTaskManager';
  static const String home = '$_tasksRoute/home';
  static const String create = '$_tasksRoute/create';

  static Map<String, WidgetBuilderArgs> router = {
    home: (context, args) => const HomeTasks(),
    create: (context, args) => const CreateTaskPage(),
  };
}
