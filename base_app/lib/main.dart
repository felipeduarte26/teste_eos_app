import 'package:commons/commons.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/task_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('tasks_box');
  runApp(MyApp());
}

final class MyApp extends StatelessWidget with BaseApp {
  MyApp({super.key}) {
    Intl.defaultLocale = 'pt_BR';
    super.registerAllDependencies();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: super.generateRoute,
      theme: themeLight,
      darkTheme: themeDark,
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Avançar'),
              onPressed: () {
                EventBusController()
                    .emit<EventBusStates>(ShowTasksManagerState());
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Map<String, WidgetBuilderArgs> get baseRoutes => {};

  @override
  List<MicroApp> get microApps => [
        MicroAppTasksManagerResolver(),
      ];
}
