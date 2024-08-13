import 'package:commons/commons.dart';

import '../../../domain/entities/task_entity.dart';
import '../../models/models.dart';

abstract interface class ITaskDataSource {
  Future<void> createTask({required List<TaskEntity> task});
  Future<List<TaskEntity>> getList();
}

final class TaskDatasource implements ITaskDataSource {
  final ILocalStorage _storage;
  final _keyStorage = 'task';

  TaskDatasource({required ILocalStorage storage}) : _storage = storage;

  @override
  Future<void> createTask({required List<TaskEntity> task}) async {
    await _storage.initialize();

    final data =
        task.map((data) => TaskModel.fromEntity(data).toJson()).toList();

    _storage.saveList(
      key: _keyStorage,
      data: data,
    );
  }

  @override
  Future<List<TaskEntity>> getList() async {
    await _storage.initialize();
    final data = _storage.getList(key: _keyStorage);

    final List<TaskEntity> taskList = [];

    for (final item in data) {
      final entity = TaskModel.fromJson(item).toEntity();
      taskList.add(entity);
    }

    return taskList;
  }
}
