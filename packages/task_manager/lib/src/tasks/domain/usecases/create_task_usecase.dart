import '../entities/task_entity.dart';
import '../repositories/task_repository_interface.dart';

abstract interface class ICreateTaskUsecase {
  void call({required List<TaskEntity> task});
}

final class CreateTaskUsecase implements ICreateTaskUsecase {
  final ITaskRepository _repository;

  CreateTaskUsecase({required ITaskRepository repository})
      : _repository = repository;

  @override
  void call({required List<TaskEntity> task}) {
    _repository.createTask(task: task);
  }
}
