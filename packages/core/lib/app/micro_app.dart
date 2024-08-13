import 'micro_app_utils.dart';

abstract class MicroApp {
  String get microAppName;

  Map<String, WidgetBuilderArgs> get routes;

  void Function() get injectionsRegister;

  void Function() get listenerRegister;
}
