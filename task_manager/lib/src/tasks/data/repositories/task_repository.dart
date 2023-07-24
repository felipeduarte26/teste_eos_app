import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository_interface.dart';
import '../datasources/local/task_datasource.dart';

final class TaskRepository implements ITaskRepository {
  final ITaskDataSource _datasource;
  TaskRepository({required ITaskDataSource datasource})
      : _datasource = datasource;
  @override
  void createTask({required List<TaskEntity> task}) =>
      _datasource.createTask(task: task);

  @override
  Future<List<TaskEntity>> getList() async => await _datasource.getList();
}
