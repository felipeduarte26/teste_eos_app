import '../entities/task_entity.dart';

abstract interface class ITaskRepository {
  void createTask({required List<TaskEntity> task});
  Future<List<TaskEntity>> getList();
}
