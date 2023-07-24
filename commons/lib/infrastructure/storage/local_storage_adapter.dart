import 'package:dependencies/dependencies.dart';

import 'local_storage_interface.dart';

class LocalStorage implements ILocalStorage {
  Box? _box;
  @override
  void delete({required String key}) {
    _box?.delete(key);
  }

  @override
  List getList({required String key}) {
    final data = _box?.get(key) ?? [];
    return data;
  }

  @override
  Map<String, dynamic> getMap({required String key}) {
    return _box?.get(key);
  }

  @override
  Future<void> initialize() async {
    _box ??= await Hive.openBox('tasks_box');
  }

  @override
  void saveList({required String key, required List data}) {
    _box?.put(key, data);
  }

  @override
  void saveMap({required String key, required Map<String, dynamic> data}) {
    _box?.put(key, data);
  }
}
